import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../models/books.dart';

class BookImportScreen extends StatefulWidget {
  final Function(Book) onBookImported;

  const BookImportScreen({super.key, required this.onBookImported});

  @override
  _BookImportScreenState createState() => _BookImportScreenState();
}

class _BookImportScreenState extends State<BookImportScreen> {
  final Set<String> _importedFilePaths = {};

  Future<void> _requestPermissions() async {
    PermissionStatus status = await Permission.storage.request();
    if (status.isGranted) {
      _importBook();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Storage permission denied')),
      );
    }
  }

  Future<void> _importBook() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['epub', 'pdf', 'prc'],
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
          onPressed: _requestPermissions,
          child: const Text('Import Book'),
        ),
      ),
    );
  }
}
