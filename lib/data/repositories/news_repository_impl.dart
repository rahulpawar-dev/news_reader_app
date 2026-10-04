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

      if (page == 1) {
        await localDataSource.cacheArticles(remoteArticles);
      }
      return await _mergeWithBookmarks(remoteArticles);
    } on NetworkFailure {
      // 1. Try returning cached articles if available
      final cachedArticles = await localDataSource.getCachedArticles();
      if (cachedArticles.isNotEmpty) {
        return await _mergeWithBookmarks(cachedArticles);
      }
      // 2. Fallback to mock headlines if no cache exists
      return await _mergeWithBookmarks(_generateDummyHeadlines(page));
    } catch (_) {
      return await _mergeWithBookmarks(_generateDummyHeadlines(page));
    }
  }

  @override
  Future<List<ArticleModel>> searchArticles(String query, {int page = 1}) async {
    try {
      final remoteArticles = await remoteDataSource.searchArticles(query, page);
      return await _mergeWithBookmarks(remoteArticles);
    } on NetworkFailure {
      // Return search dummy data when offline or network fails
      return await _mergeWithBookmarks(_generateDummySearchResults(query));
    } catch (_) {
      return await _mergeWithBookmarks(_generateDummySearchResults(query));
    }
  }

  // Helper to ensure articles correctly display their bookmark status
  Future<List<ArticleModel>> _mergeWithBookmarks(List<ArticleModel> articles) async {
    final bookmarked = await localDataSource.getBookmarkedArticles();
    final bookmarkedIds = bookmarked.map((b) => b.id).toSet();

    return articles.map((article) {
      return article.copyWith(isBookmarked: bookmarkedIds.contains(article.id));
    }).toList();
  }

  // Mock search results generator
  List<ArticleModel> _generateDummySearchResults(String query) {
    return List.generate(10, (index) {
      return ArticleModel(
        id: 'search_${query}_$index',
        title: 'Search Result ${index + 1} for "$query"',
        description: 'Mock article preview for query "$query" to verify search UI and bookmark actions.',
        urlToImage: 'https://picsum.photos/seed/search$index/500/300',
        publishedAt: DateTime.now().subtract(Duration(hours: index + 1)).toIso8601String(),
        sourceName: 'Search System', url: '',
      );
    });
  }

  // Mock headlines generator
  List<ArticleModel> _generateDummyHeadlines(int page) {
    return List.generate(20, (index) {
      final id = (page - 1) * 20 + index;
      return ArticleModel(
        id: 'headline_$id',
        title: 'Top Story $id: Offline News & Headlines',
        description: 'Auto-generated fallback news item demonstrating seamless offline handling.',
        urlToImage: id % 4 == 0 ? null : 'https://picsum.photos/seed/news$id/500/300',
        publishedAt: DateTime.now().subtract(Duration(hours: id)).toIso8601String(),
        sourceName: 'Daily Fallback', url: '',
      );
    });
  }
}