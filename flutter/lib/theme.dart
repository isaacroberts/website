// import 'dart:html' as html;

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isaac_roberts_consulting/full_color.dart';
import 'dart:developer';
import 'device.dart';
import 'text_theme.dart';
import 'dart:math' as math;

const double PHI = 1.61803398;
const double IPHI = .61803398;

const double borderRadius1 = 20;
const double borderRadius2 = 10;

// Only applies to tiny
const double k = 15;
const double totalTextMargin = 45;
const double standardContainerMargin = 15;
const double textContainerMargin = 30;

const double appBar = 50;

const double tinyWidth = 400;
const double watchSize = 250;

const double trioHorizWidth = 16 * k;
const double processWidth = 70 * k;
const double trioBarWidth = 60 * k;
// processWidth; //trioHorizWidth * 3 + trioHorizSpacing * 2;

void startupPrint() {
  // log(theme.scaffoldBackgroundColor.toString());
}
// const MaterialColor primary = MaterialColor(0xffdf6254, <int, Color>{
//   900: Color(0xff2b0c08),
//   800: Color(0xff561710),
//   700: Color(0xff812318),
//   600: Color(0xffac2e20),
//   500: Color(0xffd73a28),
//   400: Color(0xffdf6153),
//   300: Color(0xffe7897e),
//   200: Color(0xffefb0a9),
//   100: Color(0xfff7d8d4),
//   50: Color(0xfffbebea),
// });
// const MaterialColor secondary = MaterialColor(0xff565999, <int, Color>{
//   900: Color(0xff121321),
//   800: Color(0xff252641),
//   700: Color(0xff373962),
//   600: Color(0xff494c83),
//   500: Color(0xff5c5fa3),
//   400: Color(0xff7c7fb6),
//   300: Color(0xff9d9fc8),
//   200: Color(0xffbebfda),
//   100: Color(0xffdedfed),
//   50: Color(0xffefeff6),
// });
// const MaterialColor tertiary = MaterialColor(0xffcfb966, <int, Color>{
//   900: Color(0xff27210c),
//   800: Color(0xff4e4218),
//   700: Color(0xff756324),
//   600: Color(0xff9b8531),
//   500: Color(0xffc2a63d),
//   400: Color(0xffceb864),
//   300: Color(0xffdbc98a),
//   200: Color(0xffe7dbb1),
//   100: Color(0xfff3edd8),
//   50: Color(0xfff9f6ec),
// });

const Color primary = Color(0xffE95C46);
const Color secondary = Color(0xff2D2C4D); //[0.176,0.172,0.3019,1]
const Color tertiary = Color(0xffF1D264);
const Color canvasColor = Color(0xffF4EFEE);

const MaterialColor greyscale = MaterialColor(0xff9e9584, <int, Color>{
  900: Color(0xff1c1a17),
  800: Color(0xff39352d),
  700: Color(0xff554f44),
  600: Color(0xff726a5a),
  500: Color(0xff8e8471),
  400: Color(0xffa59d8d),
  300: Color(0xffbbb5aa),
  200: Color(0xffd2cec6),
  100: Color(0xffe8e6e3),
  50: Color(0xfff4f3f1),
});

class Grayscale {
  static const Color shade900 = Color(0xff1c1a17);
  static const Color shade800 = Color(0xff39352d);
  static const Color shade700 = Color(0xff554f44);
  static const Color shade600 = Color(0xff726a5a);
  static const Color shade500 = Color(0xff8e8471);
  static const Color shade400 = Color(0xffa59d8d);
  static const Color shade300 = Color(0xffbbb5aa);
  static const Color shade200 = Color(0xffd2cec6);
  static const Color shade100 = Color(0xffe8e6e3);
  static const Color shade50 = Color(0xfff4f3f1);

  static const int shade900value = 0xff1c1a17;
  static const int shade800value = 0xff39352d;
  static const int shade700value = 0xff554f44;
  static const int shade600value = 0xff726a5a;
  static const int shade500value = 0xff8e8471;
  static const int shade400value = 0xffa59d8d;
  static const int shade300value = 0xffbbb5aa;
  static const int shade200value = 0xffd2cec6;
  static const int shade100value = 0xffe8e6e3;
  static const int shade50value = 0xfff4f3f1;
}

const Color Dark_ = Color(0xff212121);

// ColorScheme colorScheme = ColorScheme.
//   primary: primary,
//   secondary: secondary,
//   tertiary: tertiary,
//
//   background: canvasColor,
//   // surface: Color(0xfffdf9f8),
//   // primaryContainer: Color(0xfffff7f7),
//   // secondaryContainer: Color(0xfff7f7ff),
//   // tertiaryContainer: Color(0xfffffdf7),
//   // onBackground: Color(0xfffff7f6),
//   // onSurface: Color(0xfffff7f6),
//   // onPrimary: Color(0xfff6c3be),
//   // onSecondary: Color(0xffbec0f6),
//   // onTertiary: Color(0xfff6eabe), //Brightness
//   brightness: Brightness.light,
//   //Error
//   error: Color(0xffe91e63),
//   onError: Color(0xff000000),
// );

ColorScheme colorScheme = ColorScheme.fromSeed(
    seedColor: primary,
    secondary: secondary,
    tertiary: tertiary,
    background: canvasColor);

//blu Color(0xff4D8DDF)
const Color flutterLogoTop = Color(0xff4D8DDF);
const Color flutterLogoBot = secondary;

// final ThemeData theme = FlexThemeData.light(
//     colors: const FlexSchemeColor(primary: primary, secondary: secondary),
//     textTheme: fonts);

final ThemeData theme = ThemeData(
  useMaterial3: true,
  colorScheme: colorScheme,
  brightness: Brightness.light,
  textTheme: fonts,
);

ThemeData getTheme() {
  if (Device.width > watchSize) {
    return theme;
  } else {
    return theme.copyWith(textTheme: watchFonts);
  }
}

Color footerColor = Colors.grey.shade900;

List<Color> _expGradStops = [
  // tertiary.shade50.lighten(),
  // tertiary.shade50.lighten(5),
  // tertiary.shade100,
  // tertiary.shade200,
  // tertiary.shade300,
  // tertiary.shade400,
  // tertiary.shade500,
  // tertiary.shade600,
];
BoxDecoration expGradient(int ix) {
  if (ix + 1 >= _expGradStops.length) {
    return const BoxDecoration();
  }
  return BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [_expGradStops[ix], _expGradStops[ix + 1]]));
}

BoxDecoration imageOnGradient(String image) {
  return BoxDecoration(
    image: DecorationImage(
        image: AssetImage(image),
        fit: BoxFit.fitHeight,
        alignment: Alignment.center),
  );
}
