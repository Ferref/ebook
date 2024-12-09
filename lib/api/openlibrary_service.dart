import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/books.dart';

class OpenLibraryService {
  final String baseUrl = 'https://openlibrary.org';

  // Fetch books based on a search query
  Future<List<Book>> searchBooks(String query) async {
    final url = Uri.parse('$baseUrl/search.json?q=$query&limit=5');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final books = (data['docs'] as List)
          .map((bookData) => Book.fromJson(bookData))
          .toList();
      return books;
    } else {
      throw Exception('Failed to fetch books from Open Library API');
    }
  }
}
