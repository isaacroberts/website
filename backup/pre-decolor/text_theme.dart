import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme.dart';

TextTheme fonts_2 = TextTheme(
  headlineLarge: GoogleFonts.poppins(
      // color: colorScheme.onPrimary,
      fontSize: 96,
      fontWeight: FontWeight.w400,
      letterSpacing: 0),
  headlineMedium: GoogleFonts.poppins(
      fontSize: 60, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  headlineSmall: GoogleFonts.poppins(
      fontSize: 34,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: colorScheme.secondary),
  displayLarge: GoogleFonts.poppins(
    letterSpacing: 0.25,
    fontSize: 34,
    fontWeight: FontWeight.w400,
  ),
  displayMedium: GoogleFonts.poppins(
    letterSpacing: 0.25,
    fontSize: 34,
    fontWeight: FontWeight.w400,
  ),
  displaySmall: GoogleFonts.poppins(
    letterSpacing: 0.25,
    fontSize: 34,
    fontWeight: FontWeight.w400,
  ),
  // subtitle1: GoogleFonts.poppins(
  //     fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  // subtitle2: GoogleFonts.poppins(
  //     fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyLarge: GoogleFonts.poppins(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyMedium: GoogleFonts.poppins(
      fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  bodySmall: GoogleFonts.poppins(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.25),
); //.apply(
// bodyColor: colorScheme.onBackground,
// displayColor: colorScheme.primary,
// );

TextTheme fonts = GoogleFonts.poppinsTextTheme();
