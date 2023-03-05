import 'dart:developer';
// import 'dart:html';
import 'dart:math' as math;

// import 'package:decorated_icon/decorated_icon.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ms_undraw/ms_undraw.dart';
import 'package:website/text_theme.dart';
import 'package:website/trio_bar.dart';

import 'common_elements.dart';
import 'device.dart';
import 'theme.dart';

Widget header(BuildContext context, {GlobalKey? scrollTo}) {
  // log('theme HLL: ${theme.textTheme.headlineLarge}');
  return SliverToBoxAdapter(
      child: Stack(alignment: Alignment.bottomRight, children: [
    Container(
        alignment: Alignment.topCenter,
        height: 400,
        // decoration:
        // imageOnGradient('images/coffee_header.png', GradientStop.Header),
        decoration: gradient(GradientStop.Header),
        // color: theme.canvasColor,

        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Device.isPhonePort
                  ? Container(
                      margin: const EdgeInsets.symmetric(horizontal: 45),
                      child: Wrap(children: [
                        introText(context, scrollTo),
                        const ProPic(),
                      ]))
                  : Container(
                      width: math.min(1200, Device.width),
                      margin: const EdgeInsets.symmetric(horizontal: 120),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Flexible(
                                flex: 2, child: introText(context, scrollTo)),
                            const Flexible(flex: 1, child: ProPic()),
                          ])),
            ])),
    flutterLogo(),
  ]));
}

Widget flutterLogo() {
  if (Device.isDesktop || true) {
    return
        // Positioned.fill(
        //   child: Align(
        //       alignment: Alignment.bottomRight,
        //       child:

        // margin:
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            child: SvgPicture.asset(
              'svgs/flutter-colored.svg',
              height: 75,
            ));
  }
  return const SizedBox.shrink();
}

Widget introText(BuildContext context, GlobalKey? scrollTo) {
  double bm = Device.select(def: 0, phonePort: 0);
  return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 20, bm),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Consulting with Style',
              style: fonts.headlineLarge,
              textAlign: TextAlign.left,
            ),
            // AnimatedTextKit(
            //   animatedTexts: [
            //     FadeAnimatedText(
            //       'Consulting With Style',
            //       textStyle: fonts.displayMedium,
            //       textAlign: TextAlign.left,
            //     ),
            //   ],
            //   isRepeatingAnimation: false,
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                  """As a freelancer specializing in mobile and web development, I help my clients turn their ideas into successful apps. My expertise in the Flutter framework allows me to build beautiful, multiplatform apps.""",
                  style: fonts.bodyLarge),
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.keyboard_arrow_down),
              label: Text('Learn More', style: fonts.button),
              onPressed: () => scrollLearnMore(scrollTo),
            )
          ]));
}

class ProPic extends StatefulWidget {
  const ProPic({Key? key}) : super(key: key);

  @override
  State<ProPic> createState() => _ProPicState();
}

class _ProPicState extends State<ProPic> {
  final GlobalKey _backgroundImageKey = GlobalKey(debugLabel: 'bg image');
  final GlobalKey _myImageKey = GlobalKey(debugLabel: 'face image');

  Widget clipper({required Widget child}) {
    if (Device.isPhonePort) {
      return Padding(
          padding: const EdgeInsets.only(top: 30),
          child: AspectRatio(
              aspectRatio: 1.5,
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  child: child)));
    } else {
      return Padding(
          padding: const EdgeInsets.all(30),
          child: AspectRatio(aspectRatio: 1, child: ClipOval(child: child)));
    }
    return child;
  }

  @override
  Widget build(BuildContext context) {
    double s = 500;
    // if (s.isInfinite) s = 300;
    double m = s * (1 - IPHI) / 4;
    double sp = s * IPHI;
    m = 15;
    return Align(
        // alignment: Alignment.centerLeft,
        child: clipper(
            child: Stack(children: [
      Flow(
          delegate: ParallaxFlowDelegate(
            scrollable: Scrollable.of(context)!,
            listItemContext: context,
            backgroundImageKey: _backgroundImageKey,
            distance: 10,
          ),
          children: [
            // clipBehavior: Clip.antiAlias,
            Image.asset('images/bg.jpg',
                fit: BoxFit.cover, key: _backgroundImageKey),
          ]),
      Padding(
          padding: EdgeInsets.fromLTRB(m, m * 2, m, 0),

          // child: Flow(
          //     delegate: ParallaxFlowDelegate(
          //       scrollable: Scrollable.of(context)!,
          //       listItemContext: context,
          //       backgroundImageKey: _myImageKey,
          //       distance: 5,
          //     ),
          //     children: [
          //       // clipBehavior: Clip.antiAlias,
          //       Image.asset('images/coffee_header_shrink.png',
          //           width: s * IPHI,
          //           height: s * IPHI,
          //           key: _myImageKey),
          //     ]),

          child: Image.asset(
            'images/coffee_header_shrink.png',
            width: s * IPHI,
            height: s * IPHI,
            alignment: Alignment.bottomCenter,
          )),
    ])));
  }
}

void scrollLearnMore(scrollTo) {
  if (scrollTo != null) {
    BuildContext? ct = scrollTo.currentContext;
    if (ct != null) {
      Scrollable.ensureVisible(ct,
          duration: const Duration(milliseconds: 750), curve: Curves.ease);
    }
  }
}
