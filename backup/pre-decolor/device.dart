import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:universal_io/io.dart';

import 'package:device_preview/device_preview.dart';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'device.dart';

//Convenience Defines

enum ScreenType { desktop, tablet_wide, tablet_tall, phone_wide, phone_tall }

enum _Devices {
  windows,
  linux,
  osx,
  iphone,
  android,
  fuchsia,

  win_web,
  linux_web,
  osx_web,
  iphone_web,
  android_web,
  fuchsia_web,

  err
}

class Device {
  static _Devices _device = _Devices.windows;
  static ScreenType _screen = ScreenType.desktop;
  static double _h = 69;
  static double _w = 69;

  static ScreenType get screen => _screen;
  static String get platformName => _device.name;
  static double get width => _w;
  static double get height => _h;

  //Moved to separate function for ease of return statement
  static _Devices _getDeviceRelease() {
    if (kIsWeb) {
      switch (defaultTargetPlatform) {
        case TargetPlatform.macOS:
          return _Devices.osx_web;
        case TargetPlatform.linux:
          return _Devices.linux_web;
        case TargetPlatform.windows:
          return _Devices.win_web;
        case TargetPlatform.iOS:
          return _Devices.iphone_web;
        case TargetPlatform.android:
          return _Devices.android_web;
        case TargetPlatform.fuchsia:
          return _Devices.fuchsia_web;
      }
    } else {
      if (Platform.isAndroid) return _Devices.android;
      if (Platform.isIOS) return _Devices.iphone;
      if (Platform.isWindows) return _Devices.windows;
      if (Platform.isMacOS) return _Devices.osx;
      if (Platform.isLinux) return _Devices.linux;
      if (Platform.isFuchsia) return _Devices.fuchsia;
    }
    return _Devices.err;
  }

  static void updateDeviceRelease(BuildContext context) {
    _device = _getDeviceRelease();
    _screen = _getScreenType(context);
  }

  static _Devices _getDeviceWithPreview(BuildContext context) {
    if (!DevicePreview.isEnabled(context)) {
      return _getDeviceRelease();
    }
    TargetPlatform pl = DevicePreview.platform(context);
    if (kIsWeb) {
      switch (pl) {
        case TargetPlatform.android:
          return _Devices.android_web;
        case TargetPlatform.fuchsia:
          return _Devices.fuchsia_web;
        case TargetPlatform.iOS:
          return _Devices.iphone_web;
        case TargetPlatform.linux:
          return _Devices.linux_web;
        case TargetPlatform.macOS:
          return _Devices.osx_web;
        case TargetPlatform.windows:
          return _Devices.win_web;
      }
    } else {
      switch (pl) {
        case TargetPlatform.android:
          return _Devices.android;
        case TargetPlatform.fuchsia:
          return _Devices.fuchsia;
        case TargetPlatform.iOS:
          return _Devices.iphone;
        case TargetPlatform.linux:
          return _Devices.linux;
        case TargetPlatform.macOS:
          return _Devices.osx;
        case TargetPlatform.windows:
          return _Devices.windows;
      }
    }
  }

  static void updateDeviceWithPreview(BuildContext context) {
    _device = _getDeviceWithPreview(context);
    _screen = _getScreenType(context);

    if (isDesktop) {
      //Sidebar off/on controls
      _w -= 35;
    }

    log('----');
    printDevice();
  }

  static void printDevice() {
    log("${getDeviceName()} ${isWeb ? "(Web)" : "(App)"} ${isLandscape ? "Landscape" : "Portrait"}");
    log('Screen Size: $_w x $_h lp');
  }

  //Categories
  static bool get isDesktop {
    switch (_device) {
      case _Devices.linux:
      case _Devices.osx:
      case _Devices.windows:
      case _Devices.linux_web:
      case _Devices.osx_web:
      case _Devices.win_web:
        return true;
      default:
        return false;
    }
  }

  static bool get isMobile {
    switch (_device) {
      case _Devices.iphone:
      case _Devices.iphone_web:
      case _Devices.android:
      case _Devices.android_web:
        return true;
      default:
        return false;
    }
  }

  static bool get isWeb {
    switch (_device) {
      case _Devices.linux_web:
      case _Devices.osx_web:
      case _Devices.win_web:
      case _Devices.iphone_web:
      case _Devices.android_web:
      case _Devices.fuchsia_web:
        return true;
      default:
        return false;
    }
  }

  static bool get isApp {
    switch (_device) {
      case _Devices.linux:
      case _Devices.osx:
      case _Devices.windows:
      case _Devices.iphone:
      case _Devices.android:
      case _Devices.fuchsia:
        return true;
      default:
        return false;
    }
  }

  //Subcategories
  static bool get isDesktopApp {
    switch (_device) {
      case _Devices.linux:
      case _Devices.osx:
      case _Devices.windows:
        return true;
      default:
        return false;
    }
  }

  static bool get isMobileApp {
    switch (_device) {
      case _Devices.iphone:
      case _Devices.android:
        return true;
      default:
        return false;
    }
  }

  static bool get isMobileWeb {
    switch (_device) {
      case _Devices.iphone_web:
      case _Devices.android_web:
        return true;
      default:
        return false;
    }
  }

  static bool get isDesktopWeb {
    switch (_device) {
      case _Devices.linux_web:
      case _Devices.osx_web:
      case _Devices.win_web:
        return true;
      default:
        return false;
    }
  }

  //Specifics
  static bool get isWindows =>
      _device == _Devices.windows || _device == _Devices.win_web;

  static bool get isLinux =>
      _device == _Devices.linux || _device == _Devices.linux_web;

  static bool get isMacOS =>
      _device == _Devices.osx || _device == _Devices.osx_web;

  static bool get isAndroid =>
      _device == _Devices.android || _device == _Devices.android_web;

  static bool get isFuchsia =>
      _device == _Devices.fuchsia || _device == _Devices.fuchsia_web;

  static bool get isIOS =>
      _device == _Devices.iphone || _device == _Devices.iphone_web;

  //Detailed getters
  static ScreenType _getScreenType(BuildContext context) {
    _h = MediaQuery.of(context).size.height;
    _w = MediaQuery.of(context).size.width;
    if (isDesktop) return ScreenType.desktop;

    bool land = MediaQuery.of(context).orientation == Orientation.landscape;

    if (land) {
      if (_w > 1000) return ScreenType.tablet_wide;
      return ScreenType.phone_wide;
    } else {
      if (_h >= 1000) return ScreenType.tablet_tall;
      return ScreenType.phone_tall;
    }
  }

  static bool get isTablet {
    return _screen == ScreenType.tablet_wide ||
        _screen == ScreenType.tablet_tall;
  }

  static bool get isPhone {
    return _screen == ScreenType.phone_wide || _screen == ScreenType.phone_tall;
  }

  static bool get isPhonePort {
    return _screen == ScreenType.phone_tall;
  }

  static bool get isPhoneLand {
    return _screen == ScreenType.phone_wide;
  }

  static bool get isTabletPort {
    return _screen == ScreenType.tablet_tall;
  }

  static bool get isTabletLand {
    return _screen == ScreenType.tablet_wide;
  }

  static bool get isPortrait {
    return _screen == ScreenType.phone_tall ||
        _screen == ScreenType.tablet_tall;
  }

  static bool get isLandscape {
    return _screen == ScreenType.phone_wide ||
        _screen == ScreenType.tablet_wide ||
        _screen == ScreenType.desktop;
  }

  static bool get isLandscapeMobile {
    return _screen == ScreenType.phone_wide ||
        _screen == ScreenType.tablet_wide;
  }

  static T select<T>(
      {T? def,
      T? desktop,
      T? mobile,
      T? phone,
      T? tablet,
      T? landscape,
      T? portrait,
      T? phonePort,
      T? phoneLand,
      T? tabletPort,
      T? tabletLand}) {
    T? v;
    if (screen == ScreenType.desktop) {
      v = desktop;
    } else if (screen == ScreenType.tablet_wide) {
      v = tabletLand ?? landscape ?? tablet ?? mobile;
    } else if (screen == ScreenType.tablet_tall) {
      v = tabletPort ?? portrait ?? tablet ?? mobile;
    } else if (screen == ScreenType.phone_wide) {
      v = phoneLand ?? landscape ?? phone ?? mobile;
    } else if (screen == ScreenType.phone_tall) {
      v = phonePort ?? portrait ?? phone ?? mobile;
    }
    if (v != null) return v;
    //Try all possible values to avoid returning null
    //return def!;
    return (def ??
        (desktop ??
            (mobile ??
                (phone ??
                    (tablet ??
                        (phonePort ??
                            (phoneLand ?? (tabletPort ?? tabletLand))))))))!;
  }

  static bool get isPhysicalDesktop {
    return kIsWeb
        ? (defaultTargetPlatform == TargetPlatform.macOS ||
            defaultTargetPlatform == TargetPlatform.windows ||
            defaultTargetPlatform == TargetPlatform.linux)
        : (Platform.isWindows || Platform.isLinux || Platform.isMacOS);
  }

  static String getDeviceName() {
    return getDeviceRemoveWeb().name;
  }

  static _Devices getDeviceRemoveWeb() {
    switch (_device) {
      case _Devices.linux_web:
      case _Devices.linux:
        return _Devices.linux;
      case _Devices.osx_web:
      case _Devices.osx:
        return _Devices.osx;
      case _Devices.win_web:
      case _Devices.windows:
        return _Devices.windows;
      case _Devices.iphone_web:
      case _Devices.iphone:
        return _Devices.iphone;
      case _Devices.android_web:
      case _Devices.android:
        return _Devices.android;
      case _Devices.fuchsia_web:
      case _Devices.fuchsia:
        return _Devices.fuchsia;
      case _Devices.err:
        return _Devices.err;
    }
  }
}

class Screen {
  static double get _ppi => (Platform.isAndroid || Platform.isIOS) ? 150 : 96;
  static bool isLandscape(BuildContext c) =>
      MediaQuery.of(c).orientation == Orientation.landscape;
  //PIXELS
  static Size size(BuildContext c) => MediaQuery.of(c).size;
  static double width(BuildContext c) => size(c).width;
  static double height(BuildContext c) => size(c).height;
  static double diagonal(BuildContext c) {
    Size s = size(c);
    return math.sqrt((s.width * s.width) + (s.height * s.height));
  }

  //INCHES
  static Size inches(BuildContext c) {
    Size pxSize = size(c);
    return Size(pxSize.width / _ppi, pxSize.height / _ppi);
  }

  static double widthInches(BuildContext c) => inches(c).width;
  static double heightInches(BuildContext c) => inches(c).height;
  static double diagonalInches(BuildContext c) => diagonal(c) / _ppi;

  static double get stdWidth {
    if (kIsWeb) {
      return 900;
    }
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) return 900;
    if (Platform.isAndroid || Platform.isIOS) return 450;
    return -100;
  }
}

// Widget wrapRow({
//   required List<Widget> children,
//   Key? key,
//   crossAxisAlignment = CrossAxisAlignment.center,
//   mainAxisAlignment = MainAxisAlignment.center,
//   mainAxisSize = MainAxisSize.min,
// }) {
//   if (Device.isPhonePort()) {
//     return Column(
//         key: key,
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: children);
//     // return children[0];
//   } else {
//     return Row(
//         key: key,
//         crossAxisAlignment: crossAxisAlignment,
//         mainAxisAlignment: mainAxisAlignment,
//         mainAxisSize: mainAxisSize,
//         children: children);
//   }
// }

/* // This version uses the variables directly, the other requires calling the update function

class Device {

  //TODO: This does not cover Fuchsia, which can be on several different sizes of screens

  //Categories
  static bool get isDesktop {
    return kIsWeb ? _isDesktopWeb : (isWindows || isLinux || isMacOS);
  }

  static bool get isMobile {
    return kIsWeb ? _isMobileWeb : (isAndroid || isIOS);
  }

  static bool get isWeb => kIsWeb;

  static bool get isApp => !kIsWeb;

  //Subcategories
  static bool get isDesktopApp {
    return !kIsWeb && _isDesktopApp;
  }

  static bool get isMobileApp {
    return !kIsWeb && _isMobileApp;
  }

  static bool get isMobileWeb {
    return kIsWeb && _isMobileWeb;
  }

  static bool get isDesktopWeb {
    return kIsWeb && _isDesktopWeb;
  }

  //Specifics
  static bool get isWindows => Platform.isWindows;

  static bool get isLinux => Platform.isLinux;

  static bool get isMacOS => Platform.isMacOS;

  static bool get isAndroid => Platform.isAndroid;

  static bool get isFuchsia => Platform.isFuchsia;

  static bool get isIOS => Platform.isIOS;

  //Detailed getters
  static ScreenType getScreenType(BuildContext context) {
    if (isDesktop) return ScreenType.Desktop;

    double w = MediaQuery.of(context).size.width;
    bool land = MediaQuery.of(context).orientation == Orientation.landscape;

    if (land) {
      if (w > 1000) return ScreenType.TabletLand;
      return ScreenType.PhoneLand;
    } else {
      if (w >= 850) return ScreenType.TabletPort;
      return ScreenType.PhonePort;
    }
  }

  static bool isTablet(BuildContext context) {
    ScreenType s = getScreenType(context);
    return s == ScreenType.TabletLand || s == ScreenType.TabletPort;
  }

  static bool isPhone(BuildContext context) {
    ScreenType s = getScreenType(context);
    return s == ScreenType.PhoneLand || s == ScreenType.PhonePort;
  }

  T selectByScreen<T>(BuildContext context,
      {T? def,
      T? desktop,
      T? mobile,
      T? phone,
      T? tablet,
      T? phonePort,
      T? phoneLand,
      T? tabletPort,
      T? tabletLand}) {
    ScreenType screen = getScreenType(context);

    T? v;
    if (screen == ScreenType.Desktop) {
      v = desktop;
    } else if (screen == ScreenType.TabletLand) {
      v = tabletLand ?? tablet ?? mobile;
    } else if (screen == ScreenType.TabletPort) {
      v = tabletPort ?? tablet ?? mobile;
    } else if (screen == ScreenType.PhoneLand) {
      v = phoneLand ?? phone ?? mobile;
    } else if (screen == ScreenType.PhonePort) {
      v = phonePort ?? phone ?? mobile;
    }
    if (v != null) return v;
    //Try all possible values to avoid returning null
    return (def ??
        desktop ??
        mobile ??
        phone ??
        tablet ??
        phonePort ??
        phoneLand ??
        tabletPort ??
        tabletLand)!;
  }

  //Private to avoid code duplication
  static bool get _isMobileWeb {
    return defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.android;
  }

  static bool get _isDesktopWeb {
    return defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.windows ||
        defaultTargetPlatform == TargetPlatform.linux;
  }

  static bool get _isDesktopApp {
    return (isWindows || isLinux || isMacOS);
  }

  static bool get _isMobileApp {
    return (isAndroid || isIOS);
  }
}
 */
