// import 'dart:html';

import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:device_preview/device_preview.dart';
import 'package:get/get.dart';
import 'package:isaac_roberts_consulting/chatgpt/config/pallete.dart';
import 'package:isaac_roberts_consulting/custom_layouts.dart';
import 'package:isaac_roberts_consulting/full_screen_widget.dart';
import 'package:isaac_roberts_consulting/scroll_past.dart';
import 'download_section.dart';
import 'gpt_shower.dart';
import 'signup_form.dart';
import 'text_theme.dart';
import 'trio_bar.dart';
import 'vert_to_horiz_scroll.dart';

import 'animations_shower.dart';
import 'color_switcher.dart';
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

enum Sections { home, process, features, experience, contact }

class _MyHomePageState extends State<MyHomePage> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  void onPageChanged(int page) {}

  @override
  Widget build(BuildContext context) {
    if (!useDevicePreview) {
      Device.updateDeviceRelease(context);
    } else {
      Device.updateDeviceWithPreview(context);
    }
    fonts = Theme.of(context).textTheme;

    return Scaffold(
        appBar: AppBar(title: const Text('//Default')),
        body: Navigator(
          key: _navigatorKey,
          initialRoute: '/',
          onGenerateRoute: _onGenerateRoute,
        ),
        drawer: drawer(context),
        floatingActionButton: fabSwitcher(context, false));
  }

  Widget getPage(String name) {
    switch (name) {
      case '/process':
        return const FullScreenPage(
            nextPage: '/features', child: ProcessSidebar());
      case '/features':
      case '/features/1':
        return FullScreenPage(nextPage: '/features/2', child: GPTShower(true));

        return GPTShower(true);
      case '/features/2':
        return const FullScreenPage(
            nextPage: '/features/3', child: DataVis(true));

        return const DataVis(true);
      case '/features/3':
        return const FullScreenPage(
            nextPage: '/experience', child: AnimationShower(true));

        return const AnimationShower(true);
      case '/experience':
      case '/experience/1':
        return const FullScreenPage(
            nextPage: '/experience/2', child: ExperienceWidget(0));

        return const ExperienceWidget(0);
      case '/experience/2':
        return const FullScreenPage(
            nextPage: '/experience/3', child: ExperienceWidget(1));

        return const ExperienceWidget(1);
      case '/experience/3':
        return const FullScreenPage(
            nextPage: '/contact', child: ExperienceWidget(2));

        return const ExperienceWidget(2);
      case '/contact':
        return const FullScreenPage(nextPage: null, child: SignupForm());

        return const SignupForm();

      case '/':
      case '/header':
      default:
        return const FullScreenPage(nextPage: '/process', child: Header());

        return const Header();
    }
    assert(false);
    return const SizedBox.shrink();
  }

  Route _onGenerateRoute(RouteSettings settings) {
    log('generating route: ${settings.name}');
    Widget page = getPage(settings.name ?? '/');

    return PageRouteBuilder(pageBuilder: (context, anim, secondary) {
      // Animation<Offset> t = anim.drive(Animation(Offset(0, 1)));
      var t = Tween<Offset>(begin: const Offset(0, 1), end: const Offset(0, 0));
      return SlideTransition(position: anim.drive(t), child: page);
    });

    // return MaterialPageRoute<dynamic>(
    //   builder: (context) {
    //     return page;
    //   },
    //   settings: settings,
    // );
  }

  void scrollCallback(Sections sec) {
    scroll(sec.name);
  }

  void scroll(String name) {
    //TODO: Unpop if item exists previously in stack
    // if (name == '') {
    //   log('pop until');
    //   Navigator.of(context).popUntil((route) => route.settings.name == '/');
    // } else {
    Navigator.of(_navigatorKey.currentContext!).pushNamed('/$name');
    // }
    // Navigator.of(context).pushNamed('$name');
  }

  Widget drawer(
    BuildContext context,
  ) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            // padding: EdgeInsets.all(30),
            decoration: const ColoredFlutterLogoDecoration(
              topColor: flutterLogoTop,
              botColor: flutterLogoBot,
              margin: EdgeInsets.all(15),
            ),
            child: Text(
              'Isaac Roberts',
              style: fonts.displaySmall?.copyWith(color: Colors.white),
            ),
          ),
          for (int n = 0; n < Sections.values.length; ++n) drawerListTile(n),
          if (Device.width < (theme.drawerTheme.width ?? 150) + 50)
            TextButton(
                child: const Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
        ],
      ),
    );
  }

  ListTile drawerListTile(int n) {
    return ListTile(
      title: Text(Sections.values[n].name),
      onTap: () {
        scroll(n == 0 ? '' : Sections.values[n].name);

        //This closed the drawer, wait, and then scroll
        // Navigator.of(context).pop();
        // Future.delayed(const Duration(milliseconds: 350), () {
        //        scroll(Sections.values[n].name);
        // });
      },
    );
  }
}
