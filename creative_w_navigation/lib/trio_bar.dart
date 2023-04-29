import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:developer';
import 'dart:math' as math;

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'full_color.dart';
import 'text_theme.dart';
import 'trio_lottie.dart';

import 'theme.dart';
import 'common_elements.dart';

import 'device.dart';
import 'trio_bar_scroll.dart';

const bool leftAlign = false;

// final List<IconData> icons = [
//   MdiIcons.codeBraces,
//   MdiIcons.brush,
//   MdiIcons.shieldBug
// ];

final List<String> icons = ['responsive', 'caliper', 'brush'];

final List<String> titles = ['Prototype', 'Debug', 'Deliver'];
final List<String> bodies = [
  "I can help you quickly build robust, high-quality apps that are easy to maintain and upgrade.",
  "Don't let bugs and glitches ruin your app. I can help you identify and fix them.",
  "With my UI/UX design skills, I can help you create an app that is both beautiful and easy to use.",
];

class PopItemHorizontal extends StatefulWidget {
  static const bool useScroll = false;
  static const bool useSliver = false;

  final String icon, header, body;

  const PopItemHorizontal(this.icon, this.header, this.body, {Key? key})
      : super(key: key);

  @override
  State<PopItemHorizontal> createState() => _PopItemHorizontalState();
}

class _PopItemHorizontalState extends TrioLottieHaver<PopItemHorizontal> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: trioHorizWidth,
        child: Card(
            // color: colorScheme.tertiaryContainer,
            margin: EdgeInsets.zero,
            child: inkwellWrapper(Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                child: popColumn()))));
  }

  Widget popColumn() {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment:
            leftAlign ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          buildLottie(widget.icon),
          // const Padding(padding: EdgeInsets.only(top: 15)),
          buildHeadline(widget.header),
          // const Padding(padding: EdgeInsets.only(top: 15)),
          buildBodyText(widget.body)
        ]);
  }
}

Container buildBodyText(String body) {
  return Container(
      width: 250,
      alignment: leftAlign ? Alignment.topLeft : Alignment.topCenter,
      child:
          paraMed(body, align: leftAlign ? TextAlign.left : TextAlign.center));
}

Text buildHeadline(String header) {
  return Text(
    header,
    style: fonts.titleLarge?.copyWith(color: Sec1Dark.v7),
  );
}

Widget headlineWithIcon(String header, String icon) {
  TextStyle style = fonts.displaySmall ?? watchHeader;
  return RichText(
      text: TextSpan(children: <InlineSpan>[
    TextSpan(
      text: '$header ',
      style: style,
    ),
    WidgetSpan(
      child: SvgPicture.asset('lottie/$icon.svg', height: style.fontSize),
      alignment: PlaceholderAlignment.bottom,
    ),
  ]));
}

List<Widget> popHorizontal(BuildContext contex) {
  return [
    PopItemHorizontal(icons[0], titles[0], bodies[0]),
    PopItemHorizontal(icons[1], titles[1], bodies[1]),
    PopItemHorizontal(icons[2], titles[2], bodies[2]),
  ];
}

List<Widget> popScrolls(BuildContext context) {
  return [
    PopColumnScrollWithIcon(icons[0], titles[0], bodies[0]),
    PopColumnScrollWithIcon(icons[1], titles[1], bodies[1]),
    PopColumnScrollWithIcon(icons[2], titles[2], bodies[2]),
  ];
}

List<Widget> popScrollNoIcons(BuildContext context) {
  return [
    PopScrollNoIcon(icons[0], titles[0], bodies[0]),
    PopScrollNoIcon(icons[1], titles[1], bodies[1]),
    PopScrollNoIcon(icons[2], titles[2], bodies[2]),
  ];
}

List<Widget> popScrollWatch(BuildContext context) {
  return [
    PopScrollWatch(icons[0], titles[0], bodies[0]),
    PopScrollWatch(icons[1], titles[1], bodies[1]),
    PopScrollWatch(icons[2], titles[2], bodies[2]),
  ];
}

// bool get useScroll => Device.width < (trioHorizWidth * 3 + k);

Widget trioSliver(BuildContext context) {
  return SliverLayoutBuilder(builder: (context, constraints) {
    if (Device.width <= watchSize) {
      return SliverList(
          delegate: SliverChildListDelegate(popScrollWatch(context)));
    }
    if (Device.width <= 550) {
      return SliverList(
          delegate: SliverChildListDelegate(popScrollNoIcons(context)));
    } else if (Device.width < (trioHorizWidth * 3 + k)) {
      return SliverList(delegate: SliverChildListDelegate(popScrolls(context)));
    } else {
      return SliverToBoxAdapter(child: trioContainerNoScroll(context));
    }
  });
}

Widget trioContainerNoScroll(BuildContext context) {
  return Center(
      child: Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: SizedBox(
              width: trioBarWidth,
              height: 24 * 15,
              child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: popHorizontal(context)))));
}
