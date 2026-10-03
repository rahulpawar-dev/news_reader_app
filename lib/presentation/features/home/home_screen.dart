import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/article_card.dart';
import '../auth/providers/home_provider.dart';
import '../../../../core/theme/theme_provider.dart';
import 'package:go_router/go_router.dart';
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      ref.read(homeProvider.notifier).fetchNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final newsState = ref.watch(homeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Headlines'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              context.push('./search');
            },

          ),

          //  this button we are using for theme
          IconButton(
            icon: Icon(
              ref.watch(themeProvider) == ThemeMode.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () {
              ref.read(themeProvider.notifier).toggleTheme();
            },
          ),
        ],
      ),
      body: newsState.when(
        data: (articles) {
          if (articles.isEmpty) {
            return const Center(child: Text('No articles found.')); // Empty state[cite: 2]
          }
          return RefreshIndicator(
            onRefresh: () => ref.read(homeProvider.notifier).refresh(),
            child: ListView.builder(
              controller: _scrollController,
              itemCount: articles.length + 1,
              itemBuilder: (context, index) {
                if (index == articles.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()), // Infinite scroll loading[cite: 2]
                  );
                }
                return ArticleCard(
                  article: articles[index],
                  onTap: () {
                    // TODO: Open article
                    context.push('/details', extra: articles[index]);
                  },
                );
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()), // Loading indicator[cite: 2]
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Failed to load news.', style: Theme.of(context).textTheme.titleLarge), // Error state[cite: 2]
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.read(homeProvider.notifier).refresh(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}