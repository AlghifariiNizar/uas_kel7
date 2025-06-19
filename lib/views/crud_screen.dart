import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uas_kel7/models/news_article.dart';
import 'package:uas_kel7/services/api_service.dart';
import 'package:uas_kel7/services/auth_service.dart';
import 'package:uas_kel7/views/add_edit_news_screen.dart';
import 'package:uas_kel7/views/profile_screen.dart';
import 'package:uas_kel7/views/splash_screen.dart';

class CrudScreen extends StatefulWidget {
  const CrudScreen({super.key});

  @override
  State<CrudScreen> createState() => _CrudScreenState();
}

class _CrudScreenState extends State<CrudScreen> {
  late Future<List<NewsArticle>> _myNewsFuture;

  @override
  void initState() {
    super.initState();
    _loadMyNews();
  }

  // Fungsi untuk memuat atau me-refresh daftar berita milik user
  void _loadMyNews() {
    final token = Provider.of<AuthService>(context, listen: false).token;
    setState(() {
      _myNewsFuture = ApiService(token).getMyNews();
    });
  }

  // Fungsi untuk navigasi ke halaman edit
  void _editArticle(NewsArticle article) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => ProfileScreen())).then((_) {
      // Refresh daftar berita setelah kembali dari halaman edit
      _loadMyNews();
    });
  }

  void _navigateToAddEditScreen([NewsArticle? article]) {
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (ctx) => AddEditNewsScreen(article: article),
          ),
        )
        .then((_) => _loadMyNews()); // Refresh list after returning
  }

  // Fungsi untuk menghapus artikel
  Future<void> _deleteArticle(String articleId) async {
    // Tampilkan dialog konfirmasi
    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Konfirmasi'),
            content: const Text(
              'Apakah Anda yakin ingin menghapus berita ini ?',
              
            ),
            actions: [
              TextButton(
                child: const Text('Batal'),
                onPressed: () => Navigator.of(ctx).pop(false),
              ),
              TextButton(
                child: const Text('Hapus'),
                onPressed: () => Navigator.of(ctx).pop(true),
              ),
            ],
          ),
    );

    if (confirmed == true) {
      try {
        final token = Provider.of<AuthService>(context, listen: false).token;
        await ApiService(token).deleteNews(articleId);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Berita berhasil dihapus'),
            backgroundColor: Colors.green,
          ),
        );
        _loadMyNews(); // Refresh daftar berita
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal menghapus berita: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthService>(context, listen: false).user;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      // Kita gunakan CustomScrollView agar bisa menggabungkan widget non-scroll dengan list
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text(''),
            backgroundColor: Colors.white,
            floating: true,
            pinned: true,
            elevation: 0.5,
          ),

          // Bagian Atas: Info Profil (tidak bisa di-scroll)
          SliverToBoxAdapter(
            child: Column(
              children: [
                if (user != null)
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 16.0,
                    ),
                    child: Text(
                      "Berita Saya",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Bagian Bawah: Daftar Artikel (bisa di-scroll)
          FutureBuilder<List<NewsArticle>>(
            future: _myNewsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              if (snapshot.hasError) {
                return SliverToBoxAdapter(
                  child: Center(child: Text('Error: ${snapshot.error}')),
                );
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: Text('Anda belum membuat berita apapun.'),
                    ),
                  ),
                );
              }

              final myNewsList = snapshot.data!;
              return SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final article = myNewsList[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    child: ListTile(
                      title: Text(
                        article.title,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        article.summary ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.blueAccent,
                            ),
                            onPressed: () => _editArticle(article),
                            tooltip: 'Edit',
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                            ),
                            onPressed: () => _deleteArticle(article.id!),
                            tooltip: 'Hapus',
                          ),
                        ],
                      ),
                    ),
                  );
                }, childCount: myNewsList.length),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _navigateToAddEditScreen(),
      ),
    );
  }
}
