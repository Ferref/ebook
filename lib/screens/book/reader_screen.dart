import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:epub_view/epub_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import '../../models/books.dart';

class ReaderScreen extends StatefulWidget {
  final Book book;

  const ReaderScreen({super.key, required this.book});

  @override
  // ignore: library_private_types_in_public_api
  _ReaderScreenState createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  late EpubController _epubController;
  String? _lastPosition;

  @override
  void initState() {
    super.initState();
    _loadLastPosition();
    _initializeEpubController();
  }

  Future<void> _initializeEpubController() async {
    Uint8List? fileBytes;

    if (widget.book.filePath != null) {
      final file = File(widget.book.filePath!);
      fileBytes = await file.readAsBytes();
    } else if (widget.book.fileBytes != null) {
      fileBytes = widget.book.fileBytes;
    }

    if (fileBytes != null) {
      setState(() {
        _epubController = EpubController(
          document: EpubDocument.openData(fileBytes!),
          epubCfi: _lastPosition,
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load the book.')),
      );
    }
  }

  Future<void> _loadLastPosition() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _lastPosition = prefs.getString('last_position_${widget.book.title}');
    });
  }

  Future<void> _saveCurrentPosition() async {
    final cfi = _epubController.generateEpubCfi();
    if (cfi != null) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('last_position_${widget.book.title}', cfi);
    }
  }

  @override
  void dispose() {
    _saveCurrentPosition();
    _epubController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!mounted || _epubController == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: EpubViewActualChapter(
          controller: _epubController,
          builder: (chapterValue) => Text(
            chapterValue?.chapter?.Title?.replaceAll('\n', '').trim() ?? '',
            textAlign: TextAlign.start,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark),
            onPressed: () async {
              await _saveCurrentPosition();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Bookmark saved!')),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: EpubViewTableOfContents(controller: _epubController),
      ),
      body: EpubView(
        controller: _epubController,
        builders: EpubViewBuilders<DefaultBuilderOptions>(
          options: const DefaultBuilderOptions(),
          chapterDividerBuilder: (_) => const Divider(),
        ),
      ),
    );
  }
}
