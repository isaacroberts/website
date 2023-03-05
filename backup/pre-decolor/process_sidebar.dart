import 'package:flutter/material.dart';
import 'package:website/text_theme.dart';
import 'theme.dart';
import 'common_elements.dart';
import 'dart:math' as math;
import 'package:ms_undraw/ms_undraw.dart';
import 'dart:developer';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'device.dart';
import 'package:fluttericon/zocial_icons.dart';

const bool putSectionHeaderInside = false;

class ProcessSidebar extends StatefulWidget {
  const ProcessSidebar({Key? key}) : super(key: key);

  @override
  State<ProcessSidebar> createState() => _ProcessSidebarState();
}

class _ProcessSidebarState extends State<ProcessSidebar> {
  int _current = 0;
  _ProcessSidebarState() : pageController = PageController() {}

  static const int numPhases = 7;

  int get current => _current;
  set current(int n) {
    setState(() {
      _current = n;
    });
  }

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    if (Device.isDesktop || Device.isTablet) {
      return SliverToBoxAdapter(child: wideView());
    }
    // else if (Device.isPhoneLand) {
    //   return sliverView();
    // }
    else {
      return phoneView();
    }
  }

  Widget wideView() {
    return OrientationBuilder(builder: (context, orientation) {
      //525 = 7 elements x 75 pixels, that 75 height is totally unchangeable
      double height = Device.select(def: 525, phoneLand: 400);
      return Container(
          decoration: gradient(GradientStop.Process),
          child: Card(
              // color: Colors.transparent,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SizedBox(
                  height: height,
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    sideBar(context),
                    Expanded(
                        child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 60, horizontal: 15),
                      child: contentPanel(context),
                    )),
                  ]))));
    });
  }

  void nextPage() {
    pageController.nextPage(
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  Widget sliverView() {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        return OrientationBuilder(builder: (context, orientation) {
          return SelectionArea(
              child: Container(
                  height: Device.height - (Device.isLandscape ? 0 : 100),
                  decoration: gradient(GradientStop.Process),
                  child: GestureDetector(
                      onTap: () => nextPage(),
                      child: Card(
                          margin: EdgeInsets.symmetric(
                              vertical: (Device.isLandscape ? 5 : 10),
                              horizontal: (Device.isLandscape ? 10 : 5)),
                          child: Padding(
                              padding: const EdgeInsets.all(30),
                              child:
                                  contentSwitcher(context, value: index))))));
        });
      },
      childCount: numPhases,
    ));
  }

  Widget phoneView() {
    // pageController.createScrollPosition(, context, oldPosition)

    return SliverToBoxAdapter(
        child: OrientationBuilder(builder: (context, orientation) {
      return Container(
          decoration: gradient(GradientStop.Process),
          height: Device.height - (Device.isLandscape ? 0 : 100),
          child: PageView.builder(
              physics: const ClampingScrollPhysics(),
              controller: pageController,
              scrollDirection:
                  Device.isLandscape ? Axis.vertical : Axis.horizontal,
              itemCount: numPhases,
              // itemExtent: Device.width,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () => nextPage(),
                    child: Card(
                        margin: EdgeInsets.symmetric(
                            vertical: (Device.isLandscape ? 5 : 10),
                            horizontal: (Device.isLandscape ? 10 : 5)),
                        child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: contentSwitcher(context, value: index))));
              }));
    }));
  }

  Column contentPanel(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (putSectionHeaderInside)
            Text(
              'Process',
              style: fonts.headlineLarge,
              textAlign: TextAlign.left,
            ),
          const Padding(
              padding: EdgeInsets.only(top: putSectionHeaderInside ? 15 : 0)),
          Expanded(child: buildAnimatedSwitcher(context))
        ]);
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
        child: contentSwitcher(context));
  }

  Widget contentNDesktop(
      BuildContext context, String headline, String body, int ix,
      {required String svg,
      required UnDrawIllustration undraw,
      bool imgOnMobile = true}) {
    return SelectionArea(
        key: ValueKey<int>(ix),
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  // child: Card(
                  //     color: Colors.white,
                  child: textColumn(ix, headline, body)),

              Flexible(
                  // child: Padding(
                  //     padding: const EdgeInsets.all(45),
                  child: undrawImage(svg, undraw, true))
              // const Padding(padding: EdgeInsets.only(right: 60)),
            ]));
  }

  Widget contentNPhone(
      BuildContext context, String headline, String body, int ix,
      {required String svg,
      required UnDrawIllustration undraw,
      bool imgOnMobile = true}) {
    // return textColumn(ix, headline, body);
    if (Device.isPortrait) {
      return Column(
          key: ValueKey<int>(ix),
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textColumn(ix, headline, body),
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: undrawImage(svg, undraw, true)))
            // const Padding(padding: EdgeInsets.only(right: 60)),
          ]);
    } else {
      return Row(
          key: ValueKey<int>(ix),
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                // child: Card(
                //     color: Colors.white,
                child: textColumn(ix, headline, body)),

            Flexible(
                child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: undrawImage(svg, undraw, true)))
            // const Padding(padding: EdgeInsets.only(right: 60)),
          ]);
    }
  }
  //
  // Widget contentNPhonePort(
  //     BuildContext context, String headline, String body, int ix,
  //     {required String svg,
  //     required UnDrawIllustration undraw,
  //     bool imgOnMobile = true}) {
  //   // imgOnMobile = true;
  //   return SizedBox(
  //       height: Device.height,
  //       child: Column(
  //           mainAxisSize: MainAxisSize.max,
  //           mainAxisAlignment: MainAxisAlignment.spaceAround,
  //           crossAxisAlignment: CrossAxisAlignment.stretch,
  //           children: [
  //             Expanded(child: textColumn(ix, headline, body)),
  //             Flexible(child: undrawImage(svg, undraw, false)),
  //           ]));
  // }

  // Widget contentNPhonePort(
  //     BuildContext context, String headline, String body, int ix,
  //     {required String svg,
  //     required UnDrawIllustration undraw,
  //     bool imgOnMobile = true}) {
  //   // imgOnMobile = true;
  //   return SizedBox(
  //       height: Device.height,
  //       child: Stack(
  //           // mainAxisSize: MainAxisSize.max,
  //           // mainAxisAlignment: MainAxisAlignment.spaceAround,
  //           // crossAxisAlignment: CrossAxisAlignment.stretch,
  //           children: [
  //             Opacity(opacity: .1, child: undrawImage(svg, undraw, false)),
  //             textColumn(ix, headline, body),
  //           ]));
  // }

  Widget undrawImage(String svg, UnDrawIllustration undraw, bool horiz) {
    return Padding(
        padding: EdgeInsets.symmetric(
            vertical: Device.isPhone ? 0 : 0,
            horizontal: Device.isPhonePort ? 0 : 15),
        child: LayoutBuilder(
            key: ValueKey<String>(svg),
            builder: (context, constraints) {
              double udS = math.min(
                  200,
                  math.min(
                      constraints.maxWidth,
                      constraints
                          .maxHeight)); //Device.select(def: 200, phoneLand: 200);

              // return SvgPicture.asset(
              //   'assets/undraw/${svg}.svg',
              //   width: constraints.maxWidth,
              //   height: constraints.maxHeight,
              // );

              return UnDraw(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  illustration: undraw,
                  color: colorScheme.primary ?? Colors.blue);
            }));
  }

  Column textColumn(int ix, String headline, String body) {
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
          const Padding(padding: EdgeInsets.only(top: 15)),
          paragraph(body),
          // const Padding(padding: EdgeInsets.only(top: 15)),
        ]);
  }

  NavigationRailDestination rail(String label, IconData icon) {
    return NavigationRailDestination(
        icon: Icon(icon),
        // padding: EdgeInsets.all(10),
        label: Text(label, style: fonts.labelMedium));
  }

  Widget sideBar(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return SingleChildScrollView(
          child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: IntrinsicHeight(
                  child: NavigationRail(
                backgroundColor: Colors.transparent,
                // indicatorColor: colorScheme.primary?.withAlpha(100),
                extended: Device.isDesktop || Device.isTabletLand,
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
              ))));
    });
  }

  Widget contentN(BuildContext context, String headline, String body, int ix,
      {required String svg,
      required UnDrawIllustration undraw,
      bool imgOnMobile = true}) {
    if (Device.isPhone) {
      return contentNPhone(context, headline, body, ix,
          svg: svg, undraw: undraw, imgOnMobile: imgOnMobile);
    } else {
      return contentNDesktop(context, headline, body, ix,
          svg: svg, undraw: undraw);
    }
  }

  Widget contentSwitcher(BuildContext context, {int? value}) {
    value ??= current;
    switch (value) {
      case 0:
        return contentN(
            context,
            'Requirements Gathering',
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
            'User Story',
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
            'Mockup',
            """
The mockup phase is where we take the ideas and requirements from the previous phases and turn them into a visual representation of the app.
This typically involves creating wireframes or prototypes that show the basic structure and layout of the app, as well as how the different screens and features will work together. 
The mockups are not a final design, but rather a way to quickly and easily test and refine the app's overall concept and user flow
            """,
            value,
            undraw: UnDrawIllustration.prototyping_process,
            svg: 'prototyping_process');

      case 3:
        return contentN(
            context,
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
            'Sugarcoating',
            """
The sugarcoating phase is where I add the finishing touches to the app, making it more engaging and user-friendly. This typically involves adding effects, animations, and other visual flourishes that enhance the user experience.
I will also work on improving the app's compatibility with different devices, operating systems, and screen sizes, to ensure that it looks and works great on all devices. By taking the time to carefully polish the app, I can help it stand out from the competition and provide a more engaging experience for your users.""",
            value,
            undraw: UnDrawIllustration.progressive_app,
            svg: 'progressive_app'); //product_photography

      case 5:
        return contentN(
            context,
            'Automated Testing',
            """
The testing phase is an essential step in ensuring that the app is stable, reliable, and easy to use. During this phase, I will use automated and manual testing to uncover bugs, issues, and inconsistencies in the app. 
The goal of testing is to identify and fix any problems with the app before it is released to the public, ensuring that it performs well and meets the standards I have set for my work.
            """,
            value,
            undraw: UnDrawIllustration.programmer,
            svg: 'programmer');

      case 6:
        return contentN(
            context, 'Launch', "The app is ready! Go get out there!", value,
            undraw: UnDrawIllustration.outer_space, svg: 'outer_space');

      default:
        return const Center(child: Text("Content OOB"));
    }
  }
}
