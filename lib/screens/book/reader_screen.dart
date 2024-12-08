import 'dart:io';
import 'package:flutter/material.dart';
import 'package:epubx/epubx.dart';
import '../../models/books.dart';

class ReaderScreen extends StatefulWidget {
  final Book book;

  const ReaderScreen({super.key, required this.book});

  @override
  _ReaderScreenState createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  EpubBookRef? _epubBookRef;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadEpubBook();
  }

  Future<void> _loadEpubBook() async {
    try {
      final bytes = File(widget.book.coverUrl).readAsBytesSync();
      final epubBookRef = await EpubReader.openBook(bytes);
      setState(() {
        _epubBookRef = epubBookRef;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = "Failed to load the book: $e";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.book.title),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_errorMessage != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.book.title),
        ),
        body: Center(
          child: Text(
            _errorMessage!,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.title),
      ),
      body: Center(
        child: Text(
          "Epub Book Loaded Successfully!",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
