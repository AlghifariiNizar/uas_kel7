// lib/views/home_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:uas_kel7/routes/route_names.dart';
import '../models/article_model.dart';
import '../data/article_data.dart';
import '../services/favorite_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List<String> favoriteArticleIds = [];
  int _currentIndex = 0; // Untuk BottomNavigationBar
  final FavoriteService _favoriteService = FavoriteService();

  @override
  void initState() {
    super.initState();
    _favoriteService.addListener(_onFavoritesChanged);
  }

  @override
  void dispose() {
    _favoriteService.removeListener(_onFavoritesChanged);
    super.dispose();
  }

  void _onFavoritesChanged() {
    if (mounted) {
      setState(() {
      });
    }
  }


  void _toggleFavorite(String articleId) {
    _favoriteService.toggleFavorite(articleId); 
    if (_favoriteService.isFavorite(articleId)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Artikel ditambahkan ke favorit'), duration: Duration(seconds: 1)),
        );
    } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Artikel dihapus dari favorit'), duration: Duration(seconds: 1)),
        );
    }
  }

  bool _isFavorite(String articleId) {
    return _favoriteService.isFavorite(articleId);
  }

  void _onBottomNavTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    switch (index) {
      case 0:
        // context.goNamed(RouteNames.home);
        break;
      case 1:
        context.goNamed(RouteNames.explore);
        break;
      case 2:
        context.goNamed(RouteNames.favorites);
        break;
      case 3:
        context.goNamed(RouteNames.profile); 
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Article mainArticle = dummyArticles.isNotEmpty ? dummyArticles.first : Article(id: '', title: 'Kosong', snippet: '', imageUrl: '', date: '');
    final List<Article> otherArticles = dummyArticles.length > 1 ? dummyArticles.sublist(1) : [];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Row(
            children: [
              Container(
                width: 80.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 47, 12, 243),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Center(
                  child: Text(
                    'Logo',
                    style: TextStyle(color: Colors.white, fontSize: 10.sp, fontWeight: FontWeight.normal),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              // Search Bar
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    context.goNamed(RouteNames.explore);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: Colors.grey[600], size: 16.sp),
                        SizedBox(width: 8.w),
                        Text(
                          'Search..',
                          style: TextStyle(color: Colors.grey[600], fontSize: 10.sp),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          if (dummyArticles.isNotEmpty) _buildMainArticleCard(context, mainArticle),
          SizedBox(height: 20.h),
          if (otherArticles.isNotEmpty)
            ...otherArticles.map((article) => _buildArticleListItem(context, article)).toList(),
          if (dummyArticles.isEmpty)
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 50.h),
                child: Text("Tidak ada artikel tersedia.", style: TextStyle(fontSize: 16.sp, color: Colors.grey)),
              )
            )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onBottomNavTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color.fromARGB(255, 47, 12, 243),
        unselectedItemColor: Colors.grey, 
        selectedFontSize: 12.sp,
        unselectedFontSize: 12.sp,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            activeIcon: Icon(Icons.search),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_outline),
            activeIcon: Icon(Icons.bookmark),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildMainArticleCard(BuildContext context, Article article) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            article.imageUrl,
            width: double.infinity,
            height: 200.h,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: double.infinity,
                height: 200.h,
                color: Colors.grey[300],
                child: Icon(Icons.broken_image, size: 50.sp, color: Colors.grey[600]),
              );
            },
            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return SizedBox(
                width: double.infinity,
                height: 200.h,
                child: Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                ),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.title,
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 6.h),
                Text(
                  article.snippet,
                  style: TextStyle(fontSize: 10.sp, color: Colors.grey[700]),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      article.date,
                      style: TextStyle(fontSize: 8.sp, color: Colors.grey[600]),
                    ),
                    IconButton(
                      icon: Icon(
                        _isFavorite(article.id) ? Icons.bookmark : Icons.bookmark_border,
                        color: _isFavorite(article.id) ? const Color.fromARGB(255, 47, 12, 243) : Colors.grey,
                        size: 16.sp,
                      ),
                      onPressed: () => _toggleFavorite(article.id),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArticleListItem(BuildContext context, Article article) {
    return Card(
      elevation: 1.0,
      margin: EdgeInsets.only(bottom: 16.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          // Navigasi ke detail artikel
          // context.goNamed(RouteNames.articleDetail, params: {'id': article.id});
           ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(content: Text('Navigasi ke detail artikel: ${article.title}'), duration: const Duration(seconds: 1)),
           );
        },
        child: Padding(
          padding: EdgeInsets.all(10.w),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.network(
                  article.imageUrl,
                  width: 100.w,
                  height: 80.h,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 100.w,
                      height: 80.h,
                      color: Colors.grey[200],
                      child: Icon(Icons.broken_image, size: 30.sp, color: Colors.grey[500]),
                    );
                  },
                   loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return SizedBox(
                      width: 100.w,
                      height: 80.h,
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      article.title,
                      style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      article.date,
                      style: TextStyle(fontSize: 10.sp, color: Colors.grey[600]),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  _isFavorite(article.id) ? Icons.bookmark : Icons.bookmark_border,
                  color: _isFavorite(article.id) ? const Color.fromARGB(255, 47, 12, 243) : Colors.grey,
                  size: 16.sp,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () => _toggleFavorite(article.id),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
