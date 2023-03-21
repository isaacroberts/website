import 'dart:developer';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'text_theme.dart';
import 'device.dart';
import 'theme.dart';
import 'common_elements.dart';
import 'feature_shower.dart';
import 'package:rive/rive.dart';

class AnimationShower extends StatefulWidget {
  final bool textLeft;
  const AnimationShower(this.textLeft, {Key? key}) : super(key: key);

  @override
  State<AnimationShower> createState() => _AnimationShowerState();
}

class _AnimationShowerState extends State<AnimationShower> with FeatureShower {
  late SMITrigger? _bump;

  _AnimationShowerState();

  @override
  String title() => 'Animations';
  @override
  String subtitle() => 'Impress your users with animations.';
  @override
  String body() =>
      """Add loading animations, action animations, even animations that respond to clicks, events, and mouse position. 
          """;
  @override
  String bgImage() => 'images/animation.jpg';

  @override
  bool shouldExpandToDisplay() => true;

  void clickRive() => _bump?.fire();

  void riveLoaded(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(artboard, 'tap');
    artboard.addController(controller!);
    _bump = controller.findInput<bool>('Trigger 1') as SMITrigger;
  }

  Widget getRive() {
    if (kIsWeb) {
      return RiveAnimation.network(
        'assets/lottie/rivebot_transform.riv',
        key: const Key('rive'),
        placeHolder: const CircularProgressIndicator(),
        onInit: riveLoaded,
        stateMachines: const ['tap'],
        animations: const ['idleCar'],
      );
    } else {
      return RiveAnimation.asset(
        'lottie/rivebot_transform.riv',
        key: const Key('rive'),
        placeHolder: const CircularProgressIndicator(),
        onInit: riveLoaded,
        stateMachines: const ['tap'],
        animations: const ['idleCar'],
      );
    }
  }

  @override
  Widget displayContent(BuildContext context) {
    return InkWell(
        onTap: clickRive,
        borderRadius: BorderRadius.circular(15),
        child: Center(child: AbsorbPointer(child: getRive())));
  }

  @override
  Widget build(BuildContext context) {
    return doBuild(context, widget.textLeft);
  }
}
