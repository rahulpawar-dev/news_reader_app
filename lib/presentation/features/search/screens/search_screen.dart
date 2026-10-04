import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:news_reader_app/presentation/features/search/screens/search_provider.dart';

// ✅ Make sure you import your new history provider!
import '../providers/search_history_provider.dart';
import '../../../widgets/article_card.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // This listener makes sure the UI updates instantly when you clear the search box
    _searchController.addListener(() {
      if (_searchController.text.isEmpty) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch() {
    FocusScope.of(context).unfocus(); // Hide keyboard
    final query = _searchController.text.trim();

    if (query.isNotEmpty) {
      //1. Add to search history
      ref.read(searchHistoryProvider.notifier).addSearchTerm(query);
      //2. Perform the actual search
      ref.read(searchProvider.notifier).searchArticles(query);
    }
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(searchProvider);
    final searchHistory = ref.watch(searchHistoryProvider); // Watch the history

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search for news...',
            border: InputBorder.none,
            // Add a clear button when typing
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _searchController.clear();
                setState(() {});
              },
            )
                : null,
          ),
          textInputAction: TextInputAction.search,
          onSubmitted: (_) => _performSearch(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _performSearch,
          ),
        ],
      ),

      // Here is the fixed body logic!
      body: _searchController.text.isEmpty
          ? _buildSearchHistory(searchHistory, ref) // Show history if typing nothing
          : searchState.when(
        data: (articles) {
          if (articles.isEmpty) {
            return const Center(child: Text('No results found.'));
          }
          return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              return ArticleCard(
                article: articles[index],
                onTap: () {
                  context.push('/article-detail', extra: articles[index]);
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Error: ${error.toString()}'),
        ),
      ),
    );
  }

  //  The new widget that displays your Search History list
  Widget _buildSearchHistory(List<String> history, WidgetRef ref) {
    if (history.isEmpty) {
      return const Center(child: Text('Type a keyword to search.'));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Recent Searches', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              TextButton(
                onPressed: () => ref.read(searchHistoryProvider.notifier).clearAllHistory(),
                child: const Text('Clear All', style: TextStyle(color: Colors.red)),
              )
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: history.length,
            itemBuilder: (context, index) {
              final term = history[index];
              return ListTile(
                leading: const Icon(Icons.history),
                title: Text(term),
                trailing: IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: () {
                    ref.read(searchHistoryProvider.notifier).deleteSearchTerm(term);
                  },
                ),
                onTap: () {
                  // Tap a history item to search it again automatically
                  _searchController.text = term;
                  _performSearch();
                },
              );
            },
          ),
        ),
      ],
    );
  }
}