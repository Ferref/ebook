import 'package:flutter/material.dart';
import '../../models/books.dart';

class CurrentlyReading extends StatelessWidget {
  final List<Book> currentlyReadingBooks;

  const CurrentlyReading({super.key, required this.currentlyReadingBooks});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Currently Reading",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 10),
        currentlyReadingBooks.isEmpty
            ? const Text(
                "You are not currently reading any books.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              )
            : SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: currentlyReadingBooks.length,
                  itemBuilder: (context, index) {
                    final book = currentlyReadingBooks[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              book.coverUrl,
                              width: 120,
                              height: 150,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 120,
                                  height: 150,
                                  color: Colors.grey,
                                  child: const Icon(Icons.broken_image),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            width: 120,
                            child: Text(
                              book.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
      ],
    );
  }
}
