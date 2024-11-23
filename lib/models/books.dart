class Book {
  final String title;
  final String author;
  final String isbn;
  final String coverUrl;
  final String? description;
  final int? pageCount;
  final String? publishDate;
  final List<String> categories;

  Book({
    required this.title,
    required this.author,
    required this.isbn,
    required this.coverUrl,
    this.description,
    this.pageCount,
    this.publishDate,
    this.categories = const [],
  });

  // Factory method to create a Book object from a JSON response
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'] ?? 'Unknown Title',
      author: json['author_name'] != null
          ? (json['author_name'] as List).join(', ')
          : 'Unknown Author',
      isbn: json['isbn'] != null ? json['isbn'][0] : 'N/A',
      coverUrl: json['cover_i'] != null
          ? 'https://covers.openlibrary.org/b/id/${json['cover_i']}-L.jpg'
          : 'https://placehold.co/400',
      description: json['description'] ?? null,
      pageCount: json['number_of_pages'] ?? null,
      publishDate: json['publish_date'] ?? null,
      categories:
          json['subject'] != null ? List<String>.from(json['subject']) : [],
    );
  }

  // Factory method to create a Book object from a file path
  factory Book.fromFile(String filePath) {
    final fileType = filePath.split('.').last.toLowerCase(); // File extension
    final fileName = filePath.split('/').last; // File name

    return Book(
      title: fileName.replaceAll('.$fileType', ''), // Remove the extension
      author: 'Unknown Author',
      isbn: 'N/A',
      coverUrl: 'https://placehold.co/400', // Placeholder image for file books
      description: 'Imported from local file.',
      pageCount: null,
      publishDate: null,
      categories: [],
    );
  }
}
