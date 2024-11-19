import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData ebookTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    elevation: 0,
    unselectedItemColor: Colors.grey[200],
    selectedItemColor: Colors.purple,
  ),
  primaryColor: Colors.white,
  appBarTheme: AppBarTheme(
    elevation: 0,
    backgroundColor: Colors.black,
    iconTheme: const IconThemeData(color: Colors.white),
    titleTextStyle: GoogleFonts.aboreto(
      letterSpacing: 1.5,
      fontSize: 24,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: Colors.purple,
    linearTrackColor: Colors.purple[200],
  ),
);
