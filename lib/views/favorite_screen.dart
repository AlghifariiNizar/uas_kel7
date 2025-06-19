import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:uas_kel7/models/news_article.dart';
import 'package:uas_kel7/routes/route_names.dart';
import 'package:uas_kel7/services/bookmark_service.dart';
import 'package:uas_kel7/views/home_screen.dart';
import 'package:uas_kel7/views/profile_screen.dart';
import '../models/article_model.dart';
import 'package:uas_kel7/services/news_service.dart';

class FavoritesScreen extends StatelessWidget {
  // final List<NewsArticle> allNews;

  // const FavoritesScreen({required this.allNews, Key? key}) : super(key: key);

  const FavoritesScreen({Key? key}) : super(key: key);

  void _onBottomNavTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
        break;
      case 1:
        context.goNamed(RouteNames.explore);
        break;
      case 2:
        // Sudah di Favorites
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<BookmarkService>(
        builder: (context, bookmarkService, child) {
          return Consumer<NewsService>(
            builder: (context, newsService, child) {
              final bookmarkedArticles =
                  newsService.allNews
                      .where(
                        (article) => bookmarkService.isBookmarked(article.id!),
                      )
                      .toList();
              return SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 20.h,
                      ),
                      child: Text(
                        'Favorite',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 47, 12, 243),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        itemCount: bookmarkedArticles.length,
                        itemBuilder: (context, index) {
                          final article = bookmarkedArticles[index];
                          return Card(
                            elevation: 1.0,
                            margin: EdgeInsets.only(bottom: 16.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: InkWell(
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Navigasi ke detail artikel: ${article.title}',
                                    ),
                                    duration: const Duration(seconds: 1),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: EdgeInsets.all(10.w),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            article.title,
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 4.h),
                                          Text(
                                            '${article.summary}',
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              color: Colors.grey[600],
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 4.h),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: IconButton(
                                              icon: Icon(
                                                Icons.bookmark,
                                                color: Colors.deepPurple,
                                                size: 10.sp,
                                              ),
                                              padding: EdgeInsets.zero,
                                              constraints:
                                                  const BoxConstraints(),
                                              visualDensity:
                                                  VisualDensity.compact,
                                              onPressed: () {
                                                Provider.of<BookmarkService>(
                                                  context,
                                                  listen: false,
                                                ).toggleBookmark(article.id!);
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                      'Artikel dihapus dari favorit',
                                                    ),
                                                    duration: Duration(
                                                      seconds: 1,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 12.w),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.r),
                                      child: Image.network(
                                        '$article.featuredImageUrl!',
                                        width: 100.w,
                                        height: 80.h,
                                        fit: BoxFit.cover,
                                        errorBuilder: (
                                          context,
                                          error,
                                          stackTrace,
                                        ) {
                                          return Container(
                                            width: 100.w,
                                            height: 80.h,
                                            color: Colors.grey[200],
                                            child: Icon(
                                              Icons.broken_image,
                                              size: 30.sp,
                                              color: Colors.grey[500],
                                            ),
                                          );
                                        },
                                        loadingBuilder: (
                                          BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress,
                                        ) {
                                          if (loadingProgress == null)
                                            return child;
                                          return SizedBox(
                                            width: 100.w,
                                            height: 80.h,
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2.0,
                                                value:
                                                    loadingProgress
                                                                .expectedTotalBytes !=
                                                            null
                                                        ? loadingProgress
                                                                .cumulativeBytesLoaded /
                                                            loadingProgress
                                                                .expectedTotalBytes!
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
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        onTap: (index) => _onBottomNavTapped(context, index),
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
}
