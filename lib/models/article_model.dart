class ArticleModel {
  final String title;
  final String author;
  final String description;
  final String urlToImage;
  final String publishedAt;
  final String url;

  ArticleModel({
    required this.title,
    required this.author,
    required this.description,
    required this.urlToImage,
    required this.publishedAt,
    required this.url,
  });
  //from json
  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      title: json['title'] ?? 'No Title',
      author: json['author'] ?? 'No Author',
      description: json['description'] ?? 'No Description',
      urlToImage: json['urlToImage'] ?? 'No Image',
      publishedAt: json['publishedAt'] ?? 'No Date',
      url: json['url'] ?? 'No Url',
    );
  }
}
