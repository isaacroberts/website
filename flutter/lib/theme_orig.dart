// import 'dart:html' as html;

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:developer';
import 'text_theme.dart';

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

/*
//Fall overhead
//918D43,29362C,8C4B0E,2E1F10,A16D20
const MaterialColor primary = MaterialColor(0xffc66e1b, <int, Color>{
  900: Color(0xff2d1906),
  800: Color(0xff5a320c),
  700: Color(0xff874b12),
  600: Color(0xffb36419),
  500: Color(0xffe07c1f),
  400: Color(0xffe6974c),
  300: Color(0xffedb178),
  200: Color(0xfff3cba5),
  100: Color(0xfff9e5d2),
  50: Color(0xfffcf2e9),
});
const MaterialColor secondary = MaterialColor(0xff418f51, <int, Color>{
  900: Color(0xff102314),
  800: Color(0xff204628),
  700: Color(0xff30693c),
  600: Color(0xff408c50),
  500: Color(0xff4fb063),
  400: Color(0xff73bf83),
  300: Color(0xff96cfa2),
  200: Color(0xffb9dfc1),
  100: Color(0xffdcefe0),
  50: Color(0xffedf7ef),
});
const MaterialColor tertiary = MaterialColor(0xff383a48, <int, Color>{
  900: Color(0xff16171d),
  800: Color(0xff2c2e3a),
  700: Color(0xff434556),
  600: Color(0xff595c73),
  500: Color(0xff6f7390),
  400: Color(0xff8c8fa6),
  300: Color(0xffa9abbc),
  200: Color(0xffc5c7d3),
  100: Color(0xffe2e3e9),
  50: Color(0xfff1f1f4),
});
const MaterialColor greyscale = MaterialColor(0xff484848, <int, Color>{
  900: Color(0xff1a1a1a),
  800: Color(0xff333333),
  700: Color(0xff4d4d4d),
  600: Color(0xff666666),
  500: Color(0xff808080),
  400: Color(0xff999999),
  300: Color(0xffb3b3b3),
  200: Color(0xffcccccc),
  100: Color(0xffe6e6e6),
  50: Color(0xfff2f2f2),
});

ColorScheme colorScheme = const ColorScheme(
  primary: primary,
  secondary: secondary,
  tertiary: tertiary,

  background: Color(0xffffffff),
  surface: Color(0xfffdfbf8),
  primaryContainer: Color(0xfffffbf7),
  secondaryContainer: Color(0xfff7fff8),
  tertiaryContainer: Color(0xfff7f7ff),
  onBackground: Color(0xff252525),
  onSurface: Color(0xff111111),
  onPrimary: Color(0xff121110),
  onSecondary: Color(0xff232824),
  onTertiary: Color(0xff3c3b44), //Brightness
  brightness: Brightness.light,
  //Error
  error: Color(0xffe91e63),
  onError: Color(0xff000000),
);

ColorScheme darkScheme = const ColorScheme(
  primary: primary,
  secondary: secondary,
  tertiary: tertiary,
  background: Color(0xff282523),
  surface: Color(0xff44403b),
  primaryContainer: Color(0xff503f30),
  secondaryContainer: Color(0xff305036),
  tertiaryContainer: Color(0xff333050),
  onBackground: Color(0xffffffff),
  onSurface: Color(0xfffffbf6),
  onPrimary: Color(0xffffeddd),
  onSecondary: Color(0xffddffe4),
  onTertiary: Color(0xffe0ddff), //Brightness
  brightness: Brightness.dark,
  //Error
  error: Color(0xffe91e63),
  onError: Color(0xff000000),
);
 */

const MaterialColor primary = MaterialColor(0xff505050, <int, Color>{
  900: Color(0xff1a1a1a),
  800: Color(0xff333333),
  700: Color(0xff4d4d4d),
  600: Color(0xff666666),
  500: Color(0xff808080),
  400: Color(0xff999999),
  300: Color(0xffb3b3b3),
  200: Color(0xffcccccc),
  100: Color(0xffe6e6e6),
  50: Color(0xfff2f2f2),
});
const MaterialColor secondary = MaterialColor(0xff584e44, <int, Color>{
  900: Color(0xff1d1a16),
  800: Color(0xff3a332c),
  700: Color(0xff564d43),
  600: Color(0xff736659),
  500: Color(0xff90806f),
  400: Color(0xffa6998c),
  300: Color(0xffbcb3a9),
  200: Color(0xffd3ccc5),
  100: Color(0xffe9e6e2),
  50: Color(0xfff4f2f1),
});
ColorScheme colorScheme = ColorScheme.fromSwatch(primarySwatch: primary);

void startupPrint() {
  // log(theme.scaffoldBackgroundColor.toString());
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
  // brightness: Brightness.dark,
// canvasColor,
// cardColor: ,
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
//
// final ThemeData darkTheme = ThemeData(
//     textTheme: fonts,
//     primarySwatch: primary,
//     useMaterial3: true,
//     // VisualDensity? visualDensity,
//     brightness: Brightness.dark,
//     colorScheme: darkScheme,
//     fontFamily: fonts.headlineLarge?.fontFamily!);

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
