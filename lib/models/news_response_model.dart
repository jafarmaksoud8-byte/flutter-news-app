import 'package:project_2/models/article_model.dart';

class NewsResponseModel {
  final String status;
  final int totalResults;
  final List<ArticleModel> articles;

  NewsResponseModel({
    required this.status,
    required this.totalResults,
    required this.articles,
  });
  factory NewsResponseModel.fromJson(Map<String, dynamic> json) {
    List<ArticleModel> articles = [];
    if (json['articles'] != null) {
      for (var item in json['articles']) {
        ArticleModel articleModel = ArticleModel.fromJson(item);
        articles.add(articleModel);
      }
    }

    return NewsResponseModel(
      status: json['status'] ?? 'No Status',
      totalResults: json['totalResults'] ?? 0,
      articles: articles,
    );
  }
}
