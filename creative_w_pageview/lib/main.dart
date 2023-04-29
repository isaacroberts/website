// import 'dart:html';

import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:device_preview/device_preview.dart';
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
  Key? scrollKey(Sections s) {
    return null;
  }

  PageController pageController = PageController();

  @override
  void initState() {
    globalPageController = pageController;
    super.initState();
  }

  @override
  void dispose() {
    if (globalPageController == pageController) {
      globalPageController = null;
    } else {
      if (kDebugMode) {
        log('globalPageController is not mine');
        assert(false);
      }
    }
    super.dispose();
  }

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
      appBar: TypingAppBar(pageController: pageController),
      extendBodyBehindAppBar: true,
      body: PageView(
        allowImplicitScrolling: true,
        physics: const PageScrollPhysics(),
        controller: pageController,
        scrollDirection: Axis.vertical,
        onPageChanged: onPageChanged,
        children: [
          const Header(),
          const ProcessSidebar(),
          const GPTShower(true),
          const DataVis(true, key: Key('datavis')),
          const AnimationShower(true, key: Key('anim')),
          //TODO: Move this to own widget so it can reset after page changes
          CustomScrollView(
              // physics: const RangeMaintainingScrollPhysics(),
              slivers: const [
                SliverToBoxAdapter(child: ExperienceWidget(0, key: Key('0'))),
                SliverToBoxAdapter(child: ExperienceWidget(1, key: Key('1'))),
                SliverToBoxAdapter(child: ExperienceWidget(2, key: Key('2'))),
                SliverToBoxAdapter(child: SizedBox(height: 90)),
              ]),
          const SignupForm(),
        ],
      ),
      floatingActionButton: fabSwitcher(context, false),
      drawer: const CustomDrawer(),
    );
  }
}
