// lib/services/api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news_article.dart';

class ApiService {
    final String _baseUrl = 'http://45.149.187.204:3000';
    final String? _token;

    ApiService(this._token);

    Map<String, String> get _headers {
        if (_token != null && _token!.isNotEmpty) {
            return {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $_token',
            };
        }
        return {'Content-Type': 'application/json'};
    }

    Future<List<NewsArticle>> getNews() async {
        // Path ini sudah kita perbaiki sebelumnya
        final url = Uri.parse('$_baseUrl/api/news'); 
        print("Meminta daftar berita dari: $url");

        try {
            final response = await http.get(url, headers: _headers);
            print("Status Code dari GET /api/news: ${response.statusCode}");
            
            if (response.statusCode == 200) {
                final responseData = json.decode(response.body);
                final List<dynamic> newsList = responseData['body']['data'];
                return newsList.map((json) => NewsArticle.fromJson(json)).toList();
            } else {
                throw Exception('Gagal memuat berita. Status Code: ${response.statusCode}');
            }
        } catch (e) {
            print("Error saat getNews: $e");
            throw Exception('Failed to load News');
        }
    }

    Future<NewsArticle> createNews(NewsArticle article) async {
    // PERBAIKAN: Gunakan path URL yang benar dari screenshot
    final url = Uri.parse('$_baseUrl/api/author/news');
    print("Membuat berita baru ke: $url");
    print("Dengan Body: ${article.toJson()}"); // Cetak body untuk debug

    final response = await http.post(
        url,
        headers: _headers,
        // Pastikan kita menggunakan fungsi toJson yang sudah diperbarui
        body: json.encode(article.toJson()), 
    );

    print("Status Code dari POST /api/author/news: ${response.statusCode}");
    print("Response Body dari POST /api/author/news: ${response.body}");

    // Menurut screenshot, respons sukses adalah 200, bukan 201
    if (response.statusCode == 200) { 
        // Server mungkin tidak mengembalikan body, jadi kita buat objek dummy
        return article; // Atau parse body jika server mengembalikan data berita yang baru dibuat
    } else {
        throw Exception('Failed to create news. Status: ${response.statusCode}');
    }
}

    Future<void> updateNews(String id, NewsArticle article) async {
        // PERBAIKAN: Tambahkan /api di sini
        final url = Uri.parse('$_baseUrl/api/author/news/$id');
        print("Memperbarui berita ke: $url");
        
        final response = await http.put(
            url,
            headers: _headers,
            body: json.encode(article.toJson()),
        );

        if (response.statusCode != 200) {
            throw Exception('Failed to update news. Status: ${response.statusCode}');
        }
    }

    Future<void> deleteNews(String id) async {
        // PERBAIKAN: Tambahkan /api di sini
        final url = Uri.parse('$_baseUrl/api/author/news/$id');
        print("Menghapus berita dari: $url");

        final response = await http.delete(url, headers: _headers);

        if (response.statusCode != 200) {
            throw Exception('Failed to delete news. Status: ${response.statusCode}');
        }
    }

    Future<List<NewsArticle>> getMyNews() async {
        final url = Uri.parse('$_baseUrl/api/author/news');
        print("Meminta 'Berita Saya' dari: $url");

        try {
            final response = await http.get(url, headers: _headers);
            print("Status Code dari GET /api/author/news: ${response.statusCode}");
            
            if (response.statusCode == 200) {
                final responseData = json.decode(response.body);
                // Strukturnya sama seperti getNews
                final List<dynamic> newsList = responseData['body']['data'];
                return newsList.map((json) => NewsArticle.fromJson(json)).toList();
            } else {
                throw Exception('Gagal memuat berita saya. Status Code: ${response.statusCode}');
            }
        } catch (e) {
            print("Error saat getMyNews: $e");
            throw Exception('Failed to load my news');
        }
    }
}