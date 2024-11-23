import 'dart:convert';
import 'package:http/http.dart' as http;

class Book {
  final String title;
  final String author;
  final String isbn;
  final String coverUrl;
  final String? description;
  final int? pageCount;
  final String? publishDate;
  final List<String> categories;

  Book({
    required this.title,
    required this.author,
    required this.isbn,
    required this.coverUrl,
    this.description,
    this.pageCount,
    this.publishDate,
    this.categories = const [],
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'] ?? 'Unknown Title',
      author: json['author_name'] != null
          ? (json['author_name'] as List).join(', ')
          : 'Unknown Author',
      isbn: json['isbn'] != null ? json['isbn'][0] : 'N/A',
      coverUrl: json['cover_i'] != null
          ? 'https://covers.openlibrary.org/b/id/${json['cover_i']}-L.jpg'
          : 'https://placehold.co/400',
      description: json['description'] ?? null,
      pageCount: json['number_of_pages'] ?? null,
      publishDate: json['publish_date'] ?? null,
      categories:
          json['subject'] != null ? List<String>.from(json['subject']) : [],
    );
  }

  static Future<Book> fromFile(String filePath) async {
    print('Creating Book from file path: $filePath'); // Debug: fájl elérési út
    final fileType = filePath.split('.').last.toLowerCase();
    final fileName = filePath.split('/').last;

    var book = Book(
      title: fileName.replaceAll('.$fileType', ''),
      author: 'Unknown Author',
      isbn: 'N/A',
      coverUrl: 'https://placehold.co/400',
      description: 'Imported from local file.',
      pageCount: null,
      publishDate: null,
      categories: [],
    );

    if (book.author == 'Unknown Author' || book.title == 'Unknown Title') {
      print('Fetching metadata for book: ${book.title}');
      try {
        final metadata = await _fetchBookMetadata(book.title);
        book = metadata ?? book;
      } catch (e) {
        print('Failed to fetch metadata: $e');
      }
    }
    print(
        'Book created from file with metadata: ${book.title}, ${book.author}');
    return book;
  }

  static Future<Book?> _fetchBookMetadata(String title) async {
    final url = Uri.parse('https://openlibrary.org/search.json?q=$title');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final docs = data['docs'] as List?;
      if (docs != null && docs.isNotEmpty) {
        return Book.fromJson(docs.first);
      }
    } else {
      print('Failed to fetch book metadata: ${response.statusCode}');
    }
    return null;
  }
}
