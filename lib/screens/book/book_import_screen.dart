import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../../models/books.dart';

class BookImportScreen extends StatefulWidget {
  final Function(Book) onBookImported;

  const BookImportScreen({super.key, required this.onBookImported});

  @override
  _BookImportScreenState createState() => _BookImportScreenState();
}

class _BookImportScreenState extends State<BookImportScreen> {
  final Set<String> _importedFilePaths = {};
  Book? lastImportedBook;

  Future<void> _importBook() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['epub', 'pdf', 'prc'],
      );

      if (result != null) {
        final platformFile = result.files.single;
        String? filePath = platformFile.path;

        if (filePath == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('File path is invalid.')),
          );
          return;
        }

        if (_importedFilePaths.contains(filePath)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    'This file has already been imported: ${platformFile.name}')),
          );
          return;
        }

        _importedFilePaths.add(filePath);
        final book = await _extractMetadata(filePath);

        setState(() {
          lastImportedBook = book;
        });

        widget.onBookImported(book);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Book imported: ${book.title}')),
        );
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

  Future<Book> _extractMetadata(String filePath) async {
    String fileName = filePath.split('/').last;
    String title = fileName.split('.').first;
    String author = 'Unknown Author';

    if (fileName.contains('-')) {
      final parts = fileName.split('-');
      if (parts.length >= 2) {
        author = parts[0].trim();
        title = parts[1].split('.').first.trim();
      }
    }

    return Book(
      title: title,
      author: author,
      isbn: 'N/A',
      coverUrl: filePath,
      description: 'Imported from local file.',
      pageCount: null,
      publishDate: null,
      categories: [],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Import Books'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: _importBook,
              child: const Text('Import Book'),
            ),
            const SizedBox(height: 20),
            if (lastImportedBook != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
