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
  textTheme: TextTheme(
    titleSmall: GoogleFonts.aboreto(
      fontSize: 12,
      color: Colors.white,
    ),
    titleMedium: GoogleFonts.aboreto(
      fontSize: 16,
      color: Colors.white,
    ),
    titleLarge: GoogleFonts.aboreto(
      fontSize: 20,
      color: Colors.black,
    ),
    labelSmall: GoogleFonts.gildaDisplay(
      fontSize: 20,
    ),
    labelMedium: GoogleFonts.gildaDisplay(
      fontSize: 26,
    ),
    labelLarge: GoogleFonts.gildaDisplay(
      fontSize: 32,
    ),
    bodySmall: GoogleFonts.gildaDisplay(
      fontSize: 20,
    ),
    bodyMedium: GoogleFonts.gildaDisplay(
      fontSize: 26,
    ),
    bodyLarge: GoogleFonts.gildaDisplay(
      fontSize: 32,
    ),
    headlineLarge: GoogleFonts.gildaDisplay(
      fontSize: 30,
      color: Colors.white,
      fontWeight: FontWeight.w500,
    ),
    headlineMedium: GoogleFonts.gildaDisplay(
      fontSize: 30,
      color: Colors.white,
      fontWeight: FontWeight.w500,
    ),
    headlineSmall: GoogleFonts.gildaDisplay(
      fontSize: 30,
      color: Colors.white,
      fontWeight: FontWeight.w500,
    ),
  ),
  iconTheme: const IconThemeData(color: Colors.purple),
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.purple,
  ),
);
