import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:uas_kel7/models/article_model.dart';
import 'package:uas_kel7/data/article_data.dart';
import 'package:uas_kel7/routes/route_names.dart';  
import 'package:uas_kel7/services/favorite_service.dart';

class ArticleDetailScreen extends StatefulWidget {
  final String articleId;

  const ArticleDetailScreen({super.key, required this.articleId});

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  final FavoriteService _favoriteService = FavoriteService();
  Article? _article;

  @override
  void initState() {
    super.initState();
    _loadArticle();
    _favoriteService.addListener(_onFavoritesChanged);
  }

  @override
  void dispose() {
    _favoriteService.removeListener(_onFavoritesChanged);
    super.dispose();
  }

  void _loadArticle() {
    try {
      _article = dummyArticles.firstWhere((article) => article.id == widget.articleId);
    } catch (e) {
      _article = null; // Artikel tidak ditemukan
      print("Error loading article with ID ${widget.articleId}: $e");
    }
    if (mounted) {
      setState(() {});
    }
  }

  void _onFavoritesChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  void _toggleFavorite() {
    if (_article != null) {
      _favoriteService.toggleFavorite(_article!.id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_favoriteService.isFavorite(_article!.id)
              ? 'Artikel ditambahkan ke favorit'
              : 'Artikel dihapus dari favorit'),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  bool _isFavorite() {
    if (_article != null) {
      return _favoriteService.isFavorite(_article!.id);
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    if (_article == null) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: Colors.black87, size: 20.sp),
            onPressed: () => context.goNamed(RouteNames.home),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text('Loading...', style: TextStyle(color: Colors.black87, fontSize: 16.sp)),
        ),
        body: const Center(child: Text('Artikel tidak ditemukan atau sedang memuat...')),
      );
    }

    String articleCategory = _article!.category;
    String articleSource = _article!.source;
    String articleContent = _article!.fullContent;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black87, size: 20.sp),
          onPressed: () => context.goNamed(RouteNames.home),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isFavorite() ? Icons.bookmark : Icons.bookmark_border,
              color: _isFavorite() ? const Color.fromARGB(255, 47, 12, 243) : Colors.black87,
              size: 24.sp,
            ),
            onPressed: _toggleFavorite,
          ),
          SizedBox(width: 8.w),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              articleCategory,
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              _article!.title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                height: 1.3,
              ),
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Text(
                  _article!.date,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  '•',
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  articleSource,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.network(
                _article!.imageUrl,
                width: double.infinity,
                height: 220.h,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: 220.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(Icons.image_not_supported_outlined, size: 60.sp, color: Colors.grey[400]),
                  );
                },
                 loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return SizedBox(
                    width: double.infinity,
                    height: 220.h,
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
            ),
            SizedBox(height: 20.h),
            Text(
              articleContent,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.black87,
                height: 1.6,
                letterSpacing: 0.2,
                
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
