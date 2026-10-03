import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/article_model.dart';

final newsLocalDataSourceProvider = Provider<NewsLocalDataSource>((ref) {
  return NewsLocalDataSourceImpl();
});

abstract class NewsLocalDataSource {
  Future<void> init();
  Future<void> cacheArticles(List<ArticleModel> articles);
  Future<List<ArticleModel>> getCachedArticles();
  Future<void> toggleBookmark(ArticleModel article);
  Future<List<ArticleModel>> getBookmarkedArticles();
}

class NewsLocalDataSourceImpl implements NewsLocalDataSource {
  static const String _boxName = 'news_box';
  static const String _cacheKey = 'cached_articles';
  static const String _bookmarksKey = 'bookmarked_articles';

  @override
  Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(_boxName);
  }

  @override
  Future<void> cacheArticles(List<ArticleModel> articles) async {
    final box = Hive.box(_boxName);
    // Convert to JSON strings for easy Hive storage
    final List<String> jsonList = articles.map((a) => jsonEncode(a.toJson())).toList();
    await box.put(_cacheKey, jsonList);
  }

  @override
  Future<List<ArticleModel>> getCachedArticles() async {
    final box = Hive.box(_boxName);
    final List<String>? jsonList = box.get(_cacheKey)?.cast<String>();
    if (jsonList != null) {
      return jsonList.map((str) => ArticleModel.fromJson(jsonDecode(str))).toList();
    }
    return [];
  }

  @override
  Future<void> toggleBookmark(ArticleModel article) async {
    final box = Hive.box(_boxName);
    final List<String> currentBookmarks = box.get(_bookmarksKey)?.cast<String>() ?? [];

    // Ensure the bookmarked flag is true
    final articleJson = jsonEncode(article.copyWith(isBookmarked: true).toJson());

    // Check if it's already bookmarked by comparing IDs
    final existingIndex = currentBookmarks.indexWhere((str) {
      final decoded = jsonDecode(str);
      return decoded['id'] == article.id;
    });

    if (existingIndex >= 0) {
      currentBookmarks.removeAt(existingIndex); // Remove bookmark[cite: 2]
    } else {
      currentBookmarks.add(articleJson); // Bookmark article[cite: 2]
    }

    // Persist after modifying[cite: 2]
    await box.put(_bookmarksKey, currentBookmarks);
  }

  @override
  Future<List<ArticleModel>> getBookmarkedArticles() async {
    final box = Hive.box(_boxName);
    final List<String>? jsonList = box.get(_bookmarksKey)?.cast<String>();
    if (jsonList != null) {
      return jsonList.map((str) => ArticleModel.fromJson(jsonDecode(str))).toList();
    }
    return [];
  }
}