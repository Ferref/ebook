import 'dart:async';
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

  @override
  void initState() {
    super.initState();
    _startDelayTimer();
  }

  void _startDelayTimer() {
    Timer(const Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ebook Reader',
      theme: ebookTheme,
      home: _isLoading ? _buildLoadingScreen() : const ScreensWrapper(),
    );
  }

  Widget _buildLoadingScreen() {
    return Center(
      child: Image.asset(
        'assets/images/walkingduck.gif',
        fit: BoxFit.contain,
        width: MediaQuery.of(context).size.width * 0.25,
        height: MediaQuery.of(context).size.height * 0.25,
      ),
    );
  }
}
