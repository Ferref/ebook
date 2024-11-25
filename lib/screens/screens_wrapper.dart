import 'package:flutter/material.dart';
import 'package:ebook/screens/home/home_screen.dart';

class ScreensWrapper extends StatelessWidget {
  const ScreensWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomeScreen(), // Only display the HomeScreen
    );
  }
}
