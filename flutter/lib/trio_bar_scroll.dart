import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:lottie/lottie.dart';
import 'trio_lottie.dart';
import 'common_elements.dart';
import 'device.dart';
import 'trio_bar.dart';
import 'dart:math' as math;
import 'theme.dart';

class PopColumnScrollWithIcon extends StatefulWidget {
  final String icon;
  final String header;
  final String body;
  const PopColumnScrollWithIcon(this.icon, this.header, this.body, {Key? key})
      : super(key: key);

  @override
  State<PopColumnScrollWithIcon> createState() =>
      _PopColumnScrollWithIconState();
}

class _PopColumnScrollWithIconState
    extends TrioLottieHaver<PopColumnScrollWithIcon> {
  // late final AnimationController _controller;
  // late final bool hovered;

  Widget iconIfSize() {
    return LayoutBuilder(builder: (context, constraints) {
      if (Device.width >= 400) {
        return Container(
            width: 120,
            height: 120,
            margin: const EdgeInsets.all(15),
            child: buildLottie(widget.icon));
      } else {
        return const SizedBox(width: 15);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const bool leftAlign = true;
    return Card(
        margin: const EdgeInsets.fromLTRB(15, 0, 15, 15),
        child: inkwellWrapper(Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              iconIfSize(),
              Expanded(
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: leftAlign
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.center,
                      children: [
                    Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 15),
                        child: buildHeadline(widget.header)),
                    Container(
                        // width: 250,
                        margin: const EdgeInsets.only(bottom: 30),
                        alignment:
                            leftAlign ? Alignment.topLeft : Alignment.topCenter,
                        child: paraSmall(widget.body,
                            align:
                                leftAlign ? TextAlign.left : TextAlign.center))
                  ])),
              const SizedBox(width: 15)
            ])));
  }

  Column popColumnScrollNoIcon() {
    bool leftAlign = false;
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment:
            leftAlign ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: buildHeadline(widget.header)),
          Container(
              margin: const EdgeInsets.only(bottom: 30, left: 15, right: 15),
              alignment: leftAlign ? Alignment.topLeft : Alignment.topCenter,
              child: paraSmall(widget.body,
                  align: leftAlign ? TextAlign.left : TextAlign.center))
        ]);
  }
}
