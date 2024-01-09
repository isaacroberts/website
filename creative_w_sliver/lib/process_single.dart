// import 'dart:html';
import 'dart:core';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_fade/image_fade.dart';
import 'package:isaac_roberts_consulting/parallax.dart';
import 'package:isaac_roberts_consulting/parallax_image_switcher.dart';
import 'package:isaac_roberts_consulting/sections.dart';
import 'text_theme.dart';
import 'vert_to_horiz_scroll.dart';
import 'theme.dart';
import 'common_elements.dart';
import 'dart:math' as math;
import 'package:ms_undraw/ms_undraw.dart';
import 'dart:developer';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'device.dart';
// import 'package:fluttericon/zocial_icons.dart';
import 'package:transparent_image/transparent_image.dart';
import 'process_sidebar.dart';

const bool putSectionHeaderInside = false;

class ProcessSingle extends StatefulWidget {
  final int firstPage;
  const ProcessSingle(this.firstPage, {Key? key}) : super(key: key);

  @override
  State<ProcessSingle> createState() => _ProcessSingleState();
}

const double imgOpacity = .3;

class _ProcessSingleState extends State<ProcessSingle> {
  late NetworkImage _bg;

  _ProcessSingleState();

  ImageProvider<Object> getBg() {
    if (kIsWeb) {
      return _bg;
    } else {
      return assetProvider('card_bgs/${cardBgs[current]}');
    }
  }

  @override
  void initState() {
    // if (kIsWeb) {
    _bg = NetworkImage('assets/card_bgs/${cardBgs[current]}');
    // }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (kIsWeb) {
      precacheImage(_bg, context);
    }
  }

  static const int numPhases = 7;

  // int get current => _current;
  int get current => widget.firstPage;

  Sections get mySection => Sections.values[Sections.Proc0.index + current];

  void nextPage() {
    scrollToPage(Sections.values[Sections.Proc0.index + current + 1]);
  }

  void navToPage(int page) {
    if (page != current) {
      scrollToPage(Sections.values[Sections.Proc0.index + page]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(k),
        child: VisWrapper(
            section: mySection,
            child: LayoutBuilder(builder: (c, cnt) {
              if (cnt.maxWidth > 1000) {
                return wideView(context);
              } else if (cnt.maxWidth > 650) {
                return midView();
              } else if (cnt.maxWidth > tinyWidth) {
                return topTabsView();
              } else if (cnt.maxWidth > watchSize) {
                return tinyTabsView();
              } else {
                return watchView();
              }
            })));
  }

  Widget crossFadeImg() {
    return fadeProviderBg(_bg);
  }

  Widget parallaxImage(BuildContext context) {
    return ParallaxImage(
      key: const Key('process_parallax'),
      image: 'card_bgs/${cardBgs[current]}',
      opacity: .5,
      distance: 1.2,
    );
  }

  Widget paraStack(BuildContext context, Widget child) {
    return Stack(
        fit: StackFit.passthrough,
        alignment: Alignment.center,
        children: [
          Positioned.fill(child: parallaxImage(context)),
          AppBarPad(child: child)
        ]);
  }

  Widget wideView(BuildContext context) {
    //525 = 7 elements x 75 pixels, that 75 height is totally unchangeable
    const double height = 500;
    return Container(
        width: Device.width,
        height: Device.height,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Center(
            child: GestureDetector(
                onTap: nextPage,
                child: paraStack(
                    context, wideViewContent(height, processWidth - 50 * 2)))));
  }

  Widget midView() {
    //525 = 7 elements x 75 pixels, that 75 height is totally unchangeable
    const double height = 500;
    return Container(
        width: Device.width,
        height: height,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: GestureDetector(
            onTap: nextPage,
            child: paraStack(
                context, wideViewContent(height, processWidth - 50 * 2))));
  }

  Widget wideViewContent(double height, double maxWidth) {
    return SizedBox.expand(
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
          sideBar(context),
          Expanded(
            child: contentPanel(context),
          ),
          const SizedBox(width: 100),
        ]));
    return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // sectionHeaderNoSliverOrPadding('Process'),
          Expanded(
              child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                sideBar(context),
                Expanded(
                  child: contentPanel(context),
                ),
              ])),
          // divider()
          const SizedBox(
            height: 30,
            // width: 1,
          ),
        ]);
  }

  Widget topTabsView() {
    const double hrailHeight = 60;
    return Container(
        height: Device.isLandscapeMobile ? Device.height - appBar : 500,
        width: Device.width,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Stack(alignment: Alignment.bottomLeft, children: [
          GestureDetector(
              onTap: nextPage,
              child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: getBg(),
                          opacity: imgOpacity,
                          fit: BoxFit.cover)),
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: hrailHeight),
                        Expanded(
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 45, vertical: 15),
                                child: contentSwitcher(context, 0)))
                      ]))),
          SizedBox(
              height: hrailHeight,
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: const EdgeInsets.only(left: k * 3),
                      child: bottomRail(context)))),
        ]));
  }

  Widget tinyTabsView() {
    const double hrailHeight = 60;
    return Container(
        height: Device.height,
        width: Device.width,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Stack(alignment: Alignment.topCenter, children: [
          GestureDetector(
              onTap: nextPage,
              child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: getBg(),
                          opacity: imgOpacity,
                          fit: BoxFit.cover)),
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: hrailHeight + appBar),
                        Expanded(
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 0),
                                child: contentSwitcher(context, 0)))
                      ]))),
          AppBarPad(
              child: SizedBox(
            height: hrailHeight,
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: totalTextMargin),
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    // padding:
                    //     const EdgeInsets.symmetric(horizontal: totalTextMargin),
                    semanticChildCount: numPhases,
                    children: _bottomRailList())),
          )),
        ]));
  }

  Widget watchView() {
    return Container(
        constraints: const BoxConstraints(minHeight: 150),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),

        // margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: getBg(), opacity: imgOpacity, fit: BoxFit.cover)),
        color: Theme.of(context).scaffoldBackgroundColor,
        child: contentSwitcher(context, 1));
  }

  Widget contentPanel(BuildContext context) {
    return buildAnimatedSwitcher(context);
  }

  AnimatedSwitcher buildAnimatedSwitcher(BuildContext context) {
    return AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        transitionBuilder: (Widget child, Animation<double> animation) {
          final offsetAnimation = Tween<Offset>(
                  begin: const Offset(.05, 0.0), end: const Offset(0.0, 0.0))
              .chain(CurveTween(curve: Curves.easeIn))
              .animate(animation);
          if (child.key == ValueKey<int>(current)) {
            return SlideTransition(
                position: offsetAnimation,
                child: FadeTransition(opacity: animation, child: child));
          } else {
            final dubAnimation = TweenSequence<double>([
              TweenSequenceItem(tween: ConstantTween<double>(0), weight: 1),
              TweenSequenceItem(
                  tween: Tween<double>(begin: 0, end: 1)
                      .chain(CurveTween(curve: Curves.easeIn)),
                  weight: 1),
            ]).animate(animation);
            return FadeTransition(opacity: dubAnimation, child: child);
          }
        },
        child: contentSwitcher(context, 0));
  }

  Widget textColumn(ProcessStage stage, {bool bounded = true}) {
    return SizedBox(
        width: bounded ? 300 : null,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                stage.headline,
                style: fonts.titleLarge,
              ),
              // const SizedBox(height: 15),
              paraMed(stage.body),
              // const Padding(padding: EdgeInsets.only(top: 15)),
            ]));
  }

  Widget watchTextColumn(ProcessStage stage, {bool bounded = true}) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            stage.headline,
            style: fonts.titleLarge,
          ),
          paraMed(stage.body),
        ]);
  }

  NavigationRailDestination rail(String label, IconData icon) {
    return NavigationRailDestination(
        icon: Icon(icon),
        // padding: EdgeInsets.all(10),
        label: Text(label, style: fonts.labelMedium));
  }

  Widget sideBar(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(15),
        child: NavigationRail(
          // elevation: 5,

          backgroundColor: Colors.transparent,
          // indicatorColor: colorScheme.primary?.withAlpha(100),
          extended: Device.width > 910,
          minExtendedWidth: 180,
          // labelType: NavigationRailLabelType.all,
          groupAlignment: 0,
          selectedIndex: current,
          onDestinationSelected: navToPage,
          destinations: [
            rail('Quote', MdiIcons.fileDocument),
            rail('Planning', MdiIcons.imageFilterHdr),
            rail('Mockups', MdiIcons.applicationEdit), //pencilBox
            rail('Develop', MdiIcons.applicationBraces),
            rail('Sugarcoat', MdiIcons.star), //crown, heart
            rail('Test', MdiIcons.desktopTower), //bug
            rail('Release', MdiIcons.rocketLaunch),
          ],
        ));
  }

  Widget hrail(int index, String label, IconData icon) {
    return IconButton(
      isSelected: current == index,
      icon: Icon(
        icon,
        // color: ((pageController.page?.toInt() ?? -1) == index)
        //     ? colorScheme.primary
        //     : colorScheme.onBackground),
      ),
      onPressed: () {
        navToPage(index);
      },
      // padding: EdgeInsets.all(10),
      // label: Text(label, style: fonts.labelMedium)
    );
  }

  List<Widget> _bottomRailList() {
    return [
      hrail(0, 'Quote', MdiIcons.fileDocument),
      hrail(1, 'Planning', MdiIcons.imageFilterHdr),
      hrail(2, 'Mockups', MdiIcons.applicationEdit), //pencilBox
      hrail(3, 'Develop', MdiIcons.applicationBraces),
      hrail(4, 'Sugarcoat', MdiIcons.star), //crown, heart
      hrail(5, 'Test', MdiIcons.desktopTower), //bug
      hrail(6, 'Release', MdiIcons.rocketLaunch),
    ];
  }

  Widget bottomRail(BuildContext context) {
    return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _bottomRailList());
  }

  Widget contentN(BuildContext context, int styleNo) {
    if (styleNo == 0) {
      return Align(
          alignment: Alignment.centerLeft,
          child: Padding(
              padding: const EdgeInsets.all(15),
              child: textColumn(Stages[current], bounded: false)));
    } else {
      return watchTextColumn(Stages[current], bounded: false);
    }
  }

  Widget contentSwitcher(BuildContext context, int styleNo) {
    return contentN(context, styleNo);
  }
}
