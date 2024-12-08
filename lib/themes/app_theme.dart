import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    bodyMedium: GoogleFonts.openSans(fontSize: 16, color: Colors.grey[800]),
    headlineMedium: GoogleFonts.poppins(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.deepPurple,
    ),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.deepPurple,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.deepPurple,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
);
