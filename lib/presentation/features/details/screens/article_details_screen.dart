import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/models/article_model.dart';
import '../../bookmarks/providers/bookmark_provider.dart';
import 'package:intl/intl.dart';

class ArticleDetailsScreen extends ConsumerWidget {
  final ArticleModel article;

  const ArticleDetailsScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = article.publishedAt != null
        ? DateFormat.yMMMd().format(DateTime.parse(article.publishedAt!))
        : 'Unknown Date';

    final isSaved = ref.watch(bookmarkProvider.notifier).isBookmarked(article);
    ref.watch(bookmarkProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Article Details'),
        actions: [
          IconButton(
            icon: Icon(isSaved ? Icons.bookmark : Icons.bookmark_border),
            onPressed: () {
              ref.read(bookmarkProvider.notifier).toggleBookmark(article);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(isSaved ? 'Removed from Bookmarks' : 'Saved to Bookmarks'),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.urlToImage != null)
              Image.network(
                article.urlToImage!,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
                // Fixed the multiple underscores warning here
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 250,
                  color: Colors.grey[300],
                  child: const Center(child: Icon(Icons.broken_image, size: 50)),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          article.sourceName ?? 'Unknown Source',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.deepPurple),
                        ),
                      ),
                      Text(date, style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                  const Divider(height: 32, thickness: 1),
                  // Removed the reference to article.content
                  Text(
                    article.description ?? 'No content available for this article.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}