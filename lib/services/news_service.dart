import 'package:flutter/foundation.dart';
import 'package:uas_kel7/models/news_article.dart';
import 'package:uas_kel7/services/api_service.dart';

class NewsService with ChangeNotifier {
  List<NewsArticle> _allNews = [];
  bool _isLoading = false;

  List<NewsArticle> get allNews => _allNews;
  bool get isLoading => _isLoading;

  Future<void> fetchAllNews(String? token) async {
    // Hanya fetch jika daftar berita masih kosong
    if (_allNews.isEmpty) {
      _isLoading = true;
      notifyListeners();

      try {
        _allNews = await ApiService(token).getNews();
      } catch (e) {
        print("Error fetching all news: $e");
        // Anda bisa menambahkan penanganan error di sini
      }

      _isLoading = false;
      notifyListeners();
    }
  }
}
