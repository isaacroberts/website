import 'dart:math';

import 'package:flutter/material.dart';

import 'dart:developer';
// import 'dart:math' as math;

// import 'package:decorated_icon/decorated_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:ms_undraw/ms_undraw.dart';
import 'package:flutter/animation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:website/common_elements.dart';
import 'package:website/text_theme.dart';

import 'experience_lightbox.dart';

import 'theme.dart';
import 'device.dart';

class Experience {
  final String headline;
  final String image;
  final String bodyText;
  final String url;
  const Experience(this.headline, this.image, this.bodyText, this.url);
}

const List<Experience> experiences = [
  Experience(
      'Lemonaid',
      'lemonaid.png',
      'The Lemonaid plugin was built to create machine learning-driven melodies for music production.',
      'https://lemonaid.ai/'),
  Experience(
      'Magic Vocals',
      'MagicVocals.png',
      'The Magic Vocals was a music production plugin for Audio Review Youtuber Chrys Gringo.',
      'https://www.youtube.com/watch?v=tnYJUMxthLs'),
  Experience(
      'OTT',
      'ott_clipped.png',
      'An upwards compressor plugin for Top 40 producer GetYourSnackOn.',
      'ott_clipped.png')
];

Hero getImage(int index) {
  return Hero(
      tag: 'expHero$index',
      child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Image.asset(
            'assets/images/${experiences[index].image}',
            fit: BoxFit.contain,
          )));
}

class ExperienceWidget extends StatefulWidget {
  final int index;
  const ExperienceWidget(this.index, {Key? key}) : super(key: key);

  @override
  State<ExperienceWidget> createState() => _ExperienceWidgetState();
}

class _ExperienceWidgetState extends State<ExperienceWidget>
    with SingleTickerProviderStateMixin {
  bool _hovered = false;
  late Animation<Color?> animation;

  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);

    animation = ColorTween(
      begin: theme.scaffoldBackgroundColor,
      end: Colors.black,
      // begin: colorScheme.secondaryContainer,
      // end: Color.lerp(theme.cardColor, colorScheme.secondaryContainer, 0)
    ).animate(controller)
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation object’s value.
        });
      });
  }

  void animateColor() {
    controller.forward();
  }

  bool get hover => _hovered;
  set hover(bool set) {
    _hovered = set;
    if (_hovered) {
      controller.forward();
    } else {
      controller.animateBack(0);
    }
  }

  int get index => widget.index;

  Widget touchWrapper(BuildContext context, int index, Widget child) {
    if (Device.isDesktop) {
      return MouseRegion(
          onEnter: (e) => hover = true,
          onExit: (e) => hover = false,
          child: GestureDetector(
              onTap: () => showLightbox(context, index), child: child));
    } else {
      return GestureDetector(
          onTap: () => showLightbox(context, index), child: child);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool horiz = Device.width >= 800 || Device.isLandscape;

    return Container(
        decoration:
            gradient(GradientStop.values[GradientStop.Exp0.index + index]),
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            child: touchWrapper(
                context,
                index,
                Card(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: hover
                                ? colorScheme.secondary!
                                : theme.scaffoldBackgroundColor),
                        borderRadius: BorderRadius.circular(20)),
                    // color: animation.value ?? Colors.white,

                    elevation: hover ? 5 : 0,
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: horiz ? 15 : 30,
                            horizontal: horiz ? 15 : 0),
                        child: centerSection(horiz, context))))));
  }

  Flex centerSection(bool horiz, BuildContext context) {
    //TODO: Make stateful so i can expand image
    return Flex(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      direction: horiz ? Axis.horizontal : Axis.vertical,
      mainAxisSize: MainAxisSize.min,

      // mainAxisAlignment: MainAxisAlignment.center,
      // mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(child: getImage(index)),
        Flexible(
            child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: (horiz ? 0 : 30), horizontal: 30),
                child: horiz
                    ? textSection(horiz)
                    : SizedBox(
                        width: horiz ? 300 : 400, child: textSection(horiz)))),
      ],
    );
  }

  Column textSection(bool horiz) {
    return Column(
        crossAxisAlignment:
            horiz ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            experiences[index].headline,
            style: fonts.headlineSmall,
            textAlign: horiz ? TextAlign.left : TextAlign.center,
          ),
          const Padding(padding: EdgeInsets.only(top: 15)),
          paragraph(experiences[index].bodyText,
              leftAlign: horiz, selectable: false),
          if (Device.isMobile)
            Flexible(
                child: OutlinedButton(
              child: const Text('Read more'),
              onPressed: () => showLightbox(context, index),
            ))
        ]);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

Widget buildExperienceList(BuildContext context) {
  return SliverList(delegate: SliverChildBuilderDelegate((context, index) {
    if (index >= experiences.length) {
      return null;
    }
    return ExperienceWidget(index, key: Key(index.toString()));
  }));
}
