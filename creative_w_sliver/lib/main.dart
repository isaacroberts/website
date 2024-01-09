// import 'dart:html';

import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:device_preview/device_preview.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:isaac_roberts_consulting/process_single.dart';
import 'package:isaac_roberts_consulting/process_sliver.dart';
import 'package:isaac_roberts_consulting/scrolls_separated.dart';
import 'package:isaac_roberts_consulting/sections.dart';
import 'package:isaac_roberts_consulting/typing_app_bar.dart';
import 'gpt_shower.dart';
import 'signup_form.dart';
import 'text_theme.dart';
import 'trio_bar.dart';

import 'animations_shower.dart';
import 'colorable_flutter_logo.dart';
import 'contact_page.dart';
import 'datavis.dart';
import 'drawer.dart';
import 'footer.dart';
import 'header.dart';
import 'process_sidebar.dart';
import 'theme.dart';
import 'experience.dart';
import 'common_elements.dart';
import 'app_bar.dart';

import 'device.dart';
// import 'package:universal_io/io.dart';
// import 'dart:io';

// import 'package:flutter/widgets.dart';

final bool useDevicePreview = false && kDebugMode && Device.isPhysicalDesktop;

void main() {
  if (useDevicePreview) {
    runApp(DevicePreview(
      storage: DevicePreviewStorage.preferences(),
      enabled: true,
      builder: (context) => const MyApp(),
    ));
  } else {
    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // startupPrint();
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > watchSize) {
        return MaterialApp(
          key: const Key('stdApp'),
          useInheritedMediaQuery: useDevicePreview,
          locale: useDevicePreview ? DevicePreview.locale(context) : null,
          builder: useDevicePreview ? DevicePreview.appBuilder : null,
          debugShowCheckedModeBanner: false,
          title: 'Isaac - App Dev',
          theme: lightTheme,
          darkTheme: theme,
          // darkTheme: ,
          home: const MyHomePage(),
        );
      } else {
        return MaterialApp(
          key: const Key('watchApp'),
          useInheritedMediaQuery: useDevicePreview,
          locale: useDevicePreview ? DevicePreview.locale(context) : null,
          builder: useDevicePreview ? DevicePreview.appBuilder : null,
          debugShowCheckedModeBanner: false,
          title: 'Isaac - App Dev',
          theme: theme.copyWith(textTheme: watchFonts),
          home: const MyHomePage(),
        );
      }
    });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // PageController pageController = PageController();
  late ScrollController controller;
  int page = 0;
  @override
  void initState() {
    controller = ScrollController();
    controller.addListener(_controllerChanged);
    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(_controllerChanged);
    controller.dispose();

    super.dispose();
  }

  void _controllerChanged() {}
  void _pageChanged() {}

  void onPageChanged(int page) {
    if (page == 0) {
      appBarTitle.title = '//${pageTitles[0]}';
    } else {
      appBarTitle.title = '//${pageTitles[page]}:';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!useDevicePreview) {
      Device.updateDeviceRelease(context);
    } else {
      Device.updateDeviceWithPreview(context);
    }
    fonts = Theme.of(context).textTheme;

    return Scaffold(
      appBar: const TypingAppBar(),
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        // physics: const PageScrollPhysics(),
        // controller: controller,
        scrollDirection: Axis.vertical,
        reverse: false,
        slivers: [
          const ScrollMarker(Sections.Home),
          const PageSliverWrap(key: Key('home'), child: Header()),
          const ScrollMarker(Sections.Process),

          for (int n = 0; n < Stages.length; ++n)
            ProcessSliver(
                key: scrollTos[Sections.Proc0.index + n],
                child: ProcessSingle(
                  n,
                )),

          const ScrollMarker(Sections.Features),

          PageSliverWrap(
              key: scrollTos[Sections.FeatGPT.index],
              child: const GPTShower(true, key: Key('gpt_el'))),

          PageSliverWrap(
              key: scrollTos[Sections.FeatData.index],
              child: const DataVis(true, key: Key('datavis+el'))),

          PageSliverWrap(
              key: scrollTos[Sections.FeatAnim.index],
              child: const AnimationShower(true, key: Key('anim_el'))),

          const ScrollMarker(Sections.Experience),

          //TODO: Move this to own widget so it can reset after page changes
          const SliverToBoxAdapter(
              key: Key('experience'),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                ExperienceWidget(0, key: Key('exp_0')),
                ExperienceWidget(1, key: Key('exp_1')),
                ExperienceWidget(2, key: Key('exp_2')),
                SizedBox(height: 90),
              ])),
          // const PageSliverWrap(isLast: false, child: SignupForm()),

          const ScrollMarker(Sections.Contact),

          const SignupSliver(key: Key('signup'), child: SignupForm()),
          Footer.sliver()
        ],
        // isInViewPortCondition:
        //     (double deltaTop, double deltaBottom, double viewPortDimension) {
        //   // return deltaTop > 0 && (viewPortDimension - deltaBottom) > 0;
        //
        //   //returns true when the middle is visible
        //   return deltaTop < (0.5 * viewPortDimension) &&
        //       deltaBottom > (0.5 * viewPortDimension);
        // },
      ),
      floatingActionButton: fabSwitcher(context, false),
      drawer: const CustomDrawer(),
    );
  }

  void scrollCallback(Sections sec) {
    scroll(scrollTos[sec.index]);
  }

  void scroll(GlobalKey scrollTo) {
    BuildContext? ct = scrollTo.currentContext;
    if (ct != null) {
      Scrollable.ensureVisible(ct,
          duration: const Duration(milliseconds: 750), curve: Curves.ease);
    }
  }
}
