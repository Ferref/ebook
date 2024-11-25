import 'package:flutter/material.dart';
import '../../models/books.dart';
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
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Navigate to My Books screen')),
    );
  }

  void _openImportBooksScreen(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Navigate to Import Books screen')),
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
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('My Books'),
              onTap: () => _openMyBooksScreen(context),
            ),
            ListTile(
              leading: const Icon(Icons.import_contacts),
              title: const Text('Import Books'),
              onTap: () => _openImportBooksScreen(context),
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
