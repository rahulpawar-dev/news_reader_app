import '../../data/models/article_model.dart';

abstract class NewsRepository {
  Future<List<ArticleModel>> getTopHeadlines({int page = 1});
  Future<List<ArticleModel>> searchArticles(String query, {int page = 1});
}