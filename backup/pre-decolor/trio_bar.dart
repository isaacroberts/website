import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:developer';
import 'dart:math' as math;

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:website/text_theme.dart';
import 'package:website/trio_lottie.dart';

import 'theme.dart';
import 'common_elements.dart';

import 'device.dart';
import 'trio_bar_scroll.dart';

const bool leftAlign = false;

bool get trioOnHeader => false;

// final List<IconData> icons = [
//   MdiIcons.codeBraces,
//   MdiIcons.brush,
//   MdiIcons.shieldBug
// ];

final List<String> icons = [
  'compass',
  '1431-fibonacci-flat-edited3',
  'responsive'
];

final List<String> titles = ['Develop', 'Design', 'Debug'];
final List<String> bodies = [
  "I can help you quickly build robust, high-quality apps that are easy to maintain and upgrade.",
  "With my UI/UX design skills, I can help you create an app that is both beautiful and easy to use.",
  "Don't let pesky bugs and glitches ruin your app. I can help you identify and fix them, ensuring a seamless experience."
];

Widget popItem(BuildContext context, bool useScroll, bool useSliver,
    String icon, String header, String body) {
  if (useSliver) {
    return ConstrainedBox(
        constraints: BoxConstraints(
            maxWidth: Device.width,
            // maxHeight: Device.height,
            // minHeight: 20,
            minWidth: Device.width),
        child: popColumn(true, icon, header, body));
  } else if (!trioOnHeader || true) {
    // log('!trioOnHeader');
    return SizedBox(
        width: useScroll ? 330 : 280,
        height: useScroll ? 360 : null,
        child: Card(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                child: popColumn(useScroll, icon, header, body))));
  } else {
    // log('flex');
    return Flexible(
        child: Card(
            margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
            child: Padding(
                padding: EdgeInsets.only(
                    bottom: Device.isPhone ? 15 : 30,
                    left: 30,
                    right: 30,
                    top: 30),
                child: popColumn(useScroll, icon, header, body))));
  }
}

Widget popColumn(bool useScroll, String icon, String header, String body) {
  if (useScroll) {
    return popColumnScroll(icon, header, body);
  } else {
    return popColumnNoScroll(icon, header, body);
  }
}

Column popColumnNoScroll(String icon, String header, String body) {
  return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment:
          leftAlign ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        TrioLottie(icon),
        const Padding(padding: EdgeInsets.only(top: 15)),
        buildHeadline(header),
        const Padding(padding: EdgeInsets.only(top: 15)),
        buildBodyText(body)
      ]);
}

Column popColumnNoScrollFlex(String icon, String header, String body) {
  return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment:
          leftAlign ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        // Flexible(
        //   flex: 1,
        //   child: buildIcon(icon),
        // ),
        Flexible(flex: 1, child: buildHeadline(header)),
        Flexible(flex: 1, child: buildBodyText(body))
      ]);
}

Container buildBodyText(String body) {
  return Container(
      width: 250,
      alignment: leftAlign ? Alignment.topLeft : Alignment.topCenter,
      child: paragraph(body, leftAlign: leftAlign));
}

Text buildHeadline(String header) {
  return Text(
    header,
    style: fonts.headlineSmall,
    // textAlign: TextAlign.center,
  );
}

LayoutBuilder buildIcon(String icon) {
  return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
    return Text(icon);
    // Icon(icon,
    //   size: math.min(100,
    //       math.min(constraints.biggest.height, constraints.biggest.width)),
    //   color: colorScheme.primary);
  });
}

List<Widget> itemList(BuildContext context, bool useScroll, bool useSliver) {
  return [
    popItem(context, useScroll, useSliver, icons[0], titles[0], bodies[0]),
    popItem(context, useScroll, useSliver, icons[1], titles[1], bodies[1]),
    popItem(context, useScroll, useSliver, icons[2], titles[2], bodies[2]),
  ];
}

Widget trioSliver(BuildContext context) {
  bool useScroll = Device.width < 950;

  if (useScroll) {
    return SliverList(
      delegate: SliverChildListDelegate(itemList(context, true, true)),
    );
  }
  return SliverToBoxAdapter(child: trioContainerNoScroll(context));
}

Widget trioContainer(BuildContext context) {
  bool useScroll = Device.width < 950;

  if (useScroll) {
    return trioContainerScroll(context);
  } else {
    return trioContainerNoScroll(context);
  }
}

Widget trioContainerNoScroll(BuildContext context) {
  // log('sbox');
  return Container(
      decoration: gradient(GradientStop.Trio),
      alignment: Alignment.center,
      width: math.min(Device.width, 1000),
      child: Padding(
          padding: const EdgeInsets.fromLTRB(90, 45, 90, 30),
          child: crossLayout(context, false)));
}

Widget crossLayout(BuildContext context, bool useScroll) {
  if (!useScroll) {
    // log('crosl');

    return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: itemList(context, false, false));
  } else {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: itemList(context, true, false));
  }
}
