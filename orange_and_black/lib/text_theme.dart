import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'full_color.dart';
import 'theme.dart';

// var _font = GoogleFonts.ibmPlexSans; //sourceSansPro

// var f = GoogleFonts.ibmPlexSans();

const Color displayColor = Primary_; //Primary.shade700;
const Color boldColor = Colors.white;
// Color bodyColor = secondary.shade50; //Color(0xffe5e5d0);

// TextStyle _body({
//   // TextStyle? textStyle,
//   Color? color,
//   Color? backgroundColor,
//   double? fontSize,
//   FontWeight? fontWeight,
//   FontStyle? fontStyle,
//   double? letterSpacing,
//   double? wordSpacing,
//   TextBaseline? textBaseline,
//   double? height,
//   Locale? locale,
//   Paint? foreground,
//   Paint? background,
//   // List<ui.Shadow>? shadows,
//   // List<ui.FontFeature>? fontFeatures,
//   TextDecoration? decoration,
//   Color? decorationColor,
//   TextDecorationStyle? decorationStyle,
//   double? decorationThickness,
// }) {
//   // letterSpacing ??= 0;
//   // letterSpacing += .1;
//   // wordSpacing = 1;
//   return GoogleFonts.ibmPlexSans(
//     // textStyle: textStyle,
//     color: color,
//     backgroundColor: backgroundColor,
//     fontSize: fontSize,
//     fontWeight: fontWeight,
//     fontStyle: fontStyle,
//     letterSpacing: letterSpacing,
//     wordSpacing: wordSpacing,
//     textBaseline: textBaseline,
//     height: height,
//     locale: locale,
//     foreground: foreground,
//     background: background,
//     // shadows: shadows,
//     // fontFeatures: fontFeatures,
//     decoration: decoration,
//     decorationColor: decorationColor,
//     decorationStyle: decorationStyle,
//     decorationThickness: decorationThickness,
//   );
// }

TextStyle _font({
  // TextStyle? textStyle,
  Color? color,
  Color? backgroundColor,
  double? fontSize,
  FontWeight? fontWeight,
  FontStyle? fontStyle,
  double? letterSpacing,
  double? wordSpacing,
  TextBaseline? textBaseline,
  double? height,
  Locale? locale,
  Paint? foreground,
  Paint? background,
  // List<ui.Shadow>? shadows,
  // List<ui.FontFeature>? fontFeatures,
  TextDecoration? decoration,
  Color? decorationColor,
  TextDecorationStyle? decorationStyle,
  double? decorationThickness,
}) {
  wordSpacing = 1;
  return GoogleFonts.ibmPlexMono(
    // textStyle: textStyle,
    color: color,
    backgroundColor: backgroundColor,
    fontSize: fontSize,
    fontWeight: fontWeight,
    fontStyle: fontStyle,
    letterSpacing: letterSpacing,
    wordSpacing: wordSpacing,
    textBaseline: textBaseline,
    height: height,
    locale: locale,
    foreground: foreground,
    background: background,
    // shadows: shadows,
    // fontFeatures: fontFeatures,
    decoration: decoration,
    decorationColor: decorationColor,
    decorationStyle: decorationStyle,
    decorationThickness: decorationThickness,
  );
}

var _body = GoogleFonts.ibmPlexSans;
var _displayFont = GoogleFonts.ibmPlexSansCondensed;
var _headerFont = _displayFont;

TextTheme fonts = TextTheme(
  displayLarge: _displayFont(
    letterSpacing: 1,
    fontSize: 57,
    fontWeight: FontWeight.w600,
    color: displayColor,
  ),
  displayMedium: _displayFont(
    letterSpacing: 2,
    fontSize: 45,
    // height: ,
    fontWeight: FontWeight.w600,
    color: displayColor,
  ),
  displaySmall: _displayFont(
    letterSpacing: 1.5,
    fontSize: 36,
    fontWeight: FontWeight.w600,
    color: displayColor,
  ),
  headlineLarge: _headerFont(
    color: Sec1Light.v5,
    letterSpacing: 1,
    fontSize: 96,
    fontWeight: FontWeight.w200,
  ),
  headlineMedium: _headerFont(
    color: Sec1Light.v8,
    fontSize: 60,
    letterSpacing: -0.5,
    fontWeight: FontWeight.w500,
  ),
  headlineSmall: _headerFont(
    color: Sec1Light.v10,
    fontSize: 34,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.25,
  ),
  titleLarge: _body(
    color: boldColor,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.5,
    height: 1.5,
  ),
  titleMedium: _font(
    color: boldColor,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.25,
    height: 1.5,
  ),
  titleSmall: _font(
    color: boldColor,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.25,
    height: 1.5,
  ),
  bodyLarge: _body(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    height: 1.5,
  ),
  bodyMedium: _body(
    color: Colors.white,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.5,
  ),
  bodySmall: _body(
    color: Colors.white,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.5,
  ),
  labelLarge:
      _body(fontSize: 14, fontWeight: FontWeight.w300, letterSpacing: 0.5),
  labelMedium:
      _body(fontSize: 12, fontWeight: FontWeight.w300, letterSpacing: 0.5),
  labelSmall:
      _body(fontSize: 11, fontWeight: FontWeight.w300, letterSpacing: 0.5),
);

TextStyle watchHeaderLarge = _displayFont(
  letterSpacing: 1.5,
  height: 1.2,
  fontSize: 30,
  fontWeight: FontWeight.w600,
  color: displayColor,
);
TextStyle watchHeader = _displayFont(
  letterSpacing: 1,
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: displayColor,
);
TextStyle watchSubt = _headerFont(
  color: Colors.white,
  fontSize: 18,
  letterSpacing: 0,
  fontWeight: FontWeight.w500,
);
TextStyle watchBody = _body(
  color: Colors.white,
  fontSize: 12,
  fontWeight: FontWeight.w400,
  letterSpacing: 0.5,
  height: 1.5,
);
TextStyle watchLabel = _body(
  color: Colors.orange,
  fontSize: 14,
  fontWeight: FontWeight.w300,
  letterSpacing: 0.5,
  height: 1.5,
);

TextTheme watchFonts = TextTheme(
    displayLarge: watchHeaderLarge,
    displayMedium: watchHeaderLarge,
    displaySmall: watchHeader,
    headlineLarge: watchHeader,
    headlineMedium: watchSubt,
    headlineSmall: watchSubt,
    titleLarge: watchHeader,
    titleMedium: watchSubt,
    titleSmall: watchSubt,
    bodyLarge: watchBody,
    bodyMedium: watchBody,
    bodySmall: watchBody,
    labelLarge: watchLabel,
    labelMedium: watchLabel,
    labelSmall: watchLabel);
