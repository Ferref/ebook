import 'dart:convert';
import 'dart:io';
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

  // Open Library API válasz feldolgozása
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'] ?? 'Unknown Title',
      author: json['author_name'] != null
          ? (json['author_name'] is List
              ? (json['author_name'] as List).join(', ')
              : json['author_name'].toString())
          : 'Unknown Author',
      isbn: json['isbn'] != null
          ? (json['isbn'] is List ? json['isbn'][0] : json['isbn'].toString())
          : 'N/A',
      coverUrl: json['cover_i'] != null
          ? 'https://covers.openlibrary.org/b/id/${json['cover_i']}-L.jpg'
          : 'https://placehold.co/400',
      description: json['description'] is String
          ? json['description'] as String
          : 'No description available.',
      pageCount:
          json['number_of_pages'] is int ? json['number_of_pages'] : null,
      publishDate: json['publish_date'] is String ? json['publish_date'] : null,
      categories: json['subject'] != null
          ? (json['subject'] is List
              ? List<String>.from(json['subject'])
              : [json['subject'].toString()])
          : [],
    );
  }

  // Könyv létrehozása fájl alapján
  static Future<Book> fromFile(String filePath) async {
    print('Importing book from file: $filePath');

    final fileType = filePath.split('.').last.toLowerCase();
    final fileName = filePath.split('/').last;

    String title = 'Unknown Title';
    String author = 'Unknown Author';

    // Fájlnév elemzése
    if (fileName.contains('-')) {
      final parts = fileName.replaceAll('.$fileType', '').split('-');
      if (parts.length >= 2) {
        author = parts[0].trim();
        title = parts[1].trim();
      }
    } else {
      title = fileName.replaceAll('.$fileType', '').trim();
    }

    print('Extracted from file name: Author: $author, Title: $title');

    // Ellenőrzés: fájl tartalmának metaadatok feldolgozása
    final extractedMetadata = await _extractMetadataFromFile(filePath);
    if (extractedMetadata != null) {
      author = extractedMetadata['author'] ?? author;
      title = extractedMetadata['title'] ?? title;
      print(
          'Extracted metadata from file content: Title: ${extractedMetadata['title']}, Author: ${extractedMetadata['author']}');
    } else {
      print('No metadata extracted from file content.');
    }

    return Book(
      title: title,
      author: author,
      isbn: 'N/A',
      coverUrl: 'https://placehold.co/400', // Default cover image
      description: 'Imported from local file.',
      pageCount: null,
      publishDate: null,
      categories: [],
    );
  }

  // Fájl tartalmának metaadatok kinyerése
  static Future<Map<String, String>?> _extractMetadataFromFile(
      String filePath) async {
    try {
      final file = File(filePath);
      final content = await file.readAsString();

      // Egyszerű logika: metaadatokat keresünk
      final lines = content.split('\n');
      final titleLine = lines.firstWhere(
        (line) => line.toLowerCase().contains('title:'),
        orElse: () => '',
      );
      final authorLine = lines.firstWhere(
        (line) => line.toLowerCase().contains('author:'),
        orElse: () => '',
      );

      // Ha metaadatok léteznek, térjünk vissza velük
      final title = titleLine.replaceFirst('Title:', '').trim();
      final author = authorLine.replaceFirst('Author:', '').trim();

      if (title.isNotEmpty || author.isNotEmpty) {
        return {'title': title, 'author': author};
      }
    } catch (e) {
      print('Failed to extract metadata from file: $e');
    }
    return null;
  }

  // Open Library API fallback
  static Future<Book?> _fetchBookMetadata(String title) async {
    final url = Uri.parse('https://openlibrary.org/search.json?q=$title');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final docs = data['docs'] as List?;
      if (docs != null && docs.isNotEmpty) {
        return Book.fromJson(docs.first);
      } else {
        print('No matching books found in Open Library API response.');
      }
    } else {
      print('Failed to fetch book metadata: ${response.statusCode}');
    }
    return null;
  }
}
