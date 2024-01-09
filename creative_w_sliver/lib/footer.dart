import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'text_theme.dart';
import 'footer_renderer.dart';
import 'theme.dart';
import 'common_elements.dart';
import 'dart:math' as math;
import 'package:ms_undraw/ms_undraw.dart';
import 'dart:developer';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'device.dart';
import 'package:fluttericon/zocial_icons.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  void launch(String urlS) async {
    Uri url = Uri.parse(urlS);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      // can't launch url, there is some error
      throw "Could not launch $url";
    }
  }

  Widget linkButton(BuildContext context, IconData icon, String link) {
    return IconButton(
      onPressed: () => launch(link),
      icon: Icon(icon),
      padding: EdgeInsets.zero,
      color: colorScheme.onSecondary,
    );
  }

  Widget socials(BuildContext context) {
    return Wrap(children: [
      linkButton(
          context, Zocial.github_circled, 'https://github.com/isaacroberts'),
      linkButton(context, Zocial.stackoverflow,
          'https://stackoverflow.com/users/2813206/isaac-roberts'),
      // linkButton(context, Zocial.twitter, 'https://twitter.com/AlgorithmAudio'),
      // linkButton(context, Icons.language, 'https://algorithmic-software.com'),
      linkButton(context, Zocial.youtube, 'https://youtu.be/Q40qEg8Yq5c'),
    ]);
  }

  Widget sideText(TextAlign align) {
    return Wrap(children: [
      Text('Open Sorcery LLC, 2022 ©, All Rights reserved',
          style: fonts.bodySmall?.copyWith(color: colorScheme.onSecondary),
          textAlign: align),
    ]);
  }

  Widget sideFlex(List<Widget> children) {
    if (Device.isPhone) {
      return OrientationBuilder(builder: (context, orient) {
        if (Device.isPhonePort) {
          return Column(
              verticalDirection: VerticalDirection.up,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: children);
        } else {
          //Same as below
          return Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: children);
        }
      });
    }
    return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: children);
  }

  @override
  Widget build(BuildContext context) {
    // if (constraints.ma)
    // log('constraints $constraints');
    return Container(
        alignment: Alignment.bottomCenter,
        // color: footerColor,
        // decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //         begin: Alignment.bottomCenter,
        //         end: Alignment.topCenter,
        //         colors: [
        //       primary.shade500,
        //       primary.shade700,
        //     ])),
        // height: 200,
        // child: Center(child: Text('Footer')));
        child: ClipRect(
            child: OverflowBox(
                maxHeight: double.infinity, // intended to overflow vertically
                alignment: Alignment.bottomCenter, //extra right to cover FAB
                child: footContent(context))));
  }

  Widget footContent(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (Device.width > 550) {
        return wideView(context);
      } else {
        return thinView(context);
      }
    });
  }

  Widget wideView(BuildContext context) {
    return Center(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 15),
            child: SizedBox(
                width: processWidth,
                // child: SelectionArea(
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Isaac Roberts Consulting',
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: fonts.displaySmall),
                      const SizedBox(height: 45),
                      sideFlex([sideText(TextAlign.left), socials(context)]),

                      // const Padding(
                      //     padding: EdgeInsets.fromLTRB(30, 0, 80, 0),
                      //     child: Divider(thickness: 1)),
                    ]))));
  }

  Widget thinView(BuildContext context) {
    return
        // SelectionArea(
        //   child:
        Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
          Text('Isaac Roberts Consulting',
              textAlign: TextAlign.center,
              maxLines: 3,
              style: fonts.displaySmall),
          const SizedBox(height: 30),
          socials(context),
          const SizedBox(height: 30),
          sideText(TextAlign.center),
          const SizedBox(height: 15),
          const SizedBox(height: 50),
          // const Padding(
          //     padding: EdgeInsets.fromLTRB(30, 0, 80, 0),
          //     child: Divider(thickness: 1)),
        ]);
  }

  static Widget sliver() {
    return const SliverFooter(child: Footer());
  }

  static Widget emptySliver() {
    return SliverToBoxAdapter(
        child: Container(height: 200, color: Colors.transparent));
    // return const SliverFillRemaining(
    //   hasScrollBody: true,
    //   fillOverscroll: false,
    //   child: Footer(),
    // );
  }
}
