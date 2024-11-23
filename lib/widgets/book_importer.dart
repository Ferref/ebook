import 'dart:typed_data';
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class BookImporter extends StatefulWidget {
  final Function(String, Uint8List?) onBookImported;

  const BookImporter({super.key, required this.onBookImported});

  @override
  _BookImporterState createState() => _BookImporterState();
}

class _BookImporterState extends State<BookImporter> {
  Future<void> _importBook() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['epub', 'pdf', 'prc'],
      );

      if (result != null) {
        final platformFile = result.files.single;

        if (kIsWeb) {
          // Web platform: Use bytes, path is unavailable
          final fileBytes = platformFile.bytes;
          final fileName = platformFile.name;
          print('Web file imported: $fileName with ${fileBytes?.length} bytes');

          if (mounted) {
            widget.onBookImported(fileName, fileBytes);
          }
        } else {
          // Android/iOS: Use path
          final filePath = platformFile.path;
          if (filePath != null) {
            print('Mobile file imported: $filePath');

            if (mounted) {
              widget.onBookImported(filePath, null);
            }
          } else {
            throw Exception('File path is null on mobile platform.');
          }
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No file selected.')),
          );
        }
      }
    } catch (e) {
      print('Error importing book: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error importing book: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _importBook,
      child: const Text('Import Book'),
    );
  }
}
