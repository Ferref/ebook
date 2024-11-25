import 'package:flutter/material.dart';

class MyBooksScreen extends StatelessWidget {
  const MyBooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Books"),
      ),
      body: Center(
        child: const Text("List of downloaded books will appear here."),
      ),
    );
  }
}
