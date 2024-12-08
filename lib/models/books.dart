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

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'] ?? 'Unknown Title',
      author: json['author_name']?.join(', ') ?? 'Unknown Author',
      isbn: json['isbn']?.first ?? 'N/A',
      coverUrl: json['cover_i'] != null
          ? 'https://covers.openlibrary.org/b/id/${json['cover_i']}-L.jpg'
          : 'https://placehold.co/400',
      description: json['description'] ?? 'No description available.',
      pageCount: json['number_of_pages'] as int?,
      publishDate: json['publish_date'],
      categories: json['subject']?.cast<String>() ?? [],
    );
  }
}
