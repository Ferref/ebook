import 'package:flutter/material.dart';
import 'home/home_screen.dart';
import 'book/book_import_screen.dart';
import 'book/my_books_screen.dart';
import 'market/market_screen.dart';
import '../../models/books.dart';

class ScreensWrapper extends StatefulWidget {
  final VoidCallback onThemeToggle;

  const ScreensWrapper({super.key, required this.onThemeToggle});

  @override
  State<ScreensWrapper> createState() => _ScreensWrapperState();
}

class _ScreensWrapperState extends State<ScreensWrapper> {
  int _currentIndex = 0;
  Book? _lastOpenedBook;
  List<Book> _ownedBooks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DuckReader'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: widget.onThemeToggle,
          ),
        ],
      ),
      body: [
        HomeScreen(
          lastOpenedBook: _lastOpenedBook,
          ownedBooks: _ownedBooks,
          onBookAdded: (book) {
            setState(() {
              _ownedBooks.add(book);
              _lastOpenedBook = book;
            });
          },
        ),
        const MarketScreen(),
        MyBooksScreen(
          ownedBooks: _ownedBooks,
          onBookTap: (book) {
            setState(() {
              _lastOpenedBook = book;
            });
          },
        ),
        BookImportScreen(
          onBookImported: (book) {
            setState(() {
              _ownedBooks.add(book);
              _lastOpenedBook = book;
            });
          },
        ),
      ][_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Market'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'My Books'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Import'),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
