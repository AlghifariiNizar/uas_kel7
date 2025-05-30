// lib/services/favorite_service.dart
import 'package:flutter/foundation.dart';
import '../models/article_model.dart';
import '../data/article_data.dart';

class FavoriteService extends ChangeNotifier {
  static final FavoriteService _instance = FavoriteService._internal();
  factory FavoriteService() {
    return _instance;
  }
  FavoriteService._internal();

  final List<String> _favoriteArticleIds = [];

  List<String> get favoriteArticleIds => List.unmodifiable(_favoriteArticleIds);

  List<Article> get favoriteArticles {
    return dummyArticles.where((article) => _favoriteArticleIds.contains(article.id)).toList();
  }

  bool isFavorite(String articleId) {
    return _favoriteArticleIds.contains(articleId);
  }

  void toggleFavorite(String articleId) {
    if (isFavorite(articleId)) {
      _favoriteArticleIds.remove(articleId);
    } else {
      _favoriteArticleIds.add(articleId);
    }
    notifyListeners();
  }
}
