import 'package:flutter/material.dart';
import 'package:ebook/screens/home/home_screen.dart';
import 'package:ebook/screens/market/market_screen.dart';
import 'package:ebook/screens/book/book_import_screen.dart';
import 'package:ebook/screens/book/my_books_screen.dart';
import 'package:ebook/models/books.dart';

class ScreensWrapper extends StatefulWidget {
  const ScreensWrapper({super.key});

  @override
  _ScreensWrapperState createState() => _ScreensWrapperState();
}

class _ScreensWrapperState extends State<ScreensWrapper> {
  int _currentIndex = 0;

  // Mock data to pass to HomeScreen
  final Book? _lastOpenedBook = Book(
    title: "Example Book",
    author: "Author Name",
    isbn: "123456789",
    coverUrl: "https://placehold.co/400",
    description: "This is a description of the last opened book.",
    pageCount: 200,
    publishDate: "2023",
    categories: ["Fiction", "Drama"],
  );

  final List<Book> _currentlyReadingBooks = [
    Book(
      title: "Currently Reading 1",
      author: "Author A",
      isbn: "123456789",
      coverUrl: "https://placehold.co/400",
      description: "This is a description of a currently reading book.",
      pageCount: 300,
      publishDate: "2022",
      categories: ["Adventure"],
    ),
    Book(
      title: "Currently Reading 2",
      author: "Author B",
      isbn: "987654321",
      coverUrl: "https://placehold.co/400",
      description: "This is another currently reading book.",
      pageCount: 250,
      publishDate: "2021",
      categories: ["Mystery"],
    ),
  ];

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    // Initialize the pages with data
    _pages = [
      HomeScreen(
        lastOpenedBook: _lastOpenedBook,
        currentlyReadingBooks: _currentlyReadingBooks,
      ),
      const MarketScreen(),
      const MyBooksScreen(),
      const BookImportScreen(),
    ];
  }

  void _navigateToPage(int index) {
    setState(() {
      _currentIndex = index;
    });
    Navigator.pop(context); // Close the drawer after navigation
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'DuckReader Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () => _navigateToPage(0), // Navigate to Home
            ),
            ListTile(
              leading: const Icon(Icons.store),
              title: const Text('Market'),
              onTap: () => _navigateToPage(1), // Navigate to Market
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('My Books'),
              onTap: () => _navigateToPage(2), // Navigate to My Books
            ),
            ListTile(
              leading: const Icon(Icons.import_contacts),
              title: const Text('Import Books'),
              onTap: () => _navigateToPage(3), // Navigate to Import Books
            ),
          ],
        ),
      ),
    );
  }
}
