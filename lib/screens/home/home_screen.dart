import 'package:flutter/material.dart';
import '../../models/books.dart';
import '../book/my_books_screen.dart'; // Import MyBooksScreen
import '../book/book_import_screen.dart'; // Import BookImportScreen
import '../market/market_screen.dart'; // Import MarketScreen
import 'package:ebook/widgets/currently_reading.dart';
import 'package:ebook/widgets/last_opened_book.dart';

class HomeScreen extends StatelessWidget {
  final Book? lastOpenedBook;
  final List<Book> currentlyReadingBooks;

  const HomeScreen({
    super.key,
    required this.lastOpenedBook,
    required this.currentlyReadingBooks,
  });

  void _openMyBooksScreen(BuildContext context) {
    Navigator.pop(context); // Close the drawer
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            const MyBooksScreen(), // Navigate to MyBooksScreen
      ),
    );
  }

  void _openImportBooksScreen(BuildContext context) {
    Navigator.pop(context); // Close the drawer
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            const BookImportScreen(), // Navigate to BookImportScreen
      ),
    );
  }

  void _openMarketScreen(BuildContext context) {
    Navigator.pop(context); // Close the drawer
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MarketScreen(), // Navigate to MarketScreen
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "DuckReader - Home",
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
                Navigator.pop(context); // Close the drawer and stay on Home
              },
            ),
            ListTile(
              leading: const Icon(Icons.store),
              title: const Text('Market'),
              onTap: () => _openMarketScreen(context), // Open Market Screen
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('My Books'),
              onTap: () => _openMyBooksScreen(context), // Open My Books Screen
            ),
            ListTile(
              leading: const Icon(Icons.import_contacts),
              title: const Text('Import Books'),
              onTap: () =>
                  _openImportBooksScreen(context), // Open Import Books Screen
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display the last opened book
              LastOpenedBook(
                lastOpenedBook: lastOpenedBook,
              ),
              const SizedBox(height: 20),
              // Display the currently reading books
              CurrentlyReading(
                currentlyReadingBooks: currentlyReadingBooks,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
