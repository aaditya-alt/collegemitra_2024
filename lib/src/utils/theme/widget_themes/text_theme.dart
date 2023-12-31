import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TTextTheme {
  TTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: GoogleFonts.montserrat(
      fontWeight: FontWeight.w700,
      color: Colors.black87,
      fontSize: 32,
    ),
    headlineMedium: GoogleFonts.montserrat(
      fontWeight: FontWeight.w700,
      color: Colors.black87,
      fontSize: 26,
    ),
    headlineSmall: GoogleFonts.montserrat(
      fontWeight: FontWeight.w700,
      color: Colors.black87,
      fontSize: 20,
    ),
    displaySmall: GoogleFonts.montserrat(
      fontWeight: FontWeight.w700,
      color: Colors.black87,
    ),
    titleSmall: GoogleFonts.poppins(
      color: Colors.black54,
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: GoogleFonts.montserrat(
      fontWeight: FontWeight.w700,
      color: Colors.black87,
      fontSize: 18,
    ),
    titleLarge: GoogleFonts.montserrat(
      fontWeight: FontWeight.w700,
      color: Colors.black87,
      fontSize: 22,
    ),
    bodySmall: GoogleFonts.poppins(
      color: Colors.black87,
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
  );
  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: GoogleFonts.montserrat(
      fontWeight: FontWeight.w700,
      color: Colors.white,
      fontSize: 32,
    ),
    headlineMedium: GoogleFonts.montserrat(
      fontWeight: FontWeight.w700,
      color: Colors.white,
      fontSize: 26,
    ),
    headlineSmall: GoogleFonts.montserrat(
      fontWeight: FontWeight.w700,
      color: Colors.white,
      fontSize: 20,
    ),
    displaySmall: GoogleFonts.montserrat(
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    titleSmall: GoogleFonts.poppins(
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: GoogleFonts.montserrat(
      fontWeight: FontWeight.w700,
      color: Colors.white,
      fontSize: 18,
    ),
    titleLarge: GoogleFonts.montserrat(
      fontWeight: FontWeight.w700,
      color: Colors.white,
      fontSize: 22,
    ),
    bodySmall: GoogleFonts.poppins(
      color: Colors.white,
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
  );
}
