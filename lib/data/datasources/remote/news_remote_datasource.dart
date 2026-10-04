import 'dart:developer' as developer;
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/article_model.dart';
import '../../../core/error/failures.dart';

final newsRemoteDataSourceProvider = Provider<NewsRemoteDataSource>((ref) {
  return NewsRemoteDataSourceImpl(dio: Dio());
});

abstract class NewsRemoteDataSource {
  Future<List<ArticleModel>> getTopHeadlines(int page);
  Future<List<ArticleModel>> searchArticles(String query, int page);
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final Dio dio;

  NewsRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<ArticleModel>> getTopHeadlines(int page) async {
    try {
      final response = await dio.get(
        // 'https://api.spaceflightnewsapi.net/v4/articles',
        'https://api.currentsapi.services/v1/latest-news',
        // 'https://newsdata.io/api/1/news',
        queryParameters: {
          'limit': 10,
          'offset': (page - 1) * 10
        },
      );

      if (response.statusCode == 200) {
        final List data = response.data['results'];
        return data.map((json) {
          final Map<String, dynamic> mapped = Map<String, dynamic>.from(json);
          // Safely map types to prevent JSON parsing crashes
          mapped['id'] = mapped['id']?.toString() ?? DateTime.now().millisecondsSinceEpoch.toString();
          mapped['urlToImage'] = mapped['image_url'] ?? '';
          mapped['sourceName'] = mapped['news_site'] ?? 'Spaceflight News';
          mapped['description'] = mapped['summary'] ?? '';
          mapped['publishedAt'] = mapped['published_at'] ?? DateTime.now().toIso8601String();
          mapped['content'] = mapped['summary'] ?? '';
          mapped['author'] = mapped['news_site'] ?? 'Staff';

          return ArticleModel.fromJson(mapped);
        }).toList();
      } else {
        throw const ServerFailure('Failed to load real-time news');
      }
    } catch (e, stackTrace) {
      developer.log('API FETCH ERROR: $e', error: e, stackTrace: stackTrace);
      print('API FETCH ERROR: $e'); // Displays directly in your terminal
      throw const NetworkFailure('Network connection failed');
    }
  }

  @override
  Future<List<ArticleModel>> searchArticles(String query, int page) async {
    try {
      final response = await dio.get(
        'https://api.spaceflightnewsapi.net/v4/articles',
        queryParameters: {
          'search': query,
          'limit': 10,
          'offset': (page - 1) * 10,
        },
      );

      if (response.statusCode == 200) {
        final List data = response.data['results'];
        return data.map((json) {
          final Map<String, dynamic> mapped = Map<String, dynamic>.from(json);
          mapped['id'] = mapped['id']?.toString() ?? DateTime.now().millisecondsSinceEpoch.toString();
          mapped['urlToImage'] = mapped['image_url'] ?? '';
          mapped['sourceName'] = mapped['news_site'] ?? 'Spaceflight News';
          mapped['description'] = mapped['summary'] ?? '';
          mapped['publishedAt'] = mapped['published_at'] ?? DateTime.now().toIso8601String();
          mapped['content'] = mapped['summary'] ?? '';
          mapped['author'] = mapped['news_site'] ?? 'Staff';

          return ArticleModel.fromJson(mapped);
        }).toList();
      } else {
        throw const ServerFailure('Failed to load search results');
      }
    } catch (e, stackTrace) {
      developer.log('API SEARCH ERROR: $e', error: e, stackTrace: stackTrace);
      print('API SEARCH ERROR: $e');
      throw const NetworkFailure('Network connection failed');
    }
  }
}