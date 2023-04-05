import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'full_color.dart';
import 'theme.dart';
import 'theme_material_states.dart';

// var _font = GoogleFonts.ibmPlexSans; //sourceSansPro

// var f = GoogleFonts.ibmPlexSans();

const Color displayColor = Primary_; //Primary.shade700;
const Color boldColor = Colors.white;
// Color bodyColor = secondary.shade50; //Color(0xffe5e5d0);

var _body = GoogleFonts.ibmPlexSans;
var _displayFont = GoogleFonts.ibmPlexMono;
var _headerFont = GoogleFonts.ibmPlexSansCondensed;
var _labelFont = GoogleFonts.ibmPlexSansCondensed;

/*
90/((1+x)/2)

1: 90 (1/1)
2: 45 (1/2)
3: 36 (5/12)
4: 30 (1/3)
5: 22.5   (1/4)
6: 15   (1/6)
7: 7.5   (1/12)

6_2 = 18.75;
 */

const double size0 = 90;
const double size1 = 45;
const double size2 = 36;
const double size3 = 30;

const double size1_5 = (90 + 45) / 2;
const double size2_5 = 33;

const double size4 = 22.5;
const double size5 = 15;
const double size6 = 7.5;

const double size4_5 = 18.75;
const double size5_5 = 11.25;

const bodyColor = Color(0xf0ffffff);

TextTheme fonts = TextTheme(
  displayLarge: _displayFont(
    letterSpacing: 1,
    fontSize: size0,
    height: 1.25,
    fontWeight: FontWeight.w600,
    backgroundColor: PrimDark.v7,
    color: Colors.white,
  ),
  displayMedium: _displayFont(
    letterSpacing: 1,
    fontSize: size2,
    height: 1.5,
    fontWeight: FontWeight.w500,
    backgroundColor: PrimDark.v7,
    color: Colors.white,
  ),
  displaySmall: _displayFont(
    letterSpacing: -1,
    height: 1.5,
    fontSize: size1,
    fontWeight: FontWeight.w700,
    backgroundColor: PrimDark.v7,
    color: Colors.white,
  ),
  //orig sizes: 57, 45, 36
  headlineLarge: _headerFont(
    color: Sec1Light.v5,
    letterSpacing: 1,
    height: 2,
    fontSize: size1,
    fontWeight: FontWeight.w700,
  ),
  headlineMedium: _headerFont(
    color: Sec1Light.v8,
    height: 2,
    fontSize: size1_5,
    letterSpacing: 1,
    fontWeight: FontWeight.w500,
  ),
  headlineSmall: _headerFont(
    color: Colors.white,
    height: 2,
    fontSize: size2,
    fontWeight: FontWeight.w500,
    letterSpacing: 1,
  ),
  titleLarge: _body(
    color: titleColor,
    fontSize: size2,
    fontWeight: FontWeight.w600,
    letterSpacing: .75,
    height: 1.5,
    // shadows: [const Shadow(blurRadius: 5)]
  ),
  titleMedium: _body(
    color: titleColor,
    fontSize: size2_5,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.25,
    height: 1.5,
    // shadows: [const Shadow(blurRadius: 5)]
  ),
  titleSmall: _body(
    color: titleColor,
    fontSize: size3,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.25,
    height: 1.5,
    // shadows: [const Shadow(blurRadius: 5)]
  ),
  bodyLarge: _body(
    color: bodyColor,
    fontSize: 22.5,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    height: 1.5,
  ),
  bodyMedium: _body(
    color: bodyColor,
    fontSize: 18.75,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.5,
  ),
  bodySmall: _body(
    color: bodyColor,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.5,
  ),
  labelLarge: _labelFont(
      color: const WhiteButtonColor(),
      fontSize: 22.5,
      fontWeight: FontWeight.w300,
      letterSpacing: 0.5),
  labelMedium: _labelFont(
      color: const WhiteButtonColor(),
      fontSize: 18.75,
      fontWeight: FontWeight.w300,
      letterSpacing: 0.5),
  labelSmall: _labelFont(
      color: const WhiteButtonColor(),
      fontSize: 15,
      fontWeight: FontWeight.w300,
      letterSpacing: 0.5),
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

const titleColor = SecLight.v2;
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
