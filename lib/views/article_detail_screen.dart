import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uas_kel7/models/news_article.dart'; // Sesuaikan path import jika perlu

class ArticleDetailScreen extends StatelessWidget {
  // Halaman ini menerima satu objek NewsArticle melalui constructor-nya
  final NewsArticle article;

  const ArticleDetailScreen({required this.article, Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('Detail Berita'),
      ),
      body: SingleChildScrollView(
        // Memungkinkan konten untuk di-scroll jika panjang
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(article.category!),
                  Text(
                    article.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),

                  // 3. Menampilkan Info Penulis dan Tanggal
                  Row(
                    children: [
                      Text(
                        article.author!,
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 24),
                      if (article.createdAt != null) 
                        Text(
                          DateFormat('d MMMM yyyy').format(article.createdAt!),
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      if (article.createdAt == null) 
                        Text(
                          DateFormat('d MMMM yyyy').format(DateTime.now()),
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Image.network(
                    '$article.featuredImageUrl!',
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: double.infinity,
                        height: 250,
                        color: Colors.grey[300],
                        child: Icon(
                          Icons.broken_image,
                          color: Colors.grey[600],
                          size: 50,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16.0),
                  Divider(),
                  const SizedBox(height: 16.0),

                  // 4. Menampilkan Konten Lengkap
                  Text(
                    article.content,
                    style: TextStyle(
                      fontSize: 16.0,
                      height: 1.5,
                    ), // Tinggi baris untuk keterbacaan
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
