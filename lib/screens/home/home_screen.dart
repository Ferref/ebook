import 'package:flutter/material.dart';
import '../../models/books.dart';
import '../book/my_books_screen.dart';
import '../book/book_import_screen.dart';
import '../market/market_screen.dart';
import 'package:ebook/widgets/last_opened_book.dart';

class HomeScreen extends StatelessWidget {
  final Book? lastOpenedBook;
  final List<Book> ownedBooks;
  final Function(Book) onBookAdded;

  const HomeScreen({
    super.key,
    required this.lastOpenedBook,
    required this.ownedBooks,
    required this.onBookAdded,
  });

  void _openMyBooksScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyBooksScreen(
          ownedBooks: ownedBooks,
          onBookTap: (book) => onBookAdded(book),
        ),
      ),
    );
  }

  void _openImportBooksScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookImportScreen(
          onBookImported: onBookAdded,
        ),
      ),
    );
  }

  void _openMarketScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MarketScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DuckReader - Home"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'DuckReader Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () => Navigator.pop(context), // Close drawer
            ),
            ListTile(
              leading: const Icon(Icons.store),
              title: const Text('Market'),
              onTap: () {
                Navigator.pop(context); // Close drawer
                _openMarketScreen(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('My Books'),
              onTap: () {
                Navigator.pop(context); // Close drawer
                _openMyBooksScreen(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.import_contacts),
              title: const Text('Import Books'),
              onTap: () {
                Navigator.pop(context); // Close drawer
                _openImportBooksScreen(context);
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LastOpenedBook(lastOpenedBook: lastOpenedBook),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _openMyBooksScreen(context),
              child: const Text("Go to My Books"),
            ),
            ElevatedButton(
              onPressed: () => _openImportBooksScreen(context),
              child: const Text("Import a Book"),
            ),
          ],
        ),
      ),
    );
  }
}
