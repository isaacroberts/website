import 'dart:developer';
// import 'dart:html';
import 'dart:math' as math;

// import 'package:decorated_icon/decorated_icon.dart';
// import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:isaac_roberts_consulting/parallax.dart';
import 'package:ms_undraw/ms_undraw.dart';
import 'package:transparent_image/transparent_image.dart';
import 'custom_layouts.dart';
import 'full_color.dart';
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
    return Stack(fit: StackFit.passthrough, children: [
      const Positioned.fill(
          child: ParallaxImage(
              image: 'images/bg.jpg', distance: 3, debugLabel: 'forest')),
      LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth <= math.max(watchSize, 300)) {
          log('v1');
          return watchView(context);
        } else if (constraints.maxWidth <= math.max(tinyWidth, 525)) {
          log('v2');
          return tinyView(context);
        } else if (constraints.maxWidth <= trioBarWidth) {
          log('v3');
          return thinView(context);
        } else if (constraints.maxWidth <= math.min(trioBarWidth, 700)) {
          log('v4');
          return midView(context);
        } else if (true || constraints.maxWidth <= processWidth + 30) {
          log('v5');
          return fullViewRebuild(context);
          return wideView(context);
          // } else {
          //   return fullView(context);
        }
      })
    ]);
  }

  Widget fullViewRebuild(BuildContext context) {
    return Stack(fit: StackFit.passthrough, children: [
      // const Positioned.fill(
      //     child: ParallaxImage(
      //         image: 'images/bg.jpg', distance: 3, debugLabel: 'forest')),

      Align(
          alignment: Alignment.centerLeft,
          child: FractionallySizedBox(
              widthFactor: .75,
              heightFactor: .75,
              child: Padding(
                  padding: const EdgeInsets.all(standardContainerMargin),
                  child: glassCard(child: const SizedBox.expand())))),
      const Align(
          widthFactor: 3,
          heightFactor: 2,
          alignment: Alignment(1, 1),
          child: ProPic()),
      Align(
          alignment: Alignment.centerLeft,
          child: FractionallySizedBox(
              widthFactor: .75,
              heightFactor: .75,
              child: Padding(
                  padding: const EdgeInsets.all(totalTextMargin),
                  child: introText(context, leftAlign: true)))),

      // rect: const RelativeRect.fromLTRB(.5, 0, .75, 1),
      // Positioned.fill(
      //     child: CustomSingleChildLayout(
      //         delegate: FractionalLayout(
      //           widthFactor: .5,
      //           heightFactor: 1,
      //           xPad: .5,
      //           alignment: Alignment.topLeft,
      //         ),
      //         child: const ProPic()))
    ]);
  }

  // Widget fullView(BuildContext context) {
  //   return Center(
  //       child: SizedBox(
  //           width: processWidth,
  //           child: Padding(
  //               padding: const EdgeInsets.symmetric(
  //                   vertical: 60, horizontal: textContainerMargin),
  //               child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.start,
  //                   mainAxisSize: MainAxisSize.max,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     Expanded(child: introText(context, leftAlign: true)),
  //                     const SizedBox(width: 15),
  //                     const SizedBox(width: 300, height: 300, child: ProPic()),
  //                   ]))));
  // }

  Widget wideView(BuildContext context) {
    return Center(
      child: SizedBox(
          width: processWidth,
          child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 60, horizontal: textContainerMargin),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: glassCard(
                            child: introText(context, leftAlign: true))),
                    const SizedBox(width: 15),
                    const SizedBox(width: 300, height: 300, child: ProPic()),
                  ]))),
    );
  }

  Widget midView(BuildContext context) {
    return Center(
        child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 60, horizontal: textContainerMargin),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: leftAlign
                              ? CrossAxisAlignment.start
                              : CrossAxisAlignment.stretch,
                          children: _introWithoutExpando(leftAlign: true),
                        )),
                        const SizedBox(width: 15),
                        const SizedBox(
                            width: 300, height: 300, child: ProPic()),
                      ]),
                  const SizedBox(height: 30),
                  ..._expando(context, leftAlign: true)
                ])));
  }

  Container thinView(BuildContext context) {
    return Container(
        alignment: Alignment.topCenter,
        // height: 400,
        child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 15, horizontal: standardContainerMargin),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: textContainerMargin),
                      child: introText(context, leftAlign: true)),
                  const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                      child: ProPic(isThin: true)),
                ])));
  }

  Container tinyView(BuildContext context) {
    return Container(
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
                  const SizedBox(height: 30),
                  const ProPic(isThin: true, roundedCorner: false),
                  const SizedBox(height: 30),
                ])));
  }

  Widget watchView(BuildContext context) {
    const ta = TextAlign.left;
    return Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Stack(children: [
          const ProPic(isThin: false, roundedCorner: false),
          Container(
              // decoration: ,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ..._introWithoutExpando(leftAlign: true),
                    const SizedBox(height: 15),
                  ]))
        ]));
  }

  List<Widget> _introWithoutExpando({required bool leftAlign}) {
    var ta = leftAlign ? TextAlign.left : TextAlign.center;
    return [
      //TODO: move this outside container to have it touch the left edge
      Text(
        'Creative Mobile & Web',
        style:
            fonts.displayLarge!.copyWith(backgroundColor: Colors.transparent),
        textAlign: ta,
      ),
      const SizedBox(height: 15),
      // Text(
      //   'Isaac Roberts',
      //   style: fonts.headlineMedium,
      //   textAlign: ta,
      // ),
      Text(
        bodyString(),
        style: fonts.bodyLarge,
        textAlign: ta,
      ),
    ];
  }

  List<Widget> _expando(BuildContext context, {required bool leftAlign}) {
    var ta = leftAlign ? TextAlign.left : TextAlign.center;
    return [
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
    ];
  }

  Widget introText(BuildContext context, {required bool leftAlign}) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment:
            leftAlign ? CrossAxisAlignment.start : CrossAxisAlignment.stretch,
        children: [
          ..._introWithoutExpando(leftAlign: leftAlign),
          const SizedBox(height: 30),
          ..._expando(context, leftAlign: leftAlign)
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
        padding: const EdgeInsets.only(top: 30, bottom: 15),
        child: Text(extString(), textAlign: align, style: fonts.bodyLarge));
  }
}

class ProPic extends StatefulWidget {
  final bool isThin;
  final bool roundedCorner;
  const ProPic({Key? key, this.isThin = false, this.roundedCorner = true})
      : super(key: key);

  @override
  State<ProPic> createState() => _ProPicState();
}

class _ProPicState extends State<ProPic> {
  Widget clipper({required Widget child}) {
    if (widget.isThin) {
      if (widget.roundedCorner) {
        return SizedBox(
            height: 300,
            child: ClipRRect(
                //     borderRadius: const BorderRadius.all(Radius.circular(15)),
                child: child));
      } else {
        return SizedBox(height: 300, child: ClipRect(child: child));
      }
    } else {
      if (widget.roundedCorner) {
        return AspectRatio(aspectRatio: 1, child: child);
      } else {
        return AspectRatio(aspectRatio: 1, child: ClipRect(child: child));
      }
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
          child: Padding(
        padding: EdgeInsets.fromLTRB(m, m * 2, m, 0),
        child: fadeAssetFore(
          'images/coffee_header_shrink.png',
          // width: s * IPHI,
          // height: s * IPHI,
          alignment: Alignment.bottomCenter,
        ),
      )),
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
