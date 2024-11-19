import '../models/books.dart';

List<Book> getBooksByType(Category category) {
  List<Book> allBooks = getAllBooks();
  return allBooks.where((book) => book.category == category).toList();
}

List<Book> getBooksByPurchased() {
  List<Book> allBooks = getAllBooks();
  return allBooks.where((book) => book.isPurchased == true).toList();
}

List<Book> getBooksByFree() {
  List<Book> allBooks = getAllBooks();
  return allBooks.where((book) => book.isFree == true).toList();
}

List<Book> getBooksByOpenPage(int page) {
  List<Book> allBooks = getAllBooks();
  return allBooks.where((book) => book.lastOpenPage >= page).toList();
}

List<Book> getAllBooks() {
  return [
    Book(
      title: 'The Psychology of Money',
      category: Category.business,
      isbn: '9780857197689',
      price: 14.99,
      isFree: false,
      isPurchased: true,
      description:
          'Timeless lessons on wealth, greed, and happiness. This book delves into the ways people think about money and how to make better financial decisions.',
      rating: 4.8,
      yearRelease: 2020,
      pages: 256,
      authorName: 'Morgan Housel',
      imageUrl:
          'https://m.media-amazon.com/images/I/41-gSPHCR0L._SY344_BO1,204,203,200_.jpg',
      lastOpenPage: 120,
      totalXP: 400,
    ),
    Book(
      title: 'Sapiens: A Brief History of Humankind',
      category: Category.history,
      isbn: '9780062316097',
      price: 18.99,
      isFree: false,
      isPurchased: false,
      description:
          'A fascinating journey through the history of humankind, exploring how biology and history have defined us and enhanced our understanding of what it means to be human.',
      rating: 4.9,
      yearRelease: 2014,
      pages: 512,
      authorName: 'Yuval Noah Harari',
      imageUrl:
          'https://m.media-amazon.com/images/I/41yLVoPrYFL._SX331_BO1,204,203,200_.jpg',
      lastOpenPage: 0,
      totalXP: 0,
    ),
    Book(
      title: 'Becoming',
      category: Category.biography,
      isbn: '9781524763138',
      price: 0.00,
      isFree: true,
      isPurchased: true,
      description:
          'An intimate, powerful, and inspiring memoir by the former First Lady of the United States, Michelle Obama.',
      rating: 4.7,
      yearRelease: 2018,
      pages: 448,
      authorName: 'Michelle Obama',
      imageUrl:
          'https://m.media-amazon.com/images/I/51Hlp8ND33L._SX329_BO1,204,203,200_.jpg',
      lastOpenPage: 220,
      totalXP: 700,
    ),
    Book(
      title: 'Atomic Habits',
      category: Category.selfHelp,
      isbn: '9780735211292',
      price: 11.99,
      isFree: false,
      isPurchased: false,
      description:
          'A guide to building better habits with small changes that compound into remarkable results over time.',
      rating: 4.8,
      yearRelease: 2018,
      pages: 320,
      authorName: 'James Clear',
      imageUrl:
          'https://m.media-amazon.com/images/I/51-ML3Jxl6L._SY344_BO1,204,203,200_.jpg',
      lastOpenPage: 0,
      totalXP: 0,
    ),
    Book(
      title: 'The Midnight Library',
      category: Category.fantasy,
      isbn: '9780525559474',
      price: 9.99,
      isFree: false,
      isPurchased: true,
      description:
          'Between life and death lies a library, where every book offers a chance to try another life you could have lived.',
      rating: 4.6,
      yearRelease: 2020,
      pages: 304,
      authorName: 'Matt Haig',
      imageUrl:
          'https://m.media-amazon.com/images/I/41ks+NsTzxL._SY344_BO1,204,203,200_.jpg',
      lastOpenPage: 150,
      totalXP: 500,
    ),
  ];
}
