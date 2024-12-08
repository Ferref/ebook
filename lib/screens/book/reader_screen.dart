import 'package:flutter/material.dart';
import '../../models/books.dart';

class ReaderScreen extends StatefulWidget {
  final Book book;
  final int? lastReadPage;

  const ReaderScreen({super.key, required this.book, this.lastReadPage});

  @override
  _ReaderScreenState createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    currentPage = widget.lastReadPage ?? 0; // Start at last read page or page 0
  }

  void _goToNextPage() {
    setState(() {
      currentPage++;
    });
  }

  void _goToPreviousPage() {
    setState(() {
      currentPage = (currentPage > 0) ? currentPage - 1 : 0;
    });
  }

  @override
  void dispose() {
    Navigator.pop(context, currentPage); // Pass back the current page
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.book.title)),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(
                'Reading page: $currentPage',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _goToPreviousPage,
                child: const Text('Previous Page'),
              ),
              ElevatedButton(
                onPressed: _goToNextPage,
                child: const Text('Next Page'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
