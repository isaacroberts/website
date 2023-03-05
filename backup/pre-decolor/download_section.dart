import 'package:flutter/material.dart';
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
    return Container(
        decoration: gradient(GradientStop.Download),
        // color: gradientStops[5],
        child: Column(
            // height: 400,
            children: [
              paragraph(
                  "With Flutter, I can easily make cross-platform apps that work wherever your users are.\nWith detail-oriented design skills, I can make them look good on every screen.",
                  leftAlign: false,
                  selectable: true),
              const Padding(padding: EdgeInsets.only(top: 30)),
              Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 15,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    ElevatedButton.icon(
                        onPressed: () => download('win'),
                        icon: const Icon(Zocial.windows),
                        label: const Text('Download for Windows')),
                    ElevatedButton.icon(
                        onPressed: () => download('mac'),
                        icon: const Icon(Zocial.macstore),
                        label: const Text('Download for Mac')),
                    ElevatedButton.icon(
                        onPressed: () => download('ios'),
                        icon: const Icon(Zocial.appstore),
                        label: const Text('Download for iOS')),
                    ElevatedButton.icon(
                        onPressed: () => download('android'),
                        icon: const Icon(Zocial.android),
                        label: const Text('Download for Android')),
                  ]),
              // const Padding(padding: EdgeInsets.only(top: 30))
            ]));
  }

  static Widget sliver() {
    return const SliverToBoxAdapter(child: DownloadSection());
  }
}
