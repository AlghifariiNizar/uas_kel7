class NewsArticle {
    final String? id;
    final String title;
    final String? slug;
    final String? summary;
    final String content;
    final String? featuredImageUrl;
    final String? category;
    final List<String>? tags;
    final bool? isPublished;
    final String? author;
    final DateTime? createdAt;

    NewsArticle({
        this.id,
        required this.title,
        this.slug,
        this.summary,
        required this.content,
        this.featuredImageUrl,
        this.category,
        this.tags,
        this.isPublished,
        this.author,
        this.createdAt,
    });

    factory NewsArticle.fromJson(Map<String, dynamic> json) {
        return NewsArticle(
            id: json['id'],
            title: json['title'] ?? 'Tanpa Judul',
            slug: json['slug'],
            summary: json['summary'],
            content: json['content'] ?? 'Tidak ada konten.',
            author: json['author'] != null ? json['author']['firstName'] : 'Penulis Tidak Dikenal',
            featuredImageUrl: json['featuredImageUrl'],
            category: json['category'],
            tags: json['tags'] != null ? List<String>.from(json['tags']) : [],
            isPublished: json['isPublished'],
            createdAt: json['createdAt'] != null
                ? DateTime.parse(json['createdAt'])
                : null,
        );
    }

    Map<String, dynamic> toJson() {
        return {
            'title': title,
            'summary': summary ?? '',
            'content': content,
            'featuredImageUrl': featuredImageUrl ?? '',
            'category': category ?? 'Uncategorized',
            'tags': tags ?? [],
            'isPublished': isPublished ?? true,
        };
    }
}