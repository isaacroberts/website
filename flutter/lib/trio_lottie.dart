import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:developer';
import 'dart:math' as math;

import 'theme.dart';
import 'common_elements.dart';

import 'device.dart';

import 'package:lottie/lottie.dart';

abstract class TrioLottieHaver<Type extends StatefulWidget> extends State<Type>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  bool _hovered = false;

  bool get hovered => _hovered;
  AnimationController get controller => _controller;

  set hovered(bool s) {
    if (_hovered != s) {
      _hovered = s;
      if (_hovered) {
        if (!_controller.isAnimating) {
          _controller.reset();
          _controller.forward();
        }
      } else {
        if (_controller.isAnimating) {
          if (_controller.value < .5) {
            _controller.animateBack(0);
          }
        } else {
          _controller.reset();
        }
      }
    }
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );
    // _controller.value = 1;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void startLottie() {
    if (!_controller.isAnimating) {
      _controller.reset();
      _controller.forward();
    }
  }

  void reverseLottie() {
    _controller.animateBack(0);
  }

  Widget inkwellWrapper(Widget child) {
    return InkWell(
      onTap: () {},
      onHover: (b) => hovered = b,
      child: child,
    );
  }

  Widget buildLottie(String asset) {
    return Lottie.asset(
      'lottie/$asset.json',
      controller: _controller,
      width: 100,
      height: 100,
    );
  }
}

class TrioLottie extends StatefulWidget {
  final String asset;
  const TrioLottie(this.asset, {Key? key}) : super(key: key);

  @override
  State<TrioLottie> createState() => _TrioLottieState();
}

class _TrioLottieState extends State<TrioLottie> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final bool hovered;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );
    // _controller.value = 1;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void startLottie() {
    if (!_controller.isAnimating) {
      _controller.reset();
      _controller.forward();
    }
  }

  void reverseLottie() {
    // _controller.animateBack(0);
  }

  Widget platformHover({required Widget child}) {
    if (Device.isDesktop) {
      return MouseRegion(
          onEnter: (e) => startLottie(),
          onExit: (e) => reverseLottie(),
          child: child);
    } else {
      return GestureDetector(
        onTap: startLottie,
        child: child,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return platformHover(
        child: Lottie.asset(
      'lottie/${widget.asset}.json',
      controller: _controller,
      width: 100,
      height: 100,
    ));
  }
}
