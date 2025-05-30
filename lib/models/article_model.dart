class Article{
  final String id;
  final String title;
  final String snippet;
  final String imageUrl;
  final String date;
  final String category;
  final String source;
  final String fullContent;
  // bool isFavorite;

  Article({
    required this.id,
    required this.title,
    required this.snippet,
    required this.imageUrl,
    required this.date,
    required this.category,
    required this.source,
    required this.fullContent,
    // this.isFavorite = false,
  });
}