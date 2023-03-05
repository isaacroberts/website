import 'package:flutter/material.dart';

import 'dart:developer';

import 'common_elements.dart';
import 'text_theme.dart';

import 'experience_lightbox.dart';
import 'experience_full_text.dart';

import 'theme.dart';
import 'device.dart';

class Experience {
  final String headline;
  final String image;
  final String bodyText;
  final String fullText;
  final String url;
  const Experience(
      this.headline, this.image, this.bodyText, this.fullText, this.url);
}

const List<Experience> experiences = [
  Experience(
      'Ragnar Drums',
      'ragnar.png',
      'Drum sampler plugin for Solemn Tones.',
      ragnarFull,
      'https://solemntones.com/'),
  Experience(
      'Lemonaid',
      'lemonaid.png',
      'The Lemonaid plugin was built to create machine learning-driven melodies for music production.',
      lemonaidFull,
      'https://lemonaid.ai/'),
  Experience(
      'Magic Vocals',
      'MagicVocals.png',
      'The Magic Vocals was a music production plugin for Audio Review Youtuber Chrys Gringo.',
      mvFull,
      'https://www.youtube.com/watch?v=tnYJUMxthLs'),
  // Experience(
  //     'OTT',
  //     'ott_clipped.png',
  //     'An upwards compressor plugin for Top 40 producer GetYourSnackOn.', ottFull,
  //     'ott_clipped.png'),
];

Hero getImage(int index) {
  return Hero(
      tag: 'expHero$index',
      child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: fadeAssetFore(
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
    return InkWell(
        borderRadius: BorderRadius.circular(15),
        onHover: (b) => hover = b,
        onTap: () => showLightbox(context, index),
        child: child);

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
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Card(
            elevation: hover ? 5 : 1,
            child: touchWrapper(
                context,
                index,
                Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    child: centerSection(context)))));
  }

  Widget centerSection(BuildContext context) {
    //TODO: Make stateful so i can expand image

    return LayoutBuilder(builder: (contet, constraints) {
      bool horiz = Device.width >= 800;
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
                          width: horiz ? 300 : 400,
                          child: textSection(horiz)))),
        ],
      );
    });
  }

  Column textSection(bool horiz) {
    TextAlign align = horiz ? TextAlign.left : TextAlign.center;
    return Column(
        crossAxisAlignment: textToCA(align),
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            experiences[index].headline,
            style: fonts.headlineSmall,
            textAlign: align,
          ),
          const Padding(padding: EdgeInsets.only(top: 15)),
          subt(experiences[index].bodyText, align: align, selectable: false),
          if (Device.isMobile) const Padding(padding: EdgeInsets.only(top: 15)),
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
  return SliverList(
      delegate: SliverChildBuilderDelegate(childCount: experiences.length,
          (context, index) {
    if (index >= experiences.length) {
      return null;
    }
    return ExperienceWidget(index, key: Key(index.toString()));
  }));
}
