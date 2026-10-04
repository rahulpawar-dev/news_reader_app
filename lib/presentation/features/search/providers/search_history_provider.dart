import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final searchHistoryProvider = NotifierProvider<SearchHistoryNotifier, List<String>>(() {
  return SearchHistoryNotifier();
});

class SearchHistoryNotifier extends Notifier<List<String>> {
  // We use a new box for search history
  final _box = Hive.box('search_history_box');

  @override
  List<String> build() {
    return List<String>.from(_box.get('history', defaultValue: []));
  }

  void addSearchTerm(String term) {
    if (term.trim().isEmpty) return;

    final currentHistory = List<String>.from(state);
    // Remove if it already exists so we can move it to the top
    currentHistory.remove(term);
    currentHistory.insert(0, term); // Add to beginning

    state = currentHistory;
    _box.put('history', currentHistory);
  }

  void deleteSearchTerm(String term) {
    final currentHistory = List<String>.from(state)..remove(term);
    state = currentHistory;
    _box.put('history', currentHistory);
  }

  void clearAllHistory() {
    state = [];
    _box.delete('history');
  }
}