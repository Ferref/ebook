import 'package:flutter/material.dart';
import 'package:ebook/themes/app_theme.dart';
import 'package:ebook/screens/screens_wrapper.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoading = true;
  ThemeMode _themeMode = ThemeMode.system; // Default to system theme

  void toggleThemeMode() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  void initState() {
    super.initState();
    _startDelayTimer();
  }

  void _startDelayTimer() {
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DuckReader',
      theme: ebookTheme, // Light theme
      darkTheme: ebookDarkTheme, // Dark theme
      themeMode: _themeMode, // Toggle between light and dark themes
      home: _isLoading
          ? _buildLoadingScreen()
          : ScreensWrapper(onThemeToggle: toggleThemeMode),
    );
  }

  Widget _buildLoadingScreen() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/readingduck.png',
              width: 120,
              height: 120,
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(color: Colors.purple),
            const SizedBox(height: 10),
            const Text(
              'Loading DuckReader...',
              style: TextStyle(fontSize: 16, color: Colors.purple),
            ),
          ],
        ),
      ),
    );
  }
}
