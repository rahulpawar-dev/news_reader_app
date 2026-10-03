import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/error/failures.dart';
import '../../../core/constants/app_constants.dart';
import '../../models/article_model.dart';

final newsRemoteDataSourceProvider = Provider<NewsRemoteDataSource>((ref) {
  return NewsRemoteDataSourceImpl(ref.read(dioProvider));
});

abstract class NewsRemoteDataSource {
  Future<List<ArticleModel>> getTopHeadlines(int page);
  Future<List<ArticleModel>> searchArticles(String query, int page);
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final Dio dio;

  NewsRemoteDataSourceImpl(this.dio);

  @override
  Future<List<ArticleModel>> getTopHeadlines(int page) async {
    return _fetchNews('/top-headlines', {'country': 'us', 'page': page});
  }

  @override
  Future<List<ArticleModel>> searchArticles(String query, int page) async {
    return _fetchNews('/everything', {'q': query, 'page': page});
  }

  Future<List<ArticleModel>> _fetchNews(String endpoint, Map<String, dynamic> queryParams) async {
    try {
      queryParams['apiKey'] = AppConstants.apiKey;
      final response = await dio.get('${AppConstants.baseUrl}$endpoint', queryParameters: queryParams);

      if (response.statusCode == 200) {
        final List articlesJson = response.data['articles'];
        return articlesJson
            .map((json) {
          // Map NewsAPI structure to our model
          return ArticleModel(
            id: json['url'] ?? DateTime.now().toString(),
            title: json['title'] ?? 'No Title',
            description: json['description'],
            url: json['url'],
            urlToImage: json['urlToImage'],
            publishedAt: json['publishedAt'],
            sourceName: json['source']?['name'],
          );
        })
            .where((article) => article.title != '[Removed]') // Filter out removed articles
            .toList();
      } else {
        throw const ServerFailure();
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.receiveTimeout) {
        throw const TimeoutFailure();
      } else if (e.type == DioExceptionType.connectionError) {
        throw const NetworkFailure();
      }
      throw ServerFailure(e.message ?? 'Unknown network error');
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}