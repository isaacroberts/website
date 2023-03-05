import 'dart:developer';

import 'package:flutter/material.dart';
import 'text_theme.dart';
import 'theme.dart';

import 'common_elements.dart';
import 'device.dart';
import 'main.dart';

List<Widget> buildActions(
    BuildContext context, void Function(Sections) scrollCallback) {
  // List<Widget> list = [];

  //Sections

  //enum Sections { Home, Process, Features, Experience, Contact }
  Widget tb(Sections s) {
    return LayoutBuilder(builder: (context, constraints) {
      // log('tb layoutbuilder ${constraints.maxWidth}');
      if (Device.width > 800) {
        return TextButton(
            onPressed: () => scrollCallback(s), child: Text(s.name));
      } else {
        return const SizedBox.shrink();
      }
    });
  }

  return [
    tb(Sections.Process),
    tb(Sections.Features),
    tb(Sections.Experience),

    //Contact button
    TextButton.icon(
        onPressed: () => contactButtonPressed(context, false),
        icon: const Icon(Icons.email_outlined),
        label: const Text('Contact'))
  ];

  // return list;
}

class CustomAppBar extends SliverAppBar {
  const CustomAppBar({super.key});
}

SliverAppBar buildAppBar(
    BuildContext context, void Function(Sections) scrollCallback) {
  return SliverAppBar(
      elevation: 5,
      // scrolledUnderElevation: 4,
      stretch: false, //!Device.isLandscapeMobile,
      pinned: !Device.isLandscapeMobile,
      floating: !Device.isLandscapeMobile,
      toolbarHeight: 50, //Device.select(def: 50, phoneLand: 40, phonePort: 40),
      backgroundColor: theme.scaffoldBackgroundColor,

      // centerTitle: true,
      title: LayoutBuilder(builder: (context, constraints) {
        bool fw = Device.width > 600;
        // fw = true;
        return TextButton(
          onPressed: () => scrollCallback(Sections.Home),
          child: Text(fw ? 'Freelance Mobile & Web' : 'Mobile & Web',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center),
        );
      }),
      leading: Builder(builder: (context) {
        return IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => Scaffold.of(context).openDrawer(),
        );
      }),
      actions: buildActions(context, scrollCallback));
}

class AnimatingHomeIcon extends StatefulWidget {
  const AnimatingHomeIcon({Key? key}) : super(key: key);

  @override
  State<AnimatingHomeIcon> createState() => _AnimatingHomeIconState();
}

class _AnimatingHomeIconState extends State<AnimatingHomeIcon>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
  }

  void _handleOnPressed() {
    // Scaffold.of(context).openDrawer();
    setState(() {
      isPlaying = !isPlaying;
      isPlaying
          ? _animationController.forward()
          : _animationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_close, progress: _animationController),
        onPressed: () => _handleOnPressed(),
      );
    });
  }
}
