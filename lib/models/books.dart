class Book {
  final String title;
  final String author;
  final String isbn;
  final String coverUrl;

  Book({
    required this.title,
    required this.author,
    required this.isbn,
    required this.coverUrl,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'] ?? 'Unknown Title',
      author: json['author_name'] != null
          ? (json['author_name'] as List).join(', ')
          : 'Unknown Author',
      isbn: json['isbn'] != null ? json['isbn'][0] : 'N/A',
      coverUrl: json['cover_i'] != null
          ? 'https://covers.openlibrary.org/b/id/${json['cover_i']}-L.jpg'
          : 'https://placehold.co/400', // Placeholder kep
    );
  }
}
