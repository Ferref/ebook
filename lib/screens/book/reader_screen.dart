import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:epubx/epubx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/books.dart';

class ReaderScreen extends StatefulWidget {
  final Book book;
  final Uint8List fileBytes;

  const ReaderScreen({
    super.key,
    required this.book,
    required this.fileBytes,
  });

  @override
  _ReaderScreenState createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  EpubBookRef? _epubBookRef;
  bool _isLoading = true;
  String? _errorMessage;
  int _lastLocation = 0;

  @override
  void initState() {
    super.initState();
    _loadEpubBook();
  }

  Future<void> _loadEpubBook() async {
    try {
      final epubBookRef = await EpubReader.openBook(widget.fileBytes);
      final prefs = await SharedPreferences.getInstance();
      final lastLocation =
          prefs.getInt('last_position_${widget.book.title}') ?? 0;

      setState(() {
        _epubBookRef = epubBookRef;
        _lastLocation = lastLocation;
        _isLoading = false;
      });

      _navigateToLastPosition();
    } catch (e) {
      setState(() {
        _errorMessage = "Failed to load the book: $e";
        _isLoading = false;
      });
    }
  }

  Future<void> _saveCurrentPosition(int location) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('last_position_${widget.book.title}', location);
    setState(() {
      _lastLocation = location;
    });
  }

  void _navigateToLastPosition() {
    if (_lastLocation > 0 && _epubBookRef != null) {}
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
