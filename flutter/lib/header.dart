import 'dart:developer';
// import 'dart:html';
import 'dart:math' as math;

// import 'package:decorated_icon/decorated_icon.dart';
// import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ms_undraw/ms_undraw.dart';
import 'package:transparent_image/transparent_image.dart';
import 'main.dart';
import 'text_theme.dart';
import 'trio_bar.dart';

import 'common_elements.dart';
import 'device.dart';
import 'theme.dart';
import 'colorable_flutter_logo.dart';

class Header extends StatefulWidget {
  final GlobalKey? scrollTo;
  const Header({this.scrollTo, Key? key}) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> with TickerProviderStateMixin {
  bool extended = false;
  AnimationController? expander;
  // Animation<double> icon = ;

  @override
  void initState() {
    // TODO: implement initState
    expander = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
    super.initState();
  }

  void toggleExt() {
    setState(() {
      extended = !extended;
      expander?.animateTo(extended ? 1 : 0);
    });
  }

  void setExt(bool b) {
    if (extended != b) {
      setState(() {
        extended = b;
        expander?.animateTo(extended ? 1 : 0);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 600 + 120 * 2) {
        return wideView(context);
        // } else if (constraints.maxWidth > 800) {
        //   return midView(context);
      } else if (constraints.maxWidth > tinyWidth) {
        return thinView(context);
      } else {
        return tinyView(context);
      }
    }));
  }

  BoxDecoration? containerDeco() {
    return null;
    return const BoxDecoration(
        // color: Grayscale.shade900
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Grayscale.shade800, Color(0x00000000)]));
  }

  Container wideView(BuildContext context) {
    // log('wide');
    return Container(
      decoration: containerDeco(),
      alignment: Alignment.topCenter,
      child: Padding(
          padding: const EdgeInsets.fromLTRB(120, 60, 120, 90),
          child: SizedBox(
              width: 800,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: introText(context, leftAlign: true)),
                    const SizedBox(width: 15),
                    const SizedBox(width: 300, height: 300, child: ProPic()),
                  ]))),
    );
  }

  Container thinView(BuildContext context) {
    return Container(
        decoration: containerDeco(),
        alignment: Alignment.topCenter,
        // height: 400,
        child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 15, horizontal: totalTextMargin),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: introText(context, leftAlign: false)),
                  const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 30),
                      child: ProPic(isThin: true)),
                ])));
  }

  Container tinyView(BuildContext context) {
    return Container(
        decoration: containerDeco(),
        alignment: Alignment.topCenter,
        // height: 400,
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: totalTextMargin),
                      child: introText(context, leftAlign: true)),
                  const SizedBox(height: 45),
                  const ProPic(isThin: true),
                  const SizedBox(height: 30),
                ])));
  }

  Widget introText(BuildContext context, {required bool leftAlign}) {
    //Centered: fullwidth=true
    //Left: fullwidth=false
    //Two columns: fullwidth=false

    var ta = leftAlign ? TextAlign.left : TextAlign.center;
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment:
            leftAlign ? CrossAxisAlignment.start : CrossAxisAlignment.stretch,
        children: [
          Text(
            'Isaac Roberts',
            style: fonts.displayLarge,
            textAlign: ta,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Text(
              bodyString(),
              style: fonts.bodyLarge,
              textAlign: ta,
            ),
          ),
          ElevatedButton.icon(
              icon: (expander != null)
                  ? ExpandIcon(
                      isExpanded: extended,
                      onPressed: setExt,
                    )
                  : const Icon(Icons.expand_more),
              label: const Text('Learn More'),
              onPressed: toggleExt // scrollLearnMore(widget.scrollTo),
              ),
          extAnimator(context, ta)
        ]);
  }

  Widget extAnimator(BuildContext context, TextAlign align) {
    return AnimatedBuilder(
        animation: expander!,
        builder: (context, widget) {
          return SizeTransition(sizeFactor: expander!, child: extText(align));
        });
  }

  String bodyString() =>
      """Whether you're trying to launch a startup or build a workplace utility app, Python and Flutter can get you there.""";
  String extString() =>
      """As a full-stack developer specializing in mobile and web development, I help my clients turn their ideas into successful apps.\nMy expertise in the Flutter framework allows me to build beautiful, multiplatform apps, and my expertise with Python creates production-ready backends. Contact me today to see how I can meet your needs.""";

  Padding extText(TextAlign align) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Text(extString(), textAlign: align, style: fonts.bodyLarge));
  }
}

class ProPic extends StatefulWidget {
  final bool isThin;
  const ProPic({Key? key, this.isThin = false}) : super(key: key);

  @override
  State<ProPic> createState() => _ProPicState();
}

class _ProPicState extends State<ProPic> {
  final GlobalKey _backgroundImageKey = GlobalKey(debugLabel: 'bg image');
  final GlobalKey _myImageKey = GlobalKey(debugLabel: 'face image');

  Widget clipper({required Widget child}) {
    if (widget.isThin) {
      return SizedBox(
          height: 300,
          child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              child: child));
    } else {
      return AspectRatio(aspectRatio: 1, child: ClipOval(child: child));
    }
    return child;
  }

  Widget flutterLogo() {
    if (Device.isDesktop || true) {
      return Positioned.fill(
          child: Align(
              alignment: Alignment.bottomLeft,
              child: FractionallySizedBox(
                  widthFactor: .333,
                  heightFactor: .333,
                  child: coloredFlutterLogo(size: 75))));
    }
    return const SizedBox.shrink();
  }

  ColoredFlutterLogo coloredFlutterLogo({double? size}) {
    return ColoredFlutterLogo(
        topColor: flutterLogoTop, //widget.isThin ? Colors.white : primary,
        botColor:
            flutterLogoBot, //widget.isThin ? Colors.grey.shade400 : secondary,
        size: size);
  }

  @override
  Widget build(BuildContext context) {
    double s = 500;
    // if (s.isInfinite) s = 300;
    double m = s * (1 - IPHI) / 4;
    double sp = s * IPHI;
    m = 15;
    return Stack(alignment: Alignment.bottomLeft, children: [
      clipper(
          child: Stack(alignment: Alignment.bottomCenter, children: [
        Flow(
            delegate: ParallaxFlowDelegate(
              scrollable: Scrollable.of(context),
              listItemContext: context,
              backgroundImageKey: _backgroundImageKey,
              distance: widget.isThin ? 0 : 0,
            ),
            children: [
              // clipBehavior: Clip.antiAlias,
              fadeAssetBg('images/bg.jpg',
                  fit: BoxFit.cover, key: _backgroundImageKey),
            ]),
        Padding(
            padding: EdgeInsets.fromLTRB(m, m * 2, m, 0),
            child: fadeAssetFore(
              'images/coffee_header_shrink.png',
              // width: s * IPHI,
              // height: s * IPHI,
              alignment: Alignment.bottomCenter,
            )),
      ])),
      flutterLogo(),
    ]);
  }
}

void scrollLearnMore(GlobalKey? scrollTo) {
  if (scrollTo != null) {
    BuildContext? ct = scrollTo.currentContext;
    if (ct != null) {
      Scrollable.ensureVisible(ct,
          duration: const Duration(milliseconds: 750), curve: Curves.ease);
    }
  }
}
