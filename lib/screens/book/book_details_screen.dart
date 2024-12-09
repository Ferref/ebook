import 'package:flutter/material.dart';
import '../../models/books.dart';

class BookDetailsScreen extends StatelessWidget {
  final Book book;

  const BookDetailsScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              book.coverUrl,
              height: 150,
              width: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 100,
                  height: 150,
                  color: Colors.grey,
                  child: const Icon(Icons.broken_image),
                );
              },
            ),
            const SizedBox(height: 20),
            Text(book.title, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 10),
            Text("By ${book.author}",
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 20),
            if (book.categories.isNotEmpty)
              Wrap(
                spacing: 8,
                children: book.categories
                    .take(5)
                    .map((category) => Chip(label: Text(category)))
                    .toList(),
              ),
          ],
        ),
      ),
    );
  }
}

//.