import 'package:flutter/material.dart';
import 'text_theme.dart';
import 'theme.dart';
import 'common_elements.dart';
import 'dart:math' as math;
import 'package:ms_undraw/ms_undraw.dart';
import 'dart:developer';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'device.dart';
import 'package:fluttericon/brandico_icons.dart';
import 'package:fluttericon/zocial_icons.dart';

class DownloadSection extends StatelessWidget {
  const DownloadSection({Key? key}) : super(key: key);

  void download(String os) {}

  @override
  Widget build(BuildContext context) {
    return Column(
        // height: 400,
        children: [
          paraSmall(
              "With Flutter, I can easily make cross-platform apps that work wherever your users are.\nWith detail-oriented design skills, I can make them look good on every screen.",
              align: TextAlign.center,
              selectable: true),
          // const Padding(padding: EdgeInsets.only(top: 30)),
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              // spacing: 15,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildOSButton('win', Zocial.windows, 'Download for Windows'),
                buildOSButton('mac', Zocial.macstore, 'Download for Mac'),
                buildOSButton('ios', Zocial.appstore, 'Download for iOS'),
                buildOSButton(
                    'android', Zocial.android, 'Download for Android'),
              ]),
          // const Padding(padding: EdgeInsets.only(top: 30))
        ]);
  }

  Widget buildOSButton(String os, IconData icon, String text) {
    return Padding(
        padding: const EdgeInsets.only(top: 30),
        child: ElevatedButton.icon(
            onPressed: () => download(os),
            icon: Icon(icon),
            label: Text(text, style: fonts.button)));
  }

  static Widget sliver() {
    return const SliverToBoxAdapter(child: DownloadSection());
  }
}
