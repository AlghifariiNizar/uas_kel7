import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/news_article.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';

class AddEditNewsScreen extends StatefulWidget {
    final NewsArticle? article;
    AddEditNewsScreen({this.article});

    @override
    _AddEditNewsScreenState createState() => _AddEditNewsScreenState();
}

class _AddEditNewsScreenState extends State<AddEditNewsScreen> {
    final _formKey = GlobalKey<FormState>();
    late String _title;
    late String _content;
    late String _author;
    bool _isLoading = false;

    @override
    void initState() {
        super.initState();
        _title = widget.article?.title ?? '';
        _content = widget.article?.content ?? '';
        _author = widget.article?.author ?? '';
    }

    Future<void> _saveForm() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    setState(() { _isLoading = true; });

    final token = Provider.of<AuthService>(context, listen: false).token;
    final apiService = ApiService(token);

    try {
        final newArticle = NewsArticle(
            id: widget.article?.id,
            title: _title, 
            content: _content,
            summary: "Ini adalah ringkasan berita uji coba yang panjangnya cukup.",
            category: "Teknologi",
            featuredImageUrl: "https://picsum.photos/200/300", 
            tags: ["flutter", "testing", "api"],
            isPublished: true,
        );
        // ==============================================================

        if (widget.article == null) {
            // Create
            await apiService.createNews(newArticle);
        } else {
            // Update
            await apiService.updateNews(widget.article!.id!, newArticle);
        }
        Navigator.of(context).pop();
    } catch (e) {
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
            title: Text('Terjadi Kesalahan'),
            content: Text('Gagal menyimpan berita: $e'),
            actions: [TextButton(child: Text('OK'), onPressed: () => Navigator.of(ctx).pop())],
            ),
        );
    }

    if(mounted) {
        setState(() { _isLoading = false; });
    }
}

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text(widget.article == null ? 'Tambah Berita' : 'Edit Berita'),
                actions: [
                    IconButton(icon: Icon(Icons.save), onPressed: _saveForm)
                ],
            ),
            body: _isLoading
                ? Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                        key: _formKey,
                        child: ListView(
                            children: [
                                TextFormField(
                                    initialValue: _title,
                                    decoration: InputDecoration(labelText: 'Judul'),
                                    validator: (value) => value!.isEmpty ? 'Judul tidak boleh kosong' : null,
                                    onSaved: (value) => _title = value!,
                                ),
                                TextFormField(
                                    initialValue: _content,
                                    decoration: InputDecoration(labelText: 'Konten'),
                                    maxLines: 5,
                                    validator: (value) => value!.isEmpty ? 'Konten tidak boleh kosong' : null,
                                    onSaved: (value) => _content = value!,
                                ),
                                TextFormField(
                                    initialValue: _author,
                                    decoration: InputDecoration(labelText: 'Penulis'),
                                    validator: (value) => value!.isEmpty ? 'Penulis tidak boleh kosong' : null,
                                    onSaved: (value) => _author = value!,
                                ),
                            ],
                        ),
                    ),
                ),
        );
    }
}