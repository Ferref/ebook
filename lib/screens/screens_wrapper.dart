import 'package:flutter/material.dart';
import 'home/home_screen.dart';
import 'book/my_books_screen.dart';
import 'book/book_import_screen.dart';
import 'market/market_screen.dart';
import 'settings/settings_screen.dart';
import '../../models/books.dart';

class ScreensWrapper extends StatefulWidget {
  final Function(bool isDarkMode) onDarkModeToggle;
  final bool isDarkMode;

  const ScreensWrapper({
    super.key,
    required this.onDarkModeToggle,
    required this.isDarkMode,
  });

  @override
  State<ScreensWrapper> createState() => _ScreensWrapperState();
}

class _ScreensWrapperState extends State<ScreensWrapper> {
  int _currentIndex = 0;
  Book? _lastOpenedBook;
  final List<Book> _ownedBooks = [];
  Color _primaryColor = Colors.blue;
  Color _secondaryColor = Colors.yellow;

  void _updateColors(Color primary, Color secondary, bool isDarkMode) {
    setState(() {
      _primaryColor = primary;
      _secondaryColor = secondary;
      widget.onDarkModeToggle(isDarkMode);
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
    final backgroundColor = widget.isDarkMode ? Colors.black : Colors.white;

    return Scaffold(
      backgroundColor: backgroundColor,
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
        backgroundColor: backgroundColor,
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
