import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:developer';
import 'package:flutter_color_models/flutter_color_models.dart';
import 'package:website/text_theme.dart';

const double PHI = 1.61803398;
const double IPHI = .61803398;

const double borderRadius1 = 20;
const double borderRadius2 = 10;

// const FlexScheme flexScheme = FlexScheme.gold;
// final FlexColorScheme colorScheme = FlexColorScheme.light(scheme: flexScheme);

Color c(int n) {
  return Color(n + 0xff000000);
}
// Thai Sunset
// const FlexSchemeColor colors = FlexSchemeColor(
//   primary: Color(0xffEE632B),
//   primaryContainer: Color(0xffF2C9A2),
//   secondary: Color(0xff434E14),
//   secondaryContainer: Color(0xffe3fcaa),
//   tertiary: Color(0xffFCE897),
//   tertiaryContainer: Color(0xffFFFEE1),
//   appBarColor: Color(0xffB4CED4),
//   error: Color(0xffb00020),
// );

// Fall BG Mountains Pic
// FlexSchemeColor colors = const FlexSchemeColor(
//   primary: Color(0xffc56a3a), //#c56a3a c56a3a
//   primaryContainer: Color(0xff824124),
//   secondary: Color(0xff5a5e6f), //#5a5e6f 5a5e6f
//   secondaryContainer: Color(0xffd3d8e6), //#d3d8e6 d3d8e6
//   tertiary: Color(0xff824124), //#824124 824124
//   tertiaryContainer: Color(0xffe8ccc1),
//   appBarColor: Color(0xffB4CED4),
//   error: Color(0xffb00020),
// );

//Fall overhead
//918D43,29362C,8C4B0E,2E1F10,A16D20
// FlexSchemeColor colors = const FlexSchemeColor(
//   primary: Color(0xff8C4B0E), //#c56a3a c56a3a
//   primaryContainer: Color(0xffA16D20),
//   secondary: Color(0xff29362C), //#5a5e6f 5a5e6f
//   secondaryContainer: Color(0xff918D43), //#d3d8e6 d3d8e6
//   tertiary: Color(0xff2E1F10), //#824124 824124
//   tertiaryContainer: Color(0xffe8ccc1),
//   appBarColor: Color(0xffB4CED4),
//   error: Color(0xffb00020),
// );
//
// FlexColorScheme colorScheme = FlexColorScheme.light(colors: colors);
//
// String _h(Color? c) {
//   return c?.hex ?? '  null';
// }
//
// void printColors() {
//   log('\t\t\t Colors\t\tContainers:');
//   log('Primary:\t ${_h(colorScheme.primary)}\t${_h(colorScheme.primaryContainer)}');
//   log('Secondary: ${_h(colorScheme.secondary)}\t${_h(colorScheme.secondaryContainer)}');
//   log('Tertiary:\t ${_h(colorScheme.tertiary)}\t${_h(colorScheme.tertiaryContainer)}');
//   log('BG:\t\t ${_h(theme.scaffoldBackgroundColor)}');
// }

// TextTheme fonts = GoogleFonts.latoTextTheme();
// TextTheme fonts = TextTheme();

class colorScheme {
  static const Color primary = Color(0xff918D43);
  static const Color secondary = Color(0xff29362C);
  static const Color tertiary = Color(0xff8C4B0E);
  static const Color primaryContainer = Color(0xff2E1F10);
  static const Color secondaryContainer = Color(0xffA16D20);
  static const Color tertiaryContainer = Color(0xff8C4B0E);

  static const Color onPrimary = Color(0xff918D43);
  static const Color onSecondary = Color(0xff29362C);
  static const Color onTertiary = Color(0xff8C4B0E);
}

// MyColors colorScheme = MyColors();

final ThemeData theme =
    ThemeData(backgroundColor: Colors.white, textTheme: fonts);

// // TextTheme get fonts => GoogleFonts.openSansTextTheme();
final String? fontFamily = GoogleFonts.lato().fontFamily;
//
// final FlexScheme colorScheme = flexScheme();
// final ThemeData theme = lightTheme();

//Headline3: Underline
//Headline5: Caps & Colored

// final TextTheme fonts_2 = theme.textTheme;

// ThemeData lightTheme() {
//   return FlexThemeData.light(
//       // scheme: flexScheme,
//       colors: colors,
//       surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
//       blendLevel: 9,
//       subThemesData: const FlexSubThemesData(
//         blendOnLevel: 10,
//         blendOnColors: false,
//       ),
//       visualDensity: FlexColorScheme.comfortablePlatformDensity,
//       // fontFamily: fontFamily,
//       textTheme: fonts);
// }

final Color footerColor = colorScheme.secondary!;

List<Color> _gradientStops = buildStops();

const bool trans = true;
const bool fuckitWhite = false;
const bool useLAB = false;

Color mix(Color? c1, Color? c2, double fraction) {
  if (useLAB) {
    LabColor lc1 = LabColor.fromColor(c1 ?? Colors.lime);
    LabColor lc2 = LabColor.fromColor(c2 ?? Colors.lime);

    return lc1.interpolate(lc2, fraction).toColor();
  } else {
    c1 ??= Colors.red;
    c2 ??= Colors.red;
    HSVColor hc1 = HSVColor.fromColor(c1);
    HSVColor hc2 = HSVColor.fromColor(c2);
    if (hc1.saturation == 0 || hc1.value == 0) {
      hc1 = hc1.withHue(hc2.hue);
    } else if (hc2.saturation == 0 || hc2.value == 0) {
      hc2 = hc2.withHue(hc1.hue);
    }

    HSVColor? hc = HSVColor.lerp(hc1, hc2, fraction);
    return hc?.toColor() ?? Colors.lime;
  }
}

final List<Color?> intermStops = [
  //Top
  theme.scaffoldBackgroundColor,
  //Process
  theme.scaffoldBackgroundColor,
  //Experience
  // colorScheme.secondaryContainer,
  // //Download
  // colorScheme.secondaryContainer,

  //End

  Color(0xff000071)
];

enum GradientStop {
  Header,
  Trio,
  Process,
  Exp0,
  Exp1,
  Exp2,
  Download,
  BottomSpace
}

Color mixn(int ix1, int ix2, double amt) {
  return mix(intermStops[ix1], intermStops[ix2], amt);
}

Color coln(int ix1) {
  return intermStops[ix1] ?? Colors.white;
}

List<Color> buildStops() {
  /*
  Top
  Process
  Experience 1
  Experience 2
  Experience 3
  Download
  Bottom
   */
  int colAmt = GradientStop.values.length + 1;

  List<Color> _gradientStops = List<Color>.filled(
      colAmt, trans ? Colors.transparent : theme.scaffoldBackgroundColor);

  if (!fuckitWhite && !trans) {
    for (int n = 0; n < 2; ++n) {
      _gradientStops[n] = mixn(0, 1, ((n) / 2));
    }
    for (int n = 1; n < 2; ++n) {
      _gradientStops[n + 1] = coln(n);
    }
    _gradientStops[3] = coln(1);
    int nMix = 1;
    for (int n = 0; n < nMix; ++n) {
      _gradientStops[n + 3] = (mixn(2, 3, ((n) / nMix)));
    }
    for (int n = nMix + 3; n < colAmt; ++n) {
      _gradientStops[n] = coln(3);
    }
  }
  // log("Grad: ${_gradientStops.length}");
  return _gradientStops;
}

List<Color> gradColors(Color c1, Color c2) {
  if (useLAB) {
    return c1
        .toLabColor()
        .lerpTo(c2.toLabColor(), 3)
        .map((LabColor l) => l.toColor())
        .toList();
  } else {
    return [c1, c2];
  }
}

Color gradientStop(GradientStop stop) {
  return _gradientStops[stop.index];
}

BoxDecoration gradient(GradientStop stop) {
  int ix = stop.index;
  return BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          // colors: [_gradientStops[ix], _gradientStops[ix + 1]],
          colors: gradColors(_gradientStops[ix], _gradientStops[ix + 1])));
}

BoxDecoration imageOnGradient(String image, GradientStop stop) {
  int ix = stop.index;
  return BoxDecoration(
      image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.fitHeight,
          alignment: Alignment.center),
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          // colors: [_gradientStops[ix], _gradientStops[ix + 1]],
          colors: gradColors(_gradientStops[ix], _gradientStops[ix + 1])));
}
