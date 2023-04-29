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
    return layoutMode(context);
    // return Stack(fit: StackFit.passthrough, children: [
    //   const Positioned.fill(
    //       child: ParallaxImage(
    //           image: 'images/bg.jpg', distance: 3, debugLabel: 'forest')),
    //   LayoutBuilder(builder: (context, constraints) {
    //     if (false) {
    //       // if (constraints.maxWidth <= math.max(watchSize, 300)) {
    //       //   log('v1');
    //       //   return watchView(context);
    //       // } else if (constraints.maxWidth <= math.max(tinyWidth, 525)) {
    //       //   log('v2');
    //       //   return tinyView(context);
    //       // } else if (constraints.maxWidth <= trioBarWidth) {
    //       //   log('v3');
    //       //   return thinView(context);
    //     } else if (constraints.maxWidth <= 800) {
    //       log('v4');
    //       return midView(context);
    //     } else {
    //       log('v5');
    //       return fullViewRebuild(context);
    //     }
    //   })
    // ]);
  }

  Widget layoutMode(BuildContext context) {
    return ClipRRect(
        child: AnimatedBuilder(
            animation: Scrollable.of(context).position,
            builder: (context, widget) => CustomMultiChildLayout(
                    delegate: InterlacedLayout(
                        scroll: Scrollable.of(context).position.pixels),
                    children: [
                      LayoutId(
                          id: Slot.bg,
                          child:
                              fadeAssetBg('images/bg.jpg', fit: BoxFit.cover)),

                      // child: const ParallaxImage(
                      //     image: 'images/bg.jpg',
                      //     distance: 3,
                      //     debugLabel: 'forest')),
                      LayoutId(
                          id: Slot.middle,
                          child: Align(
                              widthFactor: 3,
                              heightFactor: 2,
                              alignment: const Alignment(1, 1),
                              child: fadeAssetFore(
                                'images/coffee_header_shrink.png',
                                alignment: Alignment.bottomRight,
                              ))),
                      LayoutId(
                        id: Slot.xtr,
                        child: const Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                                padding: EdgeInsets.all(k * 2),
                                child: ColoredFlutterLogo(
                                    topColor:
                                        flutterLogoTop, //widget.isThin ? Colors.white : primary,
                                    botColor:
                                        flutterLogoBot, //widget.isThin ? Colors.grey.shade400 : secondary,
                                    size: k * 12))),
                      ),
                      LayoutId(id: Slot.back, child: glassCard(child: null)),
                      LayoutId(
                          id: Slot.front,
                          child: SingleChildScrollView(
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: totalTextMargin,
                                      vertical: k * 4),
                                  child: introText(context, leftAlign: true)))),
                    ])));
  }

  Widget fullViewRebuild(BuildContext context) {
    return Stack(fit: StackFit.passthrough, children: [
      // const Positioned.fill(
      //     child: ParallaxImage(
      //         image: 'images/bg.jpg', distance: 3, debugLabel: 'forest')),

      Positioned.fill(
          child: Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                  widthFactor: .75,
                  heightFactor: .75,
                  child: Padding(
                      padding: const EdgeInsets.all(standardContainerMargin),
                      child: glassCard(child: const SizedBox.expand()))))),
      const Align(
          widthFactor: 3,
          heightFactor: 2,
          alignment: Alignment(1, 1),
          child: ProPic()),
      Positioned.fill(
          child: Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                  widthFactor: .75,
                  heightFactor: .75,
                  child: Padding(
                      padding: const EdgeInsets.all(totalTextMargin),
                      child: introText(context, leftAlign: true))))),

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

  List<Widget> _introWithoutExpando({required bool leftAlign}) {
    var ta = leftAlign ? TextAlign.left : TextAlign.center;
    return [
      //TODO: move this outside container to have it touch the left edge
      LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth > 500) {
          return Text(
            'Creative Mobile & Web',
            style: fonts.displayLarge!
                .copyWith(backgroundColor: Colors.transparent),
            textAlign: ta,
          );
        }
        return Text(
          'Creative Mobile & Web',
          style: fonts.displayMedium!
              .copyWith(backgroundColor: Colors.transparent),
          textAlign: ta,
        );
      }),
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
        mainAxisSize: MainAxisSize.min,
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
    return Stack(alignment: Alignment.bottomLeft, children: [
      fadeAssetFore(
        'images/coffee_header_shrink.png',
        // width: s * IPHI,
        // height: s * IPHI,
        alignment: Alignment.bottomRight,
      ),
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
