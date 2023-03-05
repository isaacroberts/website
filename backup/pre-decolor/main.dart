// import 'dart:html';

import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:device_preview/device_preview.dart';
import 'package:website/download_section.dart';
import 'package:website/text_theme.dart';
import 'package:website/trio_bar.dart';

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
import 'dart:io';

// import 'package:flutter/widgets.dart';

final bool useDevicePreview = kDebugMode && Device.isPhysicalDesktop;

void main() {
  // imageCache.clear();

  // if (kDebugMode) {
  //   printColors();
  // }
  if (useDevicePreview) {
    runApp(DevicePreview(
      storage: DevicePreviewStorage.preferences(),
      enabled: true,
      builder: (context) => const MyApp(), // Wrap your app
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
    return MaterialApp(
      useInheritedMediaQuery: useDevicePreview,
      locale: useDevicePreview ? DevicePreview.locale(context) : null,
      builder: useDevicePreview ? DevicePreview.appBuilder : null,
      debugShowCheckedModeBanner: false,
      title: 'Isaac Consulting',
      theme: theme,
      // darkTheme: darkTheme(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final GlobalKey scrollKey = GlobalKey();

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (kReleaseMode) {
      Device.updateDeviceRelease(context);
    } else {
      Device.updateDeviceWithPreview(context);
    }

    fonts = Theme.of(context).textTheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          buildAppBar(context),
          // SliverPadding(padding: EdgeInsets.only(top: Device.height - 150)),
          header(context, scrollTo: scrollKey),
          // if (!trioOnHeader)
          //   const SliverPadding(padding: EdgeInsets.only(top: 60)),
          sliverDivider(),
          trioSliver(context),
          // const SliverPadding(padding: EdgeInsets.only(top: 30)),
          sectionHeader(context, 'Process',
              key: scrollKey, color: gradientStop(GradientStop.Process)),
          const ProcessSidebar(),
          sectionHeader(context, 'Experience',
              color: gradientStop(GradientStop.Exp0)),
          buildExperienceList(context),
          sectionHeader(context, 'Download',
              color: gradientStop(GradientStop.Download)),
          DownloadSection.sliver(),
          SliverToBoxAdapter(
              child: Container(
            height: 90,
            // color: gradientStops[6],
            decoration: gradient(GradientStop.BottomSpace),
          )),
          // const SliverPadding(padding: EdgeInsets.symmetric(vertical: 90),),
          Footer.sliver(),
        ],
      ),
      drawer: drawer(context),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Contact',
        child: const Icon(Icons.call_outlined),
      ),
    );
  }
}
