import 'package:flutter/material.dart';
import '../../models/books.dart';

class BookDetailsScreen extends StatelessWidget {
  final Book book;

  const BookDetailsScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          book.title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Book Cover
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                book.coverUrl,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 300,
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.broken_image, size: 100),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            // Title
            Text(
              book.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 10),
            // Author
            Text(
              "By ${book.author}",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 20),
            // Description
            Text(
              "Description:",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            Text(
              book.description ?? "No description available.",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            // Additional Info (Pages and Published Date)
            Row(
              children: [
                if (book.pageCount != null)
                  Text(
                    "Pages: ${book.pageCount}",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                if (book.pageCount != null) const SizedBox(width: 20),
                if (book.publishDate != null)
                  Text(
                    "Published: ${book.publishDate}",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
              ],
            ),
            const SizedBox(height: 20),
            // Categories
            if (book.categories.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Categories:",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    children: book.categories.map((category) {
                      return Chip(
                        label: Text(category),
                      );
                    }).toList(),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
