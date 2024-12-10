import 'dart:typed_data';

class Book {
  final String title;
  final String author;
  final String isbn;
  final String coverUrl;
  final String? description;
  final int? pageCount;
  final String? publishDate;
  final List<String> categories;
  final Uint8List? fileBytes;
  final String? filePath;

  Book({
    required this.title,
    required this.author,
    required this.isbn,
    required this.coverUrl,
    this.description,
    this.pageCount,
    this.publishDate,
    this.categories = const [],
    this.fileBytes,
    this.filePath,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'] ?? 'Unknown Title',
      author: (json['author_name'] as List?)?.join(', ') ?? 'Unknown Author',
      isbn: (json['isbn'] as List?)?.first ?? 'N/A',
      coverUrl: json['cover_i'] != null
          ? 'https://covers.openlibrary.org/b/id/${json['cover_i']}-L.jpg'
          : 'https://placehold.co/400',
      description: json['description'] is String
          ? json['description'] as String
          : 'No description available.',
      pageCount: json['number_of_pages'] is int
          ? json['number_of_pages'] as int
          : null,
      publishDate: json['publish_date'] is String
          ? json['publish_date'] as String
          : null,
      categories: (json['subject'] as List?)
              ?.map((subject) => subject.toString())
              .toList() ??
          [],
      fileBytes: null,
      filePath: null,
    );
  }
}
