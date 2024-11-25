import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../../models/books.dart';

class BookImportScreen extends StatefulWidget {
  const BookImportScreen({super.key});

  @override
  _BookImportScreenState createState() => _BookImportScreenState();
}

class _BookImportScreenState extends State<BookImportScreen> {
  List<Book> importedBooks = [];
  Book? lastImportedBook;

  Future<void> _importBook() async {
    try {
      // Use FilePicker to pick a file
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['epub', 'pdf', 'prc'],
      );

      if (result != null) {
        final platformFile = result.files.single;
        String filePathOrName = platformFile.name;
        Uint8List? fileBytes;

        if (kIsWeb) {
          // Handle web platform file import
          fileBytes = platformFile.bytes;
        } else {
          // Handle mobile or desktop platforms
          filePathOrName = platformFile.path ?? platformFile.name;
          final file = File(filePathOrName);
          fileBytes = await file.readAsBytes();
        }

        // Process the imported book
        final book = await _extractMetadata(filePathOrName, fileBytes);

        setState(() {
          importedBooks.add(book);
          lastImportedBook = book;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Book imported: ${book.title}')),
        );

        // Simulate opening the book (replace this with real functionality)
        await Future.delayed(const Duration(seconds: 2));
        _showBookDetails(book);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No file selected.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error importing book: $e')),
      );
    }
  }

  Future<Book> _extractMetadata(
      String filePathOrName, Uint8List? fileBytes) async {
    String title = 'Unknown Title';
    String author = 'Unknown Author';
    String coverUrl = 'https://placehold.co/400'; // Default placeholder

    // Basic logic to extract title and author from the filename
    if (filePathOrName.contains('-')) {
      final parts = filePathOrName.split('-');
      if (parts.length >= 2) {
        author = parts[0].trim();
        title = parts[1].split('.').first.trim();
      }
    } else {
      title = filePathOrName.split('.').first.trim();
    }

    // For real metadata extraction, process the fileBytes based on the format (.epub, .pdf, etc.)
    // Placeholder logic for now
    return Book(
      title: title,
      author: author,
      isbn: 'N/A',
      coverUrl: coverUrl,
      description: 'Imported from local file.',
      pageCount: null,
      publishDate: null,
      categories: [],
    );
  }

  void _showBookDetails(Book book) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(book.title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Author: ${book.author}'),
              const SizedBox(height: 10),
              Image.network(
                book.coverUrl,
                height: 150,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image, size: 50),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Import Books'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _importBook,
              child: const Text('Import Book'),
            ),
            const SizedBox(height: 20),
            if (lastImportedBook != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Last Imported Book:',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 10),
                  Text('Title: ${lastImportedBook!.title}'),
                  Text('Author: ${lastImportedBook!.author}'),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
