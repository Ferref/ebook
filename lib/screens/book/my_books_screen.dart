import 'package:flutter/material.dart';
import '../../models/books.dart';

class MyBooksScreen extends StatelessWidget {
  final List<Book> ownedBooks;
  final void Function(Book book) onBookTap;

  const MyBooksScreen({
    super.key,
    required this.ownedBooks,
    required this.onBookTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Books")),
      body: ownedBooks.isEmpty
          ? const Center(child: Text("No books available."))
          : ListView.builder(
              itemCount: ownedBooks.length,
              itemBuilder: (context, index) {
                final book = ownedBooks[index];
                return ListTile(
                  title: Text(book.title),
                  subtitle: Text(book.author),
                  onTap: () => onBookTap(book),
                );
              },
            ),
    );
  }
}
