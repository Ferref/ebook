import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import '../../models/books.dart';

class BookImportScreen extends StatefulWidget {
  final Function(Book) onBookImported;

  const BookImportScreen({Key? key, required this.onBookImported})
      : super(key: key);

  @override
  _BookImportScreenState createState() => _BookImportScreenState();
}

class _BookImportScreenState extends State<BookImportScreen> {
  final Set<String> _importedFilePaths = {};

  Future<void> _importBook() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['epub'],
      );

      if (result != null) {
        final filePath = result.files.single.path;

        if (filePath == null || _importedFilePaths.contains(filePath)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('File already imported.')),
          );
          return;
        }

        _importedFilePaths.add(filePath);

        final book = Book(
          title: result.files.single.name.split('.').first,
          author: 'Unknown',
          isbn: '',
          coverUrl: '',
          filePath: filePath,
        );

        widget.onBookImported(book);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Book imported: ${book.title}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error importing book: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Import Books')),
      body: Center(
        child: ElevatedButton(
          onPressed: _importBook,
          child: const Text('Import Book'),
        ),
      ),
    );
  }
}
