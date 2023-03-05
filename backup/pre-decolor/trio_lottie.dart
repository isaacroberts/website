import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:developer';
import 'dart:math' as math;

import 'theme.dart';
import 'common_elements.dart';

import 'device.dart';

import 'package:lottie/lottie.dart';

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
    }
    return child;
  }

  @override
  Widget build(BuildContext context) {
    /*
    Remove stupid Lordicon watermark

    Was named "02092020"
     */
    return platformHover(
        //https://assets4.lottiefiles.com/private_files/lf30_8zscxore.json
        //   child: Lottie.asset(
        // 'lottie/${widget.asset}.json',
        // controller: _controller,
        // width: 100,
        // height: 100,
        // delegates: LottieDelegates(
        //   values: [
        //     ValueDelegate.color(
        //       // keyPath order: ['layer name', 'group name', 'shape name']
        //       const ['outline 3'],
        //       value: Colors.orange,
        //     ),
        //   ],
        // ))
        child: Lottie.asset(
      'lottie/${widget.asset}.json',
      controller: _controller,
      width: 100,
      height: 100,
      // delegates: LottieDelegates(
      //   values: [
      //     ValueDelegate.color(
      //       // keyPath order: ['layer name', 'group name', 'shape name']
      //       //layers; 'outline ${2-4}', 'Box',
      //       const ['outline 2', '**'],
      //       // const ['Line', '**'],
      //       value: colorScheme.primary,
      //       // value: ColorFilter.mode(
      //       //   // Colors.red,
      //       //   colorScheme.primary ?? Colors.black,
      //       //   BlendMode.src,
      //       // ),
      //     ),
      //   ],
      // )
    ));
  }
}
