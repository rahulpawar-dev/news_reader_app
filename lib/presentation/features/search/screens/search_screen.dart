import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:news_reader_app/presentation/features/search/screens/search_provider.dart';

import '../../../widgets/article_card.dart';


class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch() {
    FocusScope.of(context).unfocus(); // Hide keyboard
    if (_searchController.text.trim().isNotEmpty) {
      ref.read(searchProvider.notifier).searchArticles(_searchController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(searchProvider);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search for news...',
            border: InputBorder.none,
          ),
          textInputAction: TextInputAction.search,
          onSubmitted: (_) => _performSearch(), // Search when hitting enter on keyboard
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _performSearch,
          ),
        ],
      ),
      body: searchState.when(
        data: (articles) {
          if (articles.isEmpty && _searchController.text.isNotEmpty) {
            return const Center(child: Text('No results found.'));
          } else if (articles.isEmpty) {
            return const Center(child: Text('Type a keyword to search.'));
          }
          return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              return ArticleCard(
                article: articles[index],
                onTap: () {
                  context.push('/details', extra: articles[index]);
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
}