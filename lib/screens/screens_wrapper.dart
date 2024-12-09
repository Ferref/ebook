import 'package:flutter/material.dart';
import 'home/home_screen.dart';
import 'book/my_books_screen.dart';
import 'book/book_import_screen.dart';
import 'market/market_screen.dart';
import 'settings/settings_screen.dart';
import '../../models/books.dart';

class ScreensWrapper extends StatefulWidget {
  const ScreensWrapper({super.key});

  @override
  State<ScreensWrapper> createState() => _ScreensWrapperState();
}

class _ScreensWrapperState extends State<ScreensWrapper> {
  int _currentIndex = 0;
  Book? _lastOpenedBook;
  final List<Book> _ownedBooks = [];
  Color _primaryColor = Colors.blue;
  Color _secondaryColor = Colors.yellow;
  Color _backgroundColor = Colors.black;

  void _updateColors(Color primary, Color secondary, Color background) {
    setState(() {
      _primaryColor = primary;
      _secondaryColor = secondary;
      _backgroundColor = background;
    });
  }

  void _addBook(Book book) {
    setState(() {
      _ownedBooks.add(book);
      _lastOpenedBook = book;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        HomeScreen(
          lastOpenedBook: _lastOpenedBook,
          ownedBooks: _ownedBooks,
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
            _addBook(book);
          },
        ),
        SettingsScreen(
          onColorChange: _updateColors,
        ),
      ][_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: _primaryColor,
        unselectedItemColor: _secondaryColor,
        backgroundColor: _backgroundColor,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Market'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'My Books'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Import'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
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
