import 'package:flutter/material.dart';
import 'common_elements.dart';
import 'device.dart';
import 'trio_bar.dart';
import 'dart:math' as math;
import 'theme.dart';

Column popColumnScroll(String icon, String header, String body) {
  //TODO: Add a row to this if the size allows, putting the icon back in
  return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment:
          leftAlign ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        // LayoutBuilder(
        //     builder: (BuildContext context, BoxConstraints constraints) {
        //   return Icon(icon,
        //       size: math.min(
        //           100,
        //           math.min(
        //               constraints.biggest.height, constraints.biggest.width)),
        //       color: theme.primaryColor);
        // }),
        Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            child: buildHeadline(header)),
        Container(
            width: 250,
            margin: const EdgeInsets.only(bottom: 30),
            alignment: leftAlign ? Alignment.topLeft : Alignment.topCenter,
            // child: Text(
            //   body,
            //   maxLines: null,
            //   softWrap: true,
            //   // strutStyle: StrutStyle(),
            //   overflow: TextOverflow.visible,
            //   textAlign: leftAlign ? TextAlign.left : TextAlign.center,
            // )
            child: paragraph(body, leftAlign: leftAlign))
      ]);
}

Container trioContainerScroll(BuildContext context) {
  return Container(
      alignment: Alignment.center,
      width: Device.width,
      child: crossLayout(context, true));
}
