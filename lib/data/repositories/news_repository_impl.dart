import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/repositories/news_repository.dart';
import '../datasources/remote/news_remote_datasource.dart';
import '../datasources/local/news_local_datasource.dart';
import '../models/article_model.dart';
import '../../../core/error/failures.dart';

final newsRepositoryProvider = Provider<NewsRepository>((ref) {
  return NewsRepositoryImpl(
    ref.read(newsRemoteDataSourceProvider),
    ref.read(newsLocalDataSourceProvider),
  );
});

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;
  final NewsLocalDataSource localDataSource;

  NewsRepositoryImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<List<ArticleModel>> getTopHeadlines({int page = 1}) async {
    try {
      final remoteArticles = await remoteDataSource.getTopHeadlines(page);

      // Cache the first page for offline reading
      if (page == 1) {
        await localDataSource.cacheArticles(remoteArticles);
      }
      return _mergeWithBookmarks(remoteArticles);

    } on NetworkFailure {
      // If offline, return cached articles[cite: 2]
      final cachedArticles = await localDataSource.getCachedArticles();
      if (cachedArticles.isEmpty) {
        throw const CacheFailure('No offline articles available.');
      }
      return _mergeWithBookmarks(cachedArticles);
    }
  }

  @override
  Future<List<ArticleModel>> searchArticles(String query, {int page = 1}) async {
    // Search requires an API call. We do not cache search results.
    final remoteArticles = await remoteDataSource.searchArticles(query, page);
    return _mergeWithBookmarks(remoteArticles);
  }

  // Helper to ensure articles correctly display their bookmark status
  Future<List<ArticleModel>> _mergeWithBookmarks(List<ArticleModel> articles) async {
    final bookmarked = await localDataSource.getBookmarkedArticles();
    final bookmarkedIds = bookmarked.map((b) => b.id).toSet();

    return articles.map((article) {
      return article.copyWith(isBookmarked: bookmarkedIds.contains(article.id));
    }).toList();
  }
}