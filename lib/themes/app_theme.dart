import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Light Theme
final ThemeData ebookTheme = ThemeData(
  scaffoldBackgroundColor: Colors.grey[50],
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.deepPurple,
    elevation: 0,
    titleTextStyle: GoogleFonts.lobster(
      fontSize: 24,
      color: Colors.white,
    ),
  ),
  textTheme: TextTheme(
    bodyMedium: GoogleFonts.openSans(fontSize: 16, color: Colors.grey[100]),
    headlineMedium: GoogleFonts.poppins(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.deepPurple,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.deepPurple,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
);

// Dark Theme
final ThemeData ebookDarkTheme = ThemeData(
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.black87,
    elevation: 0,
    titleTextStyle: GoogleFonts.lobster(
      fontSize: 24,
      color: Colors.white,
    ),
  ),
  textTheme: TextTheme(
    bodyMedium: GoogleFonts.openSans(fontSize: 16, color: Colors.white),
    headlineMedium: GoogleFonts.poppins(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.grey[200],
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
);
