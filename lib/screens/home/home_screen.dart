import 'package:flutter/material.dart';
import '../../models/books.dart';
import '../../widgets/last_opened_book.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DuckReader Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            LastOpenedBook(lastOpenedBook: lastOpenedBook),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Import a Book'),
            ),
          ],
        ),
      ),
    );
  }
}
