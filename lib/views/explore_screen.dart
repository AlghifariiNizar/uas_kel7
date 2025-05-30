// lib/views/explore_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:uas_kel7/routes/route_names.dart';
import '../models/article_model.dart';
import '../data/article_data.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  List<String> favoriteArticleIds = [];
  int _currentIndex = 1;
  final TextEditingController _searchController = TextEditingController();
  String _currentSearchText = "";

  final List<Map<String, dynamic>> categories = [
    {'name': 'Economy', 'icon': Icons.account_balance_wallet_outlined},
    {'name': 'Politics', 'icon': Icons.gavel_outlined},
    {'name': 'Sports', 'icon': Icons.sports_soccer_outlined},
    {'name': 'Education', 'icon': Icons.school_outlined},
    {'name': 'Technology', 'icon': Icons.computer_outlined},
    {'name': 'Entertainment', 'icon': Icons.movie_filter_outlined},
    {'name': 'Health', 'icon': Icons.healing_outlined},
    {'name': 'Crime & Law', 'icon': Icons.local_police_outlined},
    {'name': 'Travel & Culture', 'icon': Icons.flight_takeoff_outlined},
  ];

  late List<Article> _displayedArticles;

  @override
  void initState() {
    super.initState();
    _displayedArticles = dummyArticles.take(3).toList();
    _searchController.addListener(() {
      setState(() {
        _currentSearchText = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggleFavorite(String articleId) {
    setState(() {
      if (favoriteArticleIds.contains(articleId)) {
        favoriteArticleIds.remove(articleId);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Artikel dihapus dari favorit'), duration: Duration(seconds: 1)),
        );
      } else {
        favoriteArticleIds.add(articleId);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Artikel ditambahkan ke favorit'), duration: Duration(seconds: 1)),
        );
      }
    });
  }

  bool _isFavorite(String articleId) {
    return favoriteArticleIds.contains(articleId);
  }

  void _onBottomNavTapped(int index) {
    if (_currentIndex == index) return;

    setState(() {
      _currentIndex = index;
    });
    switch (index) {
      case 0:
        context.goNamed(RouteNames.home);
        break;
      case 1:
        // Sudah di Explore
        break;
      case 2:
        context.goNamed(RouteNames.favorites);
        break;
      case 3:
        // untuk RouteNames.profile
        // context.goNamed(RouteNames.profile);
        ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(content: Text('Halaman Profil belum diimplementasikan'), duration: Duration(seconds: 1)),
        );
        break;
    }
  }

  void _navigateToCategoryResult(String categoryName) {
    // context.goNamed(RouteNames.categoryResults, params: {'categoryName': categoryName});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Navigasi ke kategori: $categoryName (Belum diimplementasikan)'), duration: const Duration(seconds: 1)),
    );
  }


  @override
  Widget build(BuildContext context) {
    final List<Article> trendingArticles = dummyArticles.take(3).toList();

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Text(
                'Explore',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
            ),

            Container(
              margin: EdgeInsets.symmetric(vertical: 10.h),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search..',
                  hintStyle: TextStyle(color: Colors.grey[600], fontSize: 14.sp),
                  prefixIcon: Icon(Icons.search, color: Colors.grey[600], size: 20.sp),
                  suffixIcon: _currentSearchText.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear, color: Colors.grey[600], size: 20.sp),
                          onPressed: () {
                            _searchController.clear();
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.r),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.r),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.r),
                    borderSide: BorderSide(color: Colors.deepPurple, width: 1.5),
                  ),
                ),
                style: TextStyle(fontSize: 14.sp, color: Colors.black87),
                onChanged: (value) {
                  // setState(() {
                  //   _currentSearchText = value; // Sudah ditangani oleh listener controller
                  // });
                  print('Current text: $value');
                },
                onSubmitted: (value) {
                  print('Submitted text: $value');
                  FocusScope.of(context).unfocus();
                },
              ),
            ),
            SizedBox(height: 16.h),

            Text(
              'Category',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),

            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: categories.map((category) {
                return ActionChip(
                  avatar: Icon(category['icon'] as IconData, size: 18.sp, color: Colors.white),
                  label: Text(
                    category['name'] as String,
                    style: TextStyle(color: Colors.white, fontSize: 13.sp),
                  ),
                  backgroundColor: Colors.deepPurple,
                  onPressed: () {
                    _navigateToCategoryResult(category['name'] as String);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                );
              }).toList(),
            ),
            SizedBox(height: 24.h),

            Text(
              'Trending',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),

            if (trendingArticles.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: trendingArticles.length,
                itemBuilder: (context, index) {
                  final article = trendingArticles[index];
                  return _buildTrendingArticleItem(context, article);
                },
              )
            else
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Center(child: Text("Tidak ada artikel trending.", style: TextStyle(fontSize: 14.sp, color: Colors.grey))),
              ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onBottomNavTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.deepPurple,
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
            icon: Icon(Icons.explore_outlined),
            activeIcon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            activeIcon: Icon(Icons.favorite),
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

  Widget _buildTrendingArticleItem(BuildContext context, Article article) {
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title,
                      style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      article.date,
                      style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: Icon(
                          _isFavorite(article.id) ? Icons.bookmark : Icons.bookmark_border,
                          color: _isFavorite(article.id) ? Colors.deepPurple : Colors.grey,
                          size: 20.sp,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        visualDensity: VisualDensity.compact,
                        onPressed: () => _toggleFavorite(article.id),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
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
            ],
          ),
        ),
      ),
    );
  }
}
