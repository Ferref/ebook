import 'package:flutter/material.dart';

class BookImportScreen extends StatelessWidget {
  const BookImportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Import Books"),
      ),
      body: Center(
        child: const Text("File import functionality will appear here."),
      ),
    );
  }
}
