import 'package:flutter/material.dart';
import '../../models/books.dart';
import '../../widgets/last_opened_book.dart';

class HomeScreen extends StatelessWidget {
  final Book? lastOpenedBook;
  final List<Book> ownedBooks;

  const HomeScreen({
    super.key,
    required this.lastOpenedBook,
    required this.ownedBooks,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LastOpenedBook(lastOpenedBook: lastOpenedBook),
            const SizedBox(height: 20),
            if (ownedBooks.isEmpty)
              Center(
                child: Text(
                  'No books available.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
