import 'dart:io';
import 'package:flutter/material.dart';
import '../../models/books.dart';
import './reader_screen.dart';

class MyBooksScreen extends StatelessWidget {
  final List<Book> ownedBooks;
  final void Function(Book book) onBookTap;

  const MyBooksScreen({
    Key? key,
    required this.ownedBooks,
    required this.onBookTap,
  }) : super(key: key);

  void _openReaderScreen(BuildContext context, Book book) async {
    if (book.filePath != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ReaderScreen(book: book),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('File path is missing for this book.')),
      );
    }
  }

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
                  onTap: () => _openReaderScreen(context, book),
                );
              },
            ),
    );
  }
}
