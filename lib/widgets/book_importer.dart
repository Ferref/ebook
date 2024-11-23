import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class BookImporter extends StatefulWidget {
  final Function(String) onBookImported;

  const BookImporter({super.key, required this.onBookImported});

  @override
  _BookImporterState createState() => _BookImporterState();
}

class _BookImporterState extends State<BookImporter> {
  Future<void> _importBook() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['epub', 'pdf', 'prc'],
    );

    if (!mounted) {
      return; // Ellenőrizzük, hogy a widget még mounted állapotban van-e.
    }

    if (result != null && result.files.single.path != null) {
      String filePath = result.files.single.path!;
      widget.onBookImported(filePath);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Book imported: ${result.files.single.name}')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No file selected.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _importBook,
      child: Text('Import Book'),
    );
  }
}
