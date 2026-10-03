import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../data/models/article_model.dart';

final bookmarkProvider = NotifierProvider<BookmarkNotifier, List<ArticleModel>>(() {
  return BookmarkNotifier();
});

class BookmarkNotifier extends Notifier<List<ArticleModel>> {
  final _box = Hive.box('bookmarks_box');

  @override
  List<ArticleModel> build() {
    return _loadBookmarks();
  }

  List<ArticleModel> _loadBookmarks() {
    final List<ArticleModel> loaded = [];
    for (var key in _box.keys) {
      try {
        // Assuming your ArticleModel has a fromJson method.
        final data = Map<String, dynamic>.from(_box.get(key));
        loaded.add(ArticleModel.fromJson(data));
      } catch (e) {
        // Skip if there's a formatting issue
      }
    }
    return loaded.reversed.toList(); // Show newest saves first
  }

  void toggleBookmark(ArticleModel article) {
    final isBookmarked = state.any((a) => a.title == article.title);

    if (isBookmarked) {
      // Remove from Hive
      final keyToRemove = _box.keys.firstWhere((k) {
        final item = Map<String, dynamic>.from(_box.get(k));
        return item['title'] == article.title;
      }, orElse: () => null);

      if (keyToRemove != null) _box.delete(keyToRemove);
      state = state.where((a) => a.title != article.title).toList();
    } else {
      // Add to Hive
      // Note: If your ArticleModel doesn't have a toJson() method,
      // let me know and we will map the fields manually!
      _box.add(article.toJson());
      state = [article, ...state];
    }
  }

  bool isBookmarked(ArticleModel article) {
    return state.any((a) => a.title == article.title);
  }
}