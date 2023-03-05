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

class HoldappLogoRiveWidget extends StatefulWidget {
  const HoldappLogoRiveWidget({Key? key}) : super(key: key);

  @override
  State<HoldappLogoRiveWidget> createState() => _HoldappLogoRiveWidgetState();
}

class _HoldappLogoRiveWidgetState extends State<HoldappLogoRiveWidget>
    with SingleTickerProviderStateMixin {
  Artboard? _riveArtboard;

  @override
  void initState() {
    super.initState();
    rootBundle.load('images/bear.riv').then((data) {
      // Load the RiveFile from the binary data.
      final file = RiveFile.import(data);

      // The artboard is the root of the animation
      // and gets drawn in the Rive widget.
      final artboard = file.mainArtboard;
      var controller =
          StateMachineController.fromArtboard(artboard, 'State Machine 1');
      if (controller != null) {
        artboard.addController(controller);
      }
      setState(() => _riveArtboard = artboard);
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        body: _riveArtboard != null
            ? Rive(artboard: _riveArtboard!)
            : const Center(
                child: CircularProgressIndicator(),
              ),
      );
}

class AnimationShower extends StatelessWidget with FeatureShower {
  final bool textLeft;
  const AnimationShower(this.textLeft, {super.key});

  @override
  String title() => 'Automation';
  @override
  String subtitle() => 'Streamline your workplace with simple scripts.';
  @override
  String body() =>
      """Use Python and Pandas to convert the latest numbers into reports. Use Google Apps Script to upload those reports to the company Google Docs folder. Use an email server to send that link to everyone in the scheduled meeting, 10 minutes before. 
          """;
  @override
  String bgImage() => 'images/automation.jpg';

  @override
  bool shouldExpandToDisplay() => false;

  @override
  Widget displayContent(BuildContext context) {
    // return SizedBox.shrink();
    if (kIsWeb) {
      return const RiveAnimation.network(
          key: Key('rive'), 'assets/lottie/rivebot_transform.riv');
    } else {
      return const RiveAnimation.asset('lottie/rivebot_transform.riv',
          key: Key('rive'));
    }
    return const RiveAnimation.network(
      key: Key('rive'),
      'https://public.rive.app/community/runtime-files/3898-8161-rivebot-transform.riv',
      // placeHolder: Image(image: assetProvider('loader.gif')),
    );
    return const HoldappLogoRiveWidget();
    // return const RiveAnimation.asset('images/bear.riv');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return doBuild(context, textLeft);
  }
}
