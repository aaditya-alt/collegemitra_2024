import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TTextTheme {
  static TextTheme lightTextTheme = TextTheme(
    displayMedium: GoogleFonts.montserrat(
      fontWeight: FontWeight.w700,
      color: Colors.black87,
    ),
    headlineMedium: GoogleFonts.montserrat(
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
      fontSize: 16,
    ),
    titleMedium: GoogleFonts.montserrat(
      fontWeight: FontWeight.w700,
      color: Colors.black87,
      fontSize: 14,
    ),
    titleLarge: GoogleFonts.montserrat(
      fontWeight: FontWeight.w700,
      color: Colors.black87,
      fontSize: 26,
    ),
    bodySmall: GoogleFonts.poppins(
      color: Colors.black87,
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
  );
  static TextTheme darkTextTheme = TextTheme(
    displayMedium: GoogleFonts.montserrat(
      fontWeight: FontWeight.w700,
      color: Color.fromARGB(221, 255, 255, 255),
    ),
    displaySmall: GoogleFonts.montserrat(
      fontWeight: FontWeight.w700,
      color: const Color.fromARGB(221, 255, 255, 255),
    ),
    titleSmall: GoogleFonts.poppins(
      color: Color.fromARGB(255, 255, 255, 255),
      fontSize: 16,
    ),
    titleMedium: GoogleFonts.montserrat(
      fontWeight: FontWeight.w700,
      color: const Color.fromARGB(221, 255, 255, 255),
      fontSize: 14,
    ),
    titleLarge: GoogleFonts.montserrat(
      fontWeight: FontWeight.w700,
      color: const Color.fromARGB(221, 255, 255, 255),
      fontSize: 26,
    ),
    bodySmall: GoogleFonts.poppins(
      color: const Color.fromARGB(221, 255, 255, 255),
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
    headlineMedium: GoogleFonts.montserrat(
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
  );
}
