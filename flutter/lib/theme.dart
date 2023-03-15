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

const double trioBarWidth = 16 * k * 3 + k * 4;
const double processWidth = 950;

const MaterialColor primary = Colors.orange;

// class Primary {
//   static const Color shade900 = Color(0xFFE65100);
//   static const Color shade800 = Color(0xFFEF6C00);
//   static const Color shade700 = Color(0xFFF57C00);
//   static const Color shade600 = Color(0xFFFB8C00);
//   static const Color shade500 = Color(0xFFFF9800);
//   static const Color shade400 = Color(0xFFFFA726);
//   static const Color shade300 = Color(0xFFFFB74D);
//   static const Color shade200 = Color(0xFFFFCC80);
//   static const Color shade100 = Color(0xFFFFE0B2);
//   static const Color shade50 = Color(0xFFFFF3E0);
//
//   static const int shade900value = 0xFFE65100;
//   static const int shade800value = 0xFFEF6C00;
//   static const int shade700value = 0xFFF57C00;
//   static const int shade600value = 0xFFFB8C00;
//   static const int shade500value = 0xFFFF9800;
//   static const int shade400value = 0xFFFFA726;
//   static const int shade300value = 0xFFFFB74D;
//   static const int shade200value = 0xFFFFCC80;
//   static const int shade100value = 0xFFFFE0B2;
//   static const int shade50value = 0xFFFFF3E0;
// }

const Color MANIFEST_THEME_COLOR = Primary_;
const Color MANIFEST_BACKGROUND_COLOR = Color(0xff252525);

const MaterialColor secondary = MaterialColor(0xff25581a, <int, Color>{
  900: Color(0xff11270c),
  800: Color(0xff214e18),
  700: Color(0xff327623),
  600: Color(0xff439d2f),
  500: Color(0xff53c43b),
  400: Color(0xff76d062),
  300: Color(0xff98dc89),
  200: Color(0xffbae7b1),
  100: Color(0xffddf3d8),
  50: Color(0xffeef9eb),
});
// MaterialColor(0xff505050, <int, Color>{
//   900: Color(0xff1a1a1a),
//   800: Color(0xff333333),
//   700: Color(0xff4d4d4d),
//   600: Color(0xff666666),
//   500: Color(0xff808080),
//   400: Color(0xff999999),
//   300: Color(0xffb3b3b3),
//   200: Color(0xffcccccc),
//   100: Color(0xffe6e6e6),
//   50: Color(0xfff2f2f2),
// });

// const MaterialColor undrawColor = Colors.blueAccent;
// const MaterialColor greyscale = secondary;
class Grayscale {
  static const int shade950value = (0xff080808);
  static const int shade900value = (0xff1a1a1a);
  static const int shade800value = (0xff333333);
  static const int shade700value = (0xff4d4d4d);
  static const int shade600value = (0xff666666);
  static const int shade500value = (0xff808080);
  static const int shade400value = (0xff999999);
  static const int shade300value = (0xffb3b3b3);
  static const int shade200value = (0xffcccccc);
  static const int shade100value = (0xffe6e6e6);
  static const int shade50value = (0xfff2f2f2);

  static const Color shade900 = Color(0xff1a1a1a);
  static const Color shade800 = Color(0xff333333);
  static const Color shade700 = Color(0xff4d4d4d);
  static const Color shade600 = Color(0xff666666);
  static const Color shade500 = Color(0xff808080);
  static const Color shade400 = Color(0xff999999);
  static const Color shade300 = Color(0xffb3b3b3);
  static const Color shade200 = Color(0xffcccccc);
  static const Color shade100 = Color(0xffe6e6e6);
  static const Color shade50 = Color(0xfff2f2f2);
}

// Color c = CreateExtensions.fromGray(900);
// ColorScheme colorScheme = ColorScheme.fromSwatch(primarySwatch: primary);
const ColorScheme colorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Colors.orange,
  onPrimary: Colors.black,
  primaryContainer: Grayscale.shade900,
  onPrimaryContainer: Colors.white,
  secondary: Colors.black,
  onSecondary: Colors.white,
  secondaryContainer: Colors.black,
  onSecondaryContainer: Colors.white,
  tertiary: Colors.white,
  onTertiary: Colors.black,
  tertiaryContainer: Colors.white,
  onTertiaryContainer: Colors.black,
  error: Colors.yellow,
  onError: Colors.black,
  errorContainer: Colors.yellowAccent,
  onErrorContainer: Colors.black,
  background: Grayscale.shade900,
  onBackground: Colors.white,
  surface: Grayscale.shade800,
  onSurface: Colors.white,
);
void startupPrint() {
  // log(theme.scaffoldBackgroundColor.toString());
}

const Color flutterLogoTop = Primary_; //Primary.Shade700
const Color flutterLogoBot = Tert_; //Color(0xff214e18);

class TextButtonColor extends MaterialStateColor {
  const TextButtonColor() : super(_defaultColor);

  static const int _defaultColor = Grayscale.shade800value;
  static const int _hoveredColor = Grayscale.shade700value;
  static const int _pressedColor = 0xff000000;

  @override
  Color resolve(Set<MaterialState> states) {
    // if (states.contains(MaterialState.pressed)) {
    //   return const Color(_pressedColor);
    // } else if (states.contains(MaterialState.hovered)) {
    //   return const Color(_hoveredColor);
    // }
    return const Color(_defaultColor);
  }
}

class OutlineButtonColor extends MaterialStateColor {
  const OutlineButtonColor() : super(_defaultColor);

  static const int _defaultColor = 0x00ffffff;
  static const int _hoveredColor = 0x02ffffff;
  static const int _pressedColor = 0x03ffffff;

  @override
  Color resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.pressed)) {
      return const Color(_pressedColor);
    } else if (states.contains(MaterialState.hovered)) {
      return const Color(_hoveredColor);
    }
    return const Color(_defaultColor);
  }
}

// final ThemeData theme = FlexThemeData.light(colors: scheme, textTheme: fonts);
// ColorScheme colorScheme = theme.colorScheme;
final ThemeData theme = ThemeData(
  textTheme: fonts,
  primarySwatch: primary,
  // applyElevationOverlayColor: true,
  // NoDefaultCupertinoThemeData? cupertinoOverrideTheme,
  // Iterable<ThemeExtension>? extensions,
  // InputDecorationTheme? inputDecorationTheme,
  // MaterialTapTargetSize? materialTapTargetSize,
  // PageTransitionsTheme? pageTransitionsTheme,
  // TargetPlatform? platform,
  // ScrollbarThemeData? scrollbarTheme,
  // InteractiveInkFeatureFactory? splashFactory,
  useMaterial3: true,
  // VisualDensity? visualDensity,
  brightness: Brightness.dark,
  canvasColor: Grayscale.shade900,
// cardColor: ,
  colorScheme: colorScheme,
// colorSchemeSeed,
// dialogBackgroundColor,
// disabledColor,
// dividerColor,
  dividerColor: Colors.transparent,
// focusColor,
// highlightColor,
// hintColor,
// hoverColor,
// indicatorColor,
// primaryColor,
// primaryColorDark,
// primaryColorLight,
// scaffoldBackgroundColor,
// secondaryHeaderColor,
// shadowColor,
// splashColor,
// unselectedWidgetColor,
//   fontFamily: fonts.headlineLarge?.fontFamily!,
// List<String>? fontFamilyFallback,
// String? package,
// IconThemeData? iconTheme,
// IconThemeData? primaryIconTheme,
// TextTheme? primaryTextTheme,
// TextTheme? textTheme,
// Typography? typography,
// appBarTheme: AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: )),
// BadgeThemeData? badgeTheme,
// MaterialBannerThemeData? bannerTheme,
// BottomAppBarTheme? bottomAppBarTheme,
// BottomNavigationBarThemeData? bottomNavigationBarTheme,
// BottomSheetThemeData? bottomSheetTheme,
// ButtonBarThemeData? buttonBarTheme,
//   buttonTheme: const ButtonThemeData(buttonColor: Grayscale.shade700),
  cardTheme: const CardTheme(
      color: Grayscale.shade800,
      surfaceTintColor: Sec1Dark.v7,
      shadowColor: Colors.black,
      // color: Colors.black,
      elevation: 2,
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(15)))),
// CheckboxThemeData? checkboxTheme,
// ChipThemeData? chipTheme,
// DataTableThemeData? dataTableTheme,
// DialogTheme? dialogTheme,
// DividerThemeData? dividerTheme,
  drawerTheme: const DrawerThemeData(
      backgroundColor: Tert1Dark.v9,
      elevation: 5,
      shape: RoundedRectangleBorder(),
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.black,
      width: k * 20),
// DropdownMenuThemeData? dropdownMenuTheme,
// ElevatedButtonThemeData? elevatedButtonTheme,
// ExpansionTileThemeData? expansionTileTheme,
// FilledButtonThemeData? filledButtonTheme,
// FloatingActionButtonThemeData? floatingActionButtonTheme,
// IconButtonThemeData? iconButtonTheme,
// ListTileThemeData? listTileTheme,
// MenuBarThemeData? menuBarTheme,
// MenuButtonThemeData? menuButtonTheme,
// MenuThemeData? menuTheme,
// NavigationBarThemeData? navigationBarTheme,
// NavigationDrawerThemeData? navigationDrawerTheme,
// NavigationRailThemeData? navigationRailTheme,
  outlinedButtonTheme: const OutlinedButtonThemeData(
      style: ButtonStyle(backgroundColor: OutlineButtonColor())),
// PopupMenuThemeData? popupMenuTheme,
// ProgressIndicatorThemeData? progressIndicatorTheme,
// RadioThemeData? radioTheme,
// SegmentedButtonThemeData? segmentedButtonTheme,
// SliderThemeData? sliderTheme,
// SnackBarThemeData? snackBarTheme,
// SwitchThemeData? switchTheme,
// TabBarTheme? tabBarTheme,
//   textButtonTheme: const TextButtonThemeData(
//       style: ButtonStyle(backgroundColor: TextButtonColor())),
// TextSelectionThemeData? textSelectionTheme,
// TimePickerThemeData? timePickerTheme,
// ToggleButtonsThemeData? toggleButtonsTheme,
// TooltipThemeData? tooltipTheme
);
//
// final ThemeData darkTheme = ThemeData(
//     textTheme: fonts,
//     primarySwatch: primary,
//     useMaterial3: true,
//     // VisualDensity? visualDensity,
//     brightness: Brightness.dark,
//     colorScheme: darkScheme,
//     fontFamily: fonts.headlineLarge?.fontFamily!);

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
