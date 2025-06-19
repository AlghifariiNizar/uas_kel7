import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkService with ChangeNotifier {
  static const _bookmarkKey = 'bookmarked_news_ids';

  List<String> _bookmarkedIds = [];

  List<String> get bookmarkedIds => _bookmarkedIds;

  Future<void> loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    _bookmarkedIds = prefs.getStringList(_bookmarkKey) ?? [];
    notifyListeners();
  }

  Future<void> _saveBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_bookmarkKey, _bookmarkedIds);
  }

  bool isBookmarked(String articleId) {
    return _bookmarkedIds.contains(articleId);
  }

  Future<void> toggleBookmark(String articleId) async {
    if (isBookmarked(articleId)) {
      _bookmarkedIds.remove(articleId);
    } else {
      _bookmarkedIds.add(articleId);
    }
    
    await _saveBookmarks();
    notifyListeners();
  }
}