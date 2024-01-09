import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'full_color.dart';
import 'theme.dart';

var _displayFont = GoogleFonts.prompt;
var _headerFont = _body;
var _titleFont = _body;
var _body = GoogleFonts.ibmPlexSans;
var _labelFont = GoogleFonts.sourceCodePro;

const Color bodyColor = Dark_;
const Color biggestColor = secondary;
Color biggerColor = secondary;
Color smallColor = secondary;
Color labelFont = Grayscale.shade600.withOpacity(.8);

// TextTheme fonts = GoogleFonts.promptTextTheme();

const double fontScale = 1;

TextTheme fonts = TextTheme(
  displayLarge: _displayFont(
    letterSpacing: 1,
    fontSize: 57 * fontScale,
    fontWeight: FontWeight.w600,
    color: biggestColor,
  ),
  displayMedium: _displayFont(
    letterSpacing: 2,
    fontSize: 52 * fontScale,
    // height: ,
    fontWeight: FontWeight.w300,
    color: biggerColor,
  ),
  displaySmall: _displayFont(
    letterSpacing: 1.5,
    fontSize: 44 * fontScale,
    fontWeight: FontWeight.w500,
    color: smallColor,
  ),
  // headlineLarge: _headerFont(
  //   color: biggestColor,
  //   letterSpacing: 1,
  //   fontSize: 40,
  //   fontWeight: FontWeight.w200,
  // ),
  headlineMedium: _headerFont(
    color: biggerColor,
    fontSize: 36 * fontScale,
    letterSpacing: -0.5,
    fontWeight: FontWeight.w600,
  ),
  headlineSmall: _headerFont(
    color: smallColor,
    fontSize: 32 * fontScale,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.25,
  ),
  titleLarge: _titleFont(
    color: bodyColor,
    fontSize: 28 * fontScale,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.5,
    height: 1.5,
  ),
  titleMedium: _titleFont(
    color: bodyColor,
    fontSize: 24 * fontScale,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.25,
    height: 1.5,
  ),
  titleSmall: _titleFont(
    color: bodyColor,
    fontSize: 20 * fontScale,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.25,
    height: 1.5,
  ),
  bodyLarge: _body(
    color: bodyColor,
    fontSize: 24 * fontScale,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    height: 1.5,
  ),
  bodyMedium: _body(
    color: bodyColor,
    fontSize: 20 * fontScale,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.5,
  ),
  bodySmall: _body(
    color: bodyColor,
    fontSize: 16 * fontScale,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.5,
  ),
  labelLarge:
      _labelFont(fontSize: 14, fontWeight: FontWeight.w300, letterSpacing: 0.5),
  labelMedium:
      _labelFont(fontSize: 12, fontWeight: FontWeight.w300, letterSpacing: 0.5),
  labelSmall:
      _labelFont(fontSize: 11, fontWeight: FontWeight.w300, letterSpacing: 0.5),
);

TextTheme watchFonts = GoogleFonts.promptTextTheme();

// TextStyle watchHeaderLarge = _displayFont(
//   letterSpacing: 1.5,
//   height: 1.2,
//   fontSize: 30,
//   fontWeight: FontWeight.w600,
//   color: displayColor,
// );
// TextStyle watchHeader = _displayFont(
//   letterSpacing: 1,
//   fontSize: 16,
//   fontWeight: FontWeight.w600,
//   color: displayColor,
// );
// TextStyle watchSubt = _headerFont(
//   color: Colors.white,
//   fontSize: 18,
//   letterSpacing: 0,
//   fontWeight: FontWeight.w500,
// );
// TextStyle watchBody = _body(
//   color: Colors.white,
//   fontSize: 12,
//   fontWeight: FontWeight.w400,
//   letterSpacing: 0.5,
//   height: 1.5,
// );
// TextStyle watchLabel = _body(
//   color: Colors.orange,
//   fontSize: 14,
//   fontWeight: FontWeight.w300,
//   letterSpacing: 0.5,
//   height: 1.5,
// );
//
// TextTheme watchFonts = TextTheme(
//     displayLarge: watchHeaderLarge,
//     displayMedium: watchHeaderLarge,
//     displaySmall: watchHeader,
//     headlineLarge: watchHeader,
//     headlineMedium: watchSubt,
//     headlineSmall: watchSubt,
//     titleLarge: watchHeader,
//     titleMedium: watchSubt,
//     titleSmall: watchSubt,
//     bodyLarge: watchBody,
//     bodyMedium: watchBody,
//     bodySmall: watchBody,
//     labelLarge: watchLabel,
//     labelMedium: watchLabel,
//     labelSmall: watchLabel);
