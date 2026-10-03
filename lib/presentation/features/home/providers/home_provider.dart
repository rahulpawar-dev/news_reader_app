import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/models/article_model.dart';
import '../../../../data/repositories/news_repository_impl.dart';

final homeProvider = AsyncNotifierProvider<HomeNotifier, List<ArticleModel>>(() {
  return HomeNotifier();
});

class HomeNotifier extends AsyncNotifier<List<ArticleModel>> {
  int _currentPage = 1;
  bool _hasMore = true;
  bool _isFetchingMore = false;

  @override
  Future<List<ArticleModel>> build() async {
    _currentPage = 1;
    _hasMore = true;
    return _fetchArticles(page: _currentPage);
  }

  Future<List<ArticleModel>> _fetchArticles({required int page}) async {
    final repository = ref.read(newsRepositoryProvider);
    return await repository.getTopHeadlines(page: page);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      _currentPage = 1;
      _hasMore = true;
      return _fetchArticles(page: _currentPage);
    });
  }

  Future<void> fetchNextPage() async {
    if (_isFetchingMore || !_hasMore || state.hasError) return;

    _isFetchingMore = true;
    _currentPage++;

    try {
      final newArticles = await _fetchArticles(page: _currentPage);
      if (newArticles.isEmpty) {
        _hasMore = false;
      } else {
        state = AsyncData([...state.value ?? [], ...newArticles]);
      }
    } catch (e, st) {
      state = AsyncError(e, st);
    } finally {
      _isFetchingMore = false;
    }
  }
}