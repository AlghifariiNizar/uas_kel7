class Article{
  final String id;
  final String title;
  final String snippet;
  final String imageUrl;
  final String date;
  // bool isFavorite;

  Article({
    required this.id,
    required this.title,
    required this.snippet,
    required this.imageUrl,
    required this.date,
    // this.isFavorite = false,
  });
}