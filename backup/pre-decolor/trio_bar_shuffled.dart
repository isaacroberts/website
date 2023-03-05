import 'package:flutter/material.dart';
import 'device.dart';
import 'trio_bar.dart';

Widget trioContainerShuffled(BuildContext context) {
  return SizedBox(
      width: Device.width,
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(padding: EdgeInsets.only(top: 15)),
            iconRow(context),
            const Padding(padding: EdgeInsets.only(top: 15)),
            titleRow(context),
            const Padding(padding: EdgeInsets.only(top: 15)),
            bodyRow(context),
          ]));
}

Widget spanRow(BuildContext context, List<Widget> children) {
  return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children);
}

Widget iconRow(BuildContext context) {
  return spanRow(
      context, [buildIcon(icons[0]), buildIcon(icons[1]), buildIcon(icons[2])]);
}

Widget titleRow(BuildContext context) {
  return spanRow(context, [
    buildHeadline(titles[0]),
    buildHeadline(titles[1]),
    buildHeadline(titles[2])
  ]);
}

Widget bodyRow(BuildContext context) {
  return spanRow(context, [
    buildBodyText(bodies[0]),
    buildBodyText(bodies[1]),
    buildBodyText(bodies[2])
  ]);
}
