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
import 'theme_material_states.dart';

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

const double trioHorizWidth = 20 * k;
const double processWidth = 70 * k;
const double trioBarWidth = processWidth; //60 * k;
// processWidth; //trioHorizWidth * 3 + trioHorizSpacing * 2;

// const MaterialColor primary = Colors.orange;

/*
const Color Primary_ = Color(0xfff47c00);
const Color Light_ = Color(0xfffffefe);
const Color Tert_ = Color(0xff327523);
const Color Dark_ = Color(0xff1a1a1a);
const Color Sec_ = Color(0xff565656);
 */

const Color MANIFEST_THEME_COLOR = Primary_;
const Color MANIFEST_BACKGROUND_COLOR = Color(0xff252525);

// const MaterialColor secondary = MaterialColor(0xff25581a, <int, Color>{
//   900: Color(0xff11270c),
//   800: Color(0xff214e18),
//   700: Color(0xff327623),
//   600: Color(0xff439d2f),
//   500: Color(0xff53c43b),
//   400: Color(0xff76d062),
//   300: Color(0xff98dc89),
//   200: Color(0xffbae7b1),
//   100: Color(0xffddf3d8),
//   50: Color(0xffeef9eb),
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
  primary: primarySwatch,
  onPrimary: Colors.black,
  primaryContainer: Grayscale.shade900,
  onPrimaryContainer: Colors.white,
  secondary: secSwatch,
  onSecondary: Colors.white,
  secondaryContainer: Sec2Light.v5,
  onSecondaryContainer: Colors.white,
  tertiary: tertSwatch,
  onTertiary: Colors.black,
  tertiaryContainer: Tert1Light.v5,
  onTertiaryContainer: Colors.black,
  error: Colors.yellow,
  onError: Colors.black,
  errorContainer: Colors.yellowAccent,
  onErrorContainer: Colors.black,
  background: PrimDark.v9, //Grayscale.shade900,
  onBackground: Colors.white,
  // surface: SecLight.v1,
  surface: SurfaceColor(),

  onSurface: Colors.white,
);
void startupPrint() {
  // log(theme.scaffoldBackgroundColor.toString());
}

const Color flutterLogoTop = Primary_; //Primary.Shade700
const Color flutterLogoBot = Sec_; //Color(0xff214e18);

// final ThemeData theme = FlexThemeData.light(colors: scheme, textTheme: fonts);
// ColorScheme colorScheme = theme.colorScheme;
final ThemeData theme = ThemeData(
  textTheme: fonts,
  primarySwatch: primarySwatch,

  // applyElevationOverlayColor: true,
  // NoDefaultCupertinoThemeData? cupertinoOverrideTheme,
  // Iterable<ThemeExtension>? extensions,
  // inputDecorationTheme: InputDecorationTheme(
  //     labelStyle: fonts.labelLarge, helperStyle: fonts.displaySmall),
  // MaterialTapTargetSize? materialTapTargetSize,
  // PageTransitionsTheme? pageTransitionsTheme,
  // TargetPlatform? platform,
  // ScrollbarThemeData? scrollbarTheme,
  // InteractiveInkFeatureFactory? splashFactory,
  useMaterial3: true,
  // VisualDensity? visualDensity,
  brightness: Brightness.dark,
  canvasColor: colorScheme.background,
  colorScheme: colorScheme,
// colorSchemeSeed,
  dialogBackgroundColor: colorScheme.background,
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

  appBarTheme: const AppBarTheme(
    // surfaceTintColor: PrimDark.v10,
    // backgroundColor: PrimDark.v6,
    backgroundColor: Colors.transparent,
    scrolledUnderElevation: 0,
    elevation: 0,
    centerTitle: false,
    // foregroundColor: Colors.blue,
    // color: Colors.pink,
    // foregroundColor: Tert3Dark.v0,
    // surfaceTintColor: Colors.transparent,

    // toolbarTextStyle: fonts.labelLarge,
  ),
// BadgeThemeData? badgeTheme,
// MaterialBannerThemeData? bannerTheme,
// BottomAppBarTheme? bottomAppBarTheme,
// BottomNavigationBarThemeData? bottomNavigationBarTheme,
// BottomSheetThemeData? bottomSheetTheme,
// ButtonBarThemeData? buttonBarTheme,
//   buttonTheme: const ButtonThemeData(buttonColor: Grayscale.shade700),
  cardColor: Grayscale.shade800,
  cardTheme: const CardTheme(
      color: Grayscale.shade800,
      // color: GrayLight.v4.withOpacity(.75),
      // surfaceTintColor: GrayLight.v2,
      // shadowColor: Colors.black,
      // color: Sec1Light.v2,
      // elevation: 2,
      shape: RoundedRectangleBorder(
          // side: BorderSide(
          //     color: Color(0xff262626), width: k / 6, strokeAlign: -1),
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
      // surfaceTintColor: Colors.transparent,
      shadowColor: Colors.black,
      width: k * 20),
// DropdownMenuThemeData? dropdownMenuTheme,
// ExpansionTileThemeData? expansionTileTheme,
// FilledButtonThemeData? filledButtonTheme,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    iconSize: k * 2,
    sizeConstraints: const BoxConstraints.tightFor(width: k * 5, height: k * 5),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(k * 3)),
    backgroundColor: PrimarySurfaceColor(),
  ),
// IconButtonThemeData? iconButtonTheme,
// ListTileThemeData? listTileTheme,
// MenuBarThemeData? menuBarTheme,
// MenuButtonThemeData? menuButtonTheme,
// MenuThemeData? menuTheme,
// NavigationBarThemeData? navigationBarTheme,
// NavigationDrawerThemeData? navigationDrawerTheme,
  navigationRailTheme:
      const NavigationRailThemeData(indicatorColor: PrimarySurfaceColor()),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          backgroundColor: const SurfaceColor(),
          minimumSize: FixedMaterialState<Size>(const Size(k * 10, k * 4)),
          foregroundColor: const WhiteButtonColor())),

  outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
    // backgroundColor: SurfaceColor(),
    minimumSize: FixedMaterialState<Size>(const Size(k * 10, k * 4)),
  )),

  textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
          // backgroundColor: SurfaceColor(),
          minimumSize: FixedMaterialState<Size>(const Size(k * 10, k * 4)),
          visualDensity: VisualDensity.compact,
          foregroundColor: const WhiteButtonColor())),

// PopupMenuThemeData? popupMenuTheme,
// ProgressIndicatorThemeData? progressIndicatorTheme,
// RadioThemeData? radioTheme,
// SegmentedButtonThemeData? segmentedButtonTheme,
// SliderThemeData? sliderTheme,
// SnackBarThemeData? snackBarTheme,
// SwitchThemeData? switchTheme,
// TabBarTheme? tabBarTheme,
// TextSelectionThemeData? textSelectionTheme,
// TimePickerThemeData? timePickerTheme,
// ToggleButtonsThemeData? toggleButtonsTheme,
// TooltipThemeData? tooltipTheme
);
//
final ThemeData lightTheme = theme.copyWith(
  // textTheme: darkFonts,
  brightness: Brightness.light,
  // colorScheme: darkScheme,
);
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
