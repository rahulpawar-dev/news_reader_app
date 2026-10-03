import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/models/article_model.dart';
import '../../../../data/repositories/news_repository_impl.dart';

final searchProvider = AsyncNotifierProvider<SearchNotifier, List<ArticleModel>>(() {
  return SearchNotifier();
});

class SearchNotifier extends AsyncNotifier<List<ArticleModel>> {
  @override
  Future<List<ArticleModel>> build() async {
    return []; // Start with an empty list before they search
  }

  Future<void> searchArticles(String query) async {
    if (query.trim().isEmpty) {
      state = const AsyncData([]);
      return;
    }

    state = const AsyncLoading(); // Show loading spinner
    state = await AsyncValue.guard(() async {
      final repository = ref.read(newsRepositoryProvider);
      // We are just fetching page 1 for search in this assessment
      return await repository.searchArticles(query, page: 1);
    });
  }
}