import 'package:freezed_annotation/freezed_annotation.dart';

part 'article_model.freezed.dart';
part 'article_model.g.dart';

@freezed
abstract class ArticleModel with _$ArticleModel {
  const factory ArticleModel({
    required String id,
    required String title,
    required String? description,
    required String? url,
    required String? urlToImage,
    required String? publishedAt,
    required String? sourceName,
    @Default(false) bool isBookmarked,
  }) = _ArticleModel;

  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleModelFromJson(json);
}