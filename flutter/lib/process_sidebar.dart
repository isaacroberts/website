// import 'dart:html';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_fade/image_fade.dart';
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

const bool putSectionHeaderInside = false;

List<String> cardBgs = [
  //Quote
  'headway-5QgIuuBxKwM-unsplash.jpg',
  //Planning
  'planning.jpg',
  //Mockups
  'mockups.jpg',
  //Develop
  'hunter-haley-s8OO2-t-HmQ-unsplash.jpg',
  //Sugarcoat
  'mika-baumeister-_Xesb_PEygM-unsplash.jpg',
  //Test
  'moritz-mentges-XZuqMUiSdgc-unsplash.jpg',
  //Release
  'spacex--p-KCm6xB9I-unsplash.jpg',
];

class ProcessSidebar extends StatefulWidget {
  const ProcessSidebar({Key? key}) : super(key: key);

  @override
  State<ProcessSidebar> createState() => _ProcessSidebarState();
}

const double imgOpacity = 1;
const Color imgOverlayColor = canvasColor;

class _ProcessSidebarState extends State<ProcessSidebar> {
  int _current = 0;

  final List<NetworkImage> _bgs = [];

  _ProcessSidebarState() : pageController = PageController() {
    pageController.addListener(updateCurrentFromPage);
  }

  ImageProvider<Object> getBg(int ix) {
    if (kIsWeb) {
      return _bgs[ix];
    } else {
      return assetProvider('card_bgs/${cardBgs[ix]}');
    }
  }

  @override
  void initState() {
    if (kIsWeb) {
      for (int n = 0; n < cardBgs.length; ++n) {
        _bgs.add(NetworkImage('assets/card_bgs/${cardBgs[n]}'));
      }
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (kIsWeb) {
      for (int n = 0; n < _bgs.length; ++n) {
        precacheImage(_bgs[n], context);
      }
      // log('precached');
    }
  }

  static const int numPhases = 7;

  int get current => _current;
  set current(int n) {
    if (_current != n) {
      setState(() {
        _current = n;
        if (pageController.hasClients) {
          pageController.jumpToPage(n);
        }
      });
    }
  }

  void nextTab() {
    current = (current + 1) % numPhases;
  }

  void nextPage() {
    if ((pageController.page?.round() ?? 0) >= numPhases - 1) {
      pageController.animateTo(0,
          duration: const Duration(milliseconds: 500), curve: Curves.ease);
    } else {
      pageController.nextPage(
          duration: const Duration(milliseconds: 420), curve: Curves.ease);
    }
  }

  void setPage(int n) {
    if (pageController.hasClients) {
      pageController.animateToPage(n,
          duration: const Duration(milliseconds: 500), curve: Curves.ease);
    }
    setState(() {
      _current = n;
    });
  }

  void updateCurrentFromPage() {
    if (pageController.page != null) {
      if (_current != (pageController.page?.toInt() ?? 0)) {
        setState(() {
          _current = pageController.page!.toInt();
        });
      }
    }
  }

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    // return LockScrollSliver(
    //     child: Padding(
    //         padding: const EdgeInsets.only(top: 60),
    //         child: LayoutBuilder(
    //           builder: (context, constraints) {
    //             if (Device.width > 600) {
    //               return horizView();
    //             } else {
    //               return horizViewPhone();
    //             }
    //           },
    //         )));

    if (Device.isDesktop || Device.isTablet) {
      return SliverToBoxAdapter(child: LayoutBuilder(builder: (c, cnt) {
        if (cnt.maxWidth > 1000) {
          return wideView();
        } else if (cnt.maxWidth > 700) {
          return midView();
        } else if (cnt.maxWidth > tinyWidth) {
          return topTabsView();
        } else if (cnt.maxWidth > watchSize) {
          return tinyTabsView();
        } else {
          return watchView();
        }
      }));
    }
    // else if (Device.isPhoneLand) {
    //   return sliverView();
    // }
    else {
      return SliverToBoxAdapter(child: topTabsView());
    }
  }

  Widget crossFadeImg() {
    // return const SizedBox.shrink();
    return ImageFade(
      // whenever the image changes, it will be loaded, and then faded in:
      image: getBg(current),

      // slow fade for newly loaded images:
      duration: const Duration(milliseconds: 300),

      // if the image is loaded synchronously (ex. from memory), fade in faster:
      syncDuration: const Duration(milliseconds: 150),

      // supports most properties of Image:
      alignment: Alignment.center,
      fit: BoxFit.cover,

      // shown behind everything:
      placeholder: const SizedBox.shrink(),

      // shows progress while loading an image:
      loadingBuilder: (context, progress, chunkEvent) =>
          Center(child: CircularProgressIndicator(value: progress)),

      // displayed when an error occurs:
      // errorBuilder: (context, error) => Container(
      //   color: Grayscale.shade800,
      //   alignment: Alignment.center,
      //   child: const Icon(Icons.warning, color: Colors.black26, size: 128.0),
      // ),
    );
  }

  Widget pageScrolledImage() {
    return PageView.builder(
        controller: pageController,
        itemBuilder: (context, index) {
          return Image(
              image: getBg(index),
              opacity: const AlwaysStoppedAnimation<double>(imgOpacity),
              color: imgOverlayColor,
              fit: BoxFit.cover);
        });
  }

  Widget wideView() {
    //525 = 7 elements x 75 pixels, that 75 height is totally unchangeable
    const double height = 700;
    return Container(
        margin: EdgeInsets.zero,
        alignment: Alignment.center,
        height: height,
        // clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/white_desk.jpg'),
                fit: BoxFit.cover)),
        child: GestureDetector(
            onTap: nextTab,
            child: Center(
                child: SizedBox(
                    width: processWidth,
                    height: height,
                    child: wideViewContent(height, processWidth - 50 * 2)))

            // child: Stack(
            //     fit: StackFit.expand,
            //     alignment: Alignment.center,
            //     children: [
            //   // Positioned.fill(child: Container(color: imgOverlayColor)),
            //   Positioned.fill(
            //       child:
            //           Opacity(opacity: imgOpacity, child: crossFadeImg())),
            //   Center(
            //       child: SizedBox(
            //           width: processWidth,
            //           height: height,
            //           child:
            //               wideViewContent(height, processWidth - 50 * 2)))
            // ]))
            ));
  }

  Widget midView() {
    //525 = 7 elements x 75 pixels, that 75 height is totally unchangeable
    const double height = 500;
    const double maxWidth = 1000;
    return Container(
        height: height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/white_desk.jpg'),
                fit: BoxFit.cover)),
        child: GestureDetector(
            onTap: nextTab,
            child: Center(child: wideViewContent(height, maxWidth - 50 * 2))));

    // child: GestureDetector(
    //     onTap: nextTab,
    //     child: Stack(
    //         fit: StackFit.expand,
    //         alignment: Alignment.center,
    //         children: [
    //           Positioned.fill(child: Container(color: imgOverlayColor)),
    //           Positioned.fill(
    //               child:
    //                   Opacity(opacity: imgOpacity, child: crossFadeImg())),
    //           wideViewContent(height, maxWidth - 50 * 2)
    //         ])));
  }

  Widget wideViewContent(double height, double maxWidth) {
    return Column(
        mainAxisSize: MainAxisSize.max,
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sectionHeaderNoSliverOrPadding('Process'),
          Expanded(
              child: Center(
                  // child: Card(
                  //     color: theme.cardColor.withOpacity(.8),
                  child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                sideBar(context),
                Expanded(
                  child: contentPanel(context),
                ),
                const SizedBox(width: k * 10),
              ]))),
          // divider()
          const SizedBox(
            height: 30,
            // width: 1,
          ),
        ]);
  }

  Widget topTabsView() {
    const double hrailHeight = 60;
    return SizedBox(
        height: Device.isLandscapeMobile ? Device.height - appBar : 500,
        width: Device.width,
        child: Stack(alignment: Alignment.topCenter, children: [
          Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/white_desk.jpg'),
                      fit: BoxFit.cover))),
          PageView.builder(
              controller: pageController,
              physics: const BouncingScrollPhysics(),
              itemCount: numPhases,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: nextPage,
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
                                  child: contentSwitcher(context, 0,
                                      value: index)))
                        ]));
              }),
          SizedBox(
              height: hrailHeight,
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: bottomRail(context))),
        ]));
  }

  Widget tinyTabsView() {
    const double hrailHeight = 60;
    return SizedBox(
        height: Device.height - appBar,
        width: Device.width,
        child: Stack(alignment: Alignment.topCenter, children: [
          PageView.builder(
              controller: pageController,
              itemCount: numPhases,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: nextPage,
                    child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: hrailHeight),
                          Expanded(
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 0),
                                  child: SingleChildScrollView(
                                      child: contentSwitcher(context, 0,
                                          value: index))))
                        ]));
              }),
          SizedBox(
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
          )
        ]));
  }

  Widget watchView() {
    return Container(
        constraints: const BoxConstraints(minHeight: 150),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        // margin: const EdgeInsets.only(bottom: 15),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/white_desk.jpg'),
                fit: BoxFit.cover)),
        child: Column(children: [
          for (int index = 0; index < numPhases; ++index)
            Padding(
                padding: const EdgeInsets.only(bottom: k),
                child: contentSwitcher(context, 1, value: index))
        ]));
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

  Widget textColumn(int ix, String headline, String body,
      {bool bounded = true}) {
    return SizedBox(
        width: bounded ? 300 : null,
        child: Column(
            key: Key(ix.toString()),
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                headline,
                style: fonts.headlineSmall,
              ),
              const SizedBox(height: 15),
              paraMed(body),
              // const Padding(padding: EdgeInsets.only(top: 15)),
            ]));
  }

  Widget watchTextColumn(int ix, String headline, String body,
      {bool bounded = true}) {
    return Column(
        key: Key(ix.toString()),
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            headline,
            style: fonts.headlineSmall,
          ),
          paraMed(body),
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
          extended: false && Device.width > 910,
          minExtendedWidth: 180,
          groupAlignment: 0,
          // labelType: NavigationRailLabelType.all,
          selectedIndex: current,
          onDestinationSelected: (i) => current = i,
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
        setPage(index);
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
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _bottomRailList());
  }

  Widget contentN(
      BuildContext context, int styleNo, String headline, String body, int ix,
      {required String svg,
      required UnDrawIllustration undraw,
      bool imgOnMobile = true}) {
    if (styleNo == 0) {
      return Align(
          key: ValueKey<int>(ix),
          alignment: Alignment.centerLeft,
          child: Padding(
              padding: const EdgeInsets.all(15),
              child: textColumn(ix, headline, body, bounded: false)));
    } else {
      return watchTextColumn(ix, headline, body, bounded: false);
    }
  }

  Widget contentSwitcher(BuildContext context, int styleNo, {int? value}) {
    value ??= current;
    switch (value) {
      case 0:
        return contentN(
            context,
            styleNo,
            'Requirements gathering',
            """
In the requirements gathering phase we will work closely to understand your business needs and objectives, and to identify the key features and functionality that your app should have. 
The end result of this phase will be a detailed set of requirements that will serve as the foundation for the rest of the project. """

            // "We discuss what features you need, what users will be doing, and how in general the app should be built.",
            ,
            value,
            undraw: UnDrawIllustration.business_chat,
            svg: 'business_chat');

      case 1:
        return contentN(
            context,
            styleNo,
            'User story',
            """
I work with you to come up with a User Story, determining how the user will use the app, their goals, the pathway to those goals, and the way you want them to go about those goals. 
"I will use this information to create a detailed and user-centered design that will help your app achieve its goals and provide a great user experience.""",
            value,
            undraw: UnDrawIllustration.user_flow,
            svg: 'user_flow',
            imgOnMobile: false); //journey, user_flow

      case 2:
        return contentN(
            context,
            styleNo,
            'Mockup',
            """
The mockup phase is where we take the ideas and requirements from the previous phases and turn them into a visual representation of the app.
This typically involves creating wireframes or prototypes that show the basic structure and layout of the app, as well as how the different screens and features will work together. 
            """,
            value,
            undraw: UnDrawIllustration.prototyping_process,
            svg: 'prototyping_process');

      case 3:
        return contentN(
            context,
            styleNo,
            'Development',
            """
Once the mockups have been approved, it's time to start development. 
Throughout development, I will keep you informed of the app's progress and address any issues that arise. When the app is ready, I will deliver it to you for review and preliminary testing.
            """,
            value,
            undraw: UnDrawIllustration.project_complete,
            svg: 'project_complete'); //programming

      case 4:
        return contentN(
            context,
            styleNo,
            'Sugarcoating',
            """
The sugarcoating phase is where I add the finishing touches to the app, making it more engaging and user-friendly. This involves styling, adding effects, animations, and other visual flourishes.
""",
            value,
            undraw: UnDrawIllustration.progressive_app,
            svg: 'progressive_app'); //product_photography

      case 5:
        return contentN(
            context,
            styleNo,
            'Automated testing',
            """
During this phase, I will use automated and manual testing to uncover bugs, issues, and inconsistencies in the app. 
The goal of testing is to identify and fix any problems with the app before it is released to the public, ensuring that it performs well and meets the standards I have set for my work.
            """,
            value,
            undraw: UnDrawIllustration.programmer,
            svg: 'programmer');

      case 6:
        return contentN(context, styleNo, 'Launch',
            "The app is ready! Go get out there!", value,
            undraw: UnDrawIllustration.outer_space, svg: 'outer_space');

      default:
        return const Center(child: Text("Content OOB"));
    }
  }
}
