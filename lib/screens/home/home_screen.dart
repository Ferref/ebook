import 'dart:typed_data';
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:flutter/material.dart';
import '../../api/openlibrary_service.dart';
import '../../models/books.dart';
import 'package:ebook/widgets/currently_reading.dart';
import 'package:ebook/widgets/last_opened_book.dart';
import 'package:ebook/widgets/owned_books.dart';
import 'package:ebook/widgets/book_importer.dart';
import 'package:ebook/screens/book/book_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final OpenLibraryService _openLibraryService = OpenLibraryService();
  List<Book> _books = [];
  Book? _lastOpenedBook;
  List<Book> _currentlyReadingBooks = [];
  List<Book> _ownedBooks = [];
  bool _isLoading = false;

  Future<void> _fetchBooks(String query) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final books = await _openLibraryService.searchBooks(query);
      setState(() {
        _books = books;
        if (_books.isNotEmpty) {
          _lastOpenedBook = _books.first;
          _currentlyReadingBooks = _books.take(2).toList();
          _ownedBooks = _books;
        }
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
    print('Navigating to BookDetailsScreen for: ${book.title}');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailsScreen(book: book),
      ),
    ).then((_) {
      print('Returned from BookDetailsScreen');
    });
  }

  void _openImportBooksDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Import Books'),
          content: BookImporter(onBookImported: _handleBookImport),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _handleBookImport(String filePathOrName, Uint8List? fileBytes) {
    print(
        'Import started. File: $filePathOrName, Bytes: ${fileBytes?.length ?? "N/A"}');

    final importedBook = Book(
      title: filePathOrName.split('/').last.replaceAll('.epub', ''),
      author: 'Unknown Author',
      isbn: 'N/A',
      coverUrl: 'https://placehold.co/400', // Placeholder image
      description: fileBytes != null
          ? 'Imported from web platform.'
          : 'Imported from local storage.',
      pageCount: null,
      publishDate: null,
      categories: [],
    );

    setState(() {
      _ownedBooks.add(importedBook);
      print('Book added to ownedBooks list: ${importedBook.title}');
    });

    Future.microtask(() {
      print('Navigating to book details for: ${importedBook.title}');
      _navigateToBookDetails(importedBook);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Book imported: ${importedBook.title}')),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchBooks('fiction');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "DuckReader",
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'DuckReader Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('My Books'),
              onTap: () {
                Navigator.pop(context);
                // Add functionality to open My Books screen if needed
              },
            ),
            ListTile(
              leading: const Icon(Icons.import_contacts),
              title: const Text('Import Books'),
              onTap: () {
                Navigator.pop(context);
                _openImportBooksDialog();
              },
            ),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LastOpenedBook(
                    lastOpenedBook: _lastOpenedBook,
                  ),
                  const SizedBox(height: 20),
                  CurrentlyReading(
                    currentlyReadingBooks: _currentlyReadingBooks,
                  ),
                  const SizedBox(height: 20),
                  OwnedBooks(
                    ownedBooks: _ownedBooks,
                    onBookTap: _navigateToBookDetails,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Recommended Books",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(14),
                    itemCount: _books.length,
                    itemBuilder: (context, index) {
                      final book = _books[index];
                      return ListTile(
                        leading: Image.network(
                          book.coverUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(book.title),
                        subtitle: Text(book.author),
                        onTap: () => _navigateToBookDetails(book),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
