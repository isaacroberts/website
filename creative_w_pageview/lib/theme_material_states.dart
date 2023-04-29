import 'package:flutter/material.dart';
import 'package:isaac_roberts_consulting/full_color.dart';
import 'theme.dart';

class FixedMaterialState<Type> extends MaterialStateProperty<Type> {
  final Type value;
  FixedMaterialState(this.value);

  @override
  Type resolve(Set<MaterialState> states) {
    return value;
  }
}

class WhiteButtonColor extends MaterialStateColor {
  const WhiteButtonColor() : super(_defaultColor);

  static const int _defaultColor = 0xc0ffffff;
  static const int _hoveredColor = 0xe0ffffff;
  static const int _pressedColor = 0xffffffff;

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

class PrimarySurfaceColor extends MaterialStateColor {
  const PrimarySurfaceColor() : super(0xff307522);

  static const Color _defaultColor = PrimLight.v0;
  static const Color _hoveredColor = PrimLight.v2;
  static const Color _pressedColor = PrimDark.v2;

  @override
  Color resolve(Set<MaterialState> states) {
    // return TertLight.v0;
    if (states.contains(MaterialState.pressed)) {
      return _pressedColor;
    } else if (states.contains(MaterialState.hovered)) {
      return _hoveredColor;
    }
    return _defaultColor;
  }
}

class SurfaceColor extends MaterialStateColor {
  const SurfaceColor() : super(0xffda8f43);

  static const Color _defaultColor = Sec1Light.v2;
  static const Color _hoveredColor = SecLight.v4;
  static const Color _pressedColor = SecLight.v0;

  @override
  Color resolve(Set<MaterialState> states) {
    // return TertLight.v0;
    if (states.contains(MaterialState.pressed)) {
      return _pressedColor;
    } else if (states.contains(MaterialState.hovered)) {
      return _hoveredColor;
    }
    return _defaultColor;
  }
}

class ChangingCardColor extends MaterialStateColor {
  const ChangingCardColor() : super(0xfff4993d);

  static const Color _defaultColor = Sec1Light.v0;
  static const Color _hoveredColor = GrayDark.v8;
  // static const Color _pressedColor = SecLight.v8;

  @override
  Color resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.hovered)) {
      return _hoveredColor;
    }
    return _defaultColor;
  }
}

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
