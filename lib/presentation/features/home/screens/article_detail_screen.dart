import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/models/article_model.dart';
// Note: Make sure this import matches exactly where your bookmarkProvider lives!
import '../../bookmarks/providers/bookmark_provider.dart';
// import '../../bookmarks/providers/bookmarks_provider.dart';

class ArticleDetailScreen extends ConsumerWidget {
  final ArticleModel article;

  // Since you use Freezed, your model is immutable, so we can use 'const' here again!
  const ArticleDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. WATCH THE STATE: This is the magic line that makes the icon change instantly!
    final bookmarkedArticles = ref.watch(bookmarkProvider);
    final isBookmarked = bookmarkedArticles.any((a) => a.title == article.title);

    // 2. Safely handle nulls based on your Freezed model
    final date = article.publishedAt != null
        ? article.publishedAt!.split('T').first
        : 'Unknown Date';

    final description = article.description ?? 'No detailed description available.';
    final source = article.sourceName ?? 'Unknown Source';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Article Details'),
        actions: [
          // 3. The Bookmark Button
          IconButton(
            icon: Icon(
              isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: isBookmarked ? Theme.of(context).colorScheme.primary : null,
            ),
            onPressed: () {
              // Call the toggle function
              ref.read(bookmarkProvider.notifier).toggleBookmark(article);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.urlToImage != null && article.urlToImage!.isNotEmpty)
              Image.network(
                article.urlToImage!,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 250,
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.broken_image, size: 50),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.business, size: 16, color: Colors.grey.shade600),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          source,
                          style: TextStyle(color: Colors.grey.shade600),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(Icons.calendar_today, size: 16, color: Colors.grey.shade600),
                      const SizedBox(width: 4),
                      Text(
                        date,
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                  const Divider(height: 32),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      height: 1.6,
                    ),
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