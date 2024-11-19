import 'package:flutter/material.dart';
import '../../api/openlibrary_service.dart';
import '../../models/books.dart';
import 'package:ebook/widgets/currently_reading.dart';
import 'package:ebook/widgets/last_opened_book.dart';
import 'package:ebook/widgets/owned_books.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final OpenLibraryService _openLibraryService = OpenLibraryService();
  List<Book> _books = [];
  bool _isLoading = false;

  void _fetchBooks(String query) async {
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
                Navigator.pop(context); // Closes the drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('My Books'),
              onTap: () {
                // Navigate to the My Books section
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
                children: [
                  const LastOpenedBook(),
                  const CurrentlyReading(),
                  const OwnedBooks(),
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
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
