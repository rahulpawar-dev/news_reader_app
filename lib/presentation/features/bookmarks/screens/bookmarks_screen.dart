import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/bookmark_provider.dart';
import '../../../widgets/article_card.dart';

class BookmarksScreen extends ConsumerWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarkedArticles = ref.watch(bookmarkProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Articles'),
      ),
      body: bookmarkedArticles.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.bookmark_border, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              'No saved articles yet.',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.grey),
            ),
          ],
        ),
      )
          : ListView.builder(
        itemCount: bookmarkedArticles.length,
        itemBuilder: (context, index) {
          final article = bookmarkedArticles[index];
          return Dismissible(
            key: Key(article.title),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              child: const Icon(Icons.delete, color: Colors.white, size: 30),
            ), // ✅ Closed the container properly
            onDismissed: (direction) {
              // ✅ Actually removes the bookmark from Hive
              ref.read(bookmarkProvider.notifier).toggleBookmark(article);

              // Show a quick popup confirming deletion
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Bookmark removed')),
              );
            },
            // ✅ The child property holds the ArticleCard!
            child: ArticleCard(
              article: article,
              onTap: () {
                context.push('/article-detail', extra: article);
              },
            ),
          );
        },
      ),
    );
  }
}