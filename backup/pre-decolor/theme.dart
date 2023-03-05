// import 'dart:html' as html;

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

ColorScheme colorScheme = const ColorScheme(
    primary: Color(0xff918D43),
    secondary: Color(0xff29362C),
    tertiary: Color(0xff8C4B0E),
    primaryContainer: Color(0xff2E1F10),
    secondaryContainer: Color(0xffA16D20),
    tertiaryContainer: Color(0xff8C4B0E),
    background: Color(0xffffffff),
    onBackground: Colors.black,
    onPrimary: Colors.black,
    onSecondary: Colors.white,
    onTertiary: Colors.white,
    error: Colors.pink,
    onError: Colors.white,
    brightness: Brightness.light,
    surface: Colors.orangeAccent,
    onSurface: Colors.black);

final ThemeData theme = ThemeData(
  textTheme: fonts,
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
  brightness: Brightness.light,
// canvasColor,
// cardColor,
  colorScheme: colorScheme,
// colorSchemeSeed,
// dialogBackgroundColor,
// disabledColor,
// dividerColor,
// focusColor,
// highlightColor,
// hintColor,
// hoverColor,
// indicatorColor,
// primaryColor,
// primaryColorDark,
// primaryColorLight,
// // MaterialColor? primarySwatch,
// scaffoldBackgroundColor,
// secondaryHeaderColor,
// shadowColor,
// splashColor,
// unselectedWidgetColor,
  fontFamily: fonts.headlineLarge?.fontFamily!,
// List<String>? fontFamilyFallback,
// String? package,
// IconThemeData? iconTheme,
// IconThemeData? primaryIconTheme,
// TextTheme? primaryTextTheme,
// TextTheme? textTheme,
// Typography? typography,
// AppBarTheme? appBarTheme,
// BadgeThemeData? badgeTheme,
// MaterialBannerThemeData? bannerTheme,
// BottomAppBarTheme? bottomAppBarTheme,
// BottomNavigationBarThemeData? bottomNavigationBarTheme,
// BottomSheetThemeData? bottomSheetTheme,
// ButtonBarThemeData? buttonBarTheme,
// ButtonThemeData? buttonTheme,
// CardTheme? cardTheme,
// CheckboxThemeData? checkboxTheme,
// ChipThemeData? chipTheme,
// DataTableThemeData? dataTableTheme,
// DialogTheme? dialogTheme,
// DividerThemeData? dividerTheme,
// DrawerThemeData? drawerTheme,
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
// OutlinedButtonThemeData? outlinedButtonTheme,
// PopupMenuThemeData? popupMenuTheme,
// ProgressIndicatorThemeData? progressIndicatorTheme,
// RadioThemeData? radioTheme,
// SegmentedButtonThemeData? segmentedButtonTheme,
// SliderThemeData? sliderTheme,
// SnackBarThemeData? snackBarTheme,
// SwitchThemeData? switchTheme,
// TabBarTheme? tabBarTheme,
// TextButtonThemeData? textButtonTheme,
// TextSelectionThemeData? textSelectionTheme,
// TimePickerThemeData? timePickerTheme,
// ToggleButtonsThemeData? toggleButtonsTheme,
// TooltipThemeData? tooltipTheme
);

final Color footerColor = colorScheme.secondary!;

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

Color gradientStop(GradientStop stop) {
  return Colors.transparent;
}

BoxDecoration gradient(GradientStop stop) {
  return const BoxDecoration();
}

BoxDecoration imageOnGradient(String image, GradientStop stop) {
  return BoxDecoration(
    image: DecorationImage(
        image: AssetImage(image),
        fit: BoxFit.fitHeight,
        alignment: Alignment.center),
  );
}
