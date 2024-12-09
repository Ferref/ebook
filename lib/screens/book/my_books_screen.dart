import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../../models/books.dart';
import './reader_screen.dart';

class MyBooksScreen extends StatelessWidget {
  final List<Book> ownedBooks;
  final void Function(Book book) onBookTap;

  const MyBooksScreen({
    super.key,
    required this.ownedBooks,
    required this.onBookTap,
  });

  void _openReaderScreen(BuildContext context, Book book) async {
    try {
      final file = File(book.coverUrl);
      final Uint8List fileBytes = await file.readAsBytes();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ReaderScreen(
            book: book,
            fileBytes: fileBytes,
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load the book: $e')),
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
