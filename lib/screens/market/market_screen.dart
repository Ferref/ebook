import 'package:flutter/material.dart';
import '../../api/openlibrary_service.dart';
import '../../models/books.dart';
import 'package:ebook/screens/book/book_details_screen.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  _MarketScreenState createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  final OpenLibraryService _openLibraryService = OpenLibraryService();
  List<Book> _books = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchBooks('fiction'); // Default category for initial load
  }

  Future<void> _fetchBooks(String query) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final books = await _openLibraryService.searchBooks(query);
      setState(() {
        _books = books;
      });
    } catch (e) {
      print('Error fetching books: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _navigateToBookDetails(Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailsScreen(book: book),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DuckReader - Market"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            TextField(
              decoration: const InputDecoration(
                hintText: 'Search for books...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                if (value.isEmpty) {
                  _fetchBooks('fiction'); // Reload default
                } else {
                  _fetchBooks(value);
                }
              },
            ),
            const SizedBox(height: 20),

            // Loading Indicator
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else
              // Books List
              Expanded(
                child: ListView.builder(
                  itemCount: _books.length,
                  itemBuilder: (context, index) {
                    final book = _books[index];
                    return ListTile(
                      leading: Image.network(
                        book.coverUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.broken_image, size: 50);
                        },
                      ),
                      title: Text(book.title),
                      subtitle: Text(book.author),
                      onTap: () => _navigateToBookDetails(book),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
