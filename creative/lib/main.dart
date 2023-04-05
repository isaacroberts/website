// import 'dart:html';

import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:device_preview/device_preview.dart';
import 'package:isaac_roberts_consulting/chatgpt/config/pallete.dart';
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

enum Sections { Home, Process, Features, Experience, Contact }

class ScrollTo extends LabeledGlobalKey {
  final String name;
  ScrollTo(this.name) : super(name);
  ScrollTo.fromSection(Sections s)
      : name = s.name,
        super(s.name);
}

class _MyHomePageState extends State<MyHomePage> {
  final List<ScrollTo> scrollTos = [
    for (int n = 0; n < Sections.values.length; ++n)
      ScrollTo.fromSection(Sections.values[n])
  ];

  ScrollTo scrollKey(Sections s) {
    return scrollTos[s.index];
  }

  var controller = FixedExtentScrollController();

  @override
  Widget build(BuildContext context) {
    if (!useDevicePreview) {
      Device.updateDeviceRelease(context);
    } else {
      Device.updateDeviceWithPreview(context);
    }
    fonts = Theme.of(context).textTheme;

    // log('root update');

    return Scaffold(
        body: CustomScrollView(
          // anchor: .33,
          slivers: [
            buildAppBar(context, scrollCallback),
            Header(
                scrollTo: scrollKey(Sections.Process),
                key: scrollKey(Sections.Home)),
            trioSliver(context),
            //Header only if process section needs it
            // SliverToBoxAdapter(
            //     child: LayoutBuilder(builder: (context, constraints) {
            //   if (constraints.maxWidth <= watchSize) {
            //     return sectionHeaderNoSliver('Process');
            //   } else {
            //     return const SizedBox.shrink();
            //   }
            // })),
            sectionHeader(context, 'Process', key: scrollKey(Sections.Process)),
            const ProcessSidebar(),
            // SliverToBoxAdapter(
            //     child: SizedBox(
            //         height: Device.height,
            //         child: ParallaxImage(
            //             image: 'images/bg_field.jpg', debugLabel: 'sky'))),
            sectionHeader(
              context,
              'Features',
              key: scrollKey(Sections.Features),
            ),
            SliverToBoxAdapter(child: GPTShower(true)),
            const SliverToBoxAdapter(child: SizedBox(height: 30)),
            const SliverToBoxAdapter(child: DataVis(true)),
            const SliverToBoxAdapter(child: SizedBox(height: 30)),

            const SliverToBoxAdapter(child: AnimationShower(true)),
            sectionHeader(
              context,
              'Experience',
              key: scrollKey(Sections.Experience),
            ),
            buildExperienceList(context),
            const SliverToBoxAdapter(child: SizedBox(height: 30)
                // child: Container(height: 30, decoration: expGradient(4)),
                ),
            signupFormSliver(key: scrollKey(Sections.Contact)),
            Footer.sliver(),
          ],
        ),
        drawer: drawer(context),
        floatingActionButton: fabSwitcher(context, false));
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
          for (int n = 0; n < scrollTos.length; ++n) drawerListTile(n),
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
      title: Text(scrollTos[n].name),
      onTap: () {
        // if (Device.width < (theme.drawerTheme.width ?? 150) + 50) {
        Navigator.of(context).pop();
        Future.delayed(const Duration(milliseconds: 350), () {
          scroll(scrollTos[n]);
        });
        // } else {
        //   scroll(scrollTos[n]);
        //   Future.delayed(const Duration(milliseconds: 750), () {
        //     if (context.mounted) {
        //       Navigator.of(context).pop();
        //     }
        //   });
        // }
      },
    );
  }
}
