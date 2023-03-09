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
      'Machine learning-driven melodies for music production.',
      lemonaidFull,
      'https://lemonaid.ai/'),
  Experience(
      'Magic Vocals',
      'MagicVocals.png',
      'A music production plugin for Audio Review Youtuber Chrys Gringo.',
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
          borderRadius: BorderRadius.circular(15),
          child: fadeAssetFore(
            'images/${experiences[index].image}',
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
        // borderRadius: BorderRadius.circular(15),
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
    return Card(
        margin: const EdgeInsets.fromLTRB(standardContainerMargin, 0,
            standardContainerMargin, standardContainerMargin),
        // elevation: hover ? 5 : 1,
        child: touchWrapper(
            context,
            index,
            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: centerSection(context))));
  }

  Widget centerSection(BuildContext context) {
    //TODO: Make stateful so i can expand image

    return LayoutBuilder(builder: (contet, constraints) {
      final bool horiz = Device.width >= 800;
      final bool tiny = Device.width <= tinyWidth;

      if (horiz) {
        return Flex(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          direction: Axis.horizontal,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(child: getImage(index)),
            const SizedBox(width: 30),
            Flexible(child: textSection(horiz, tiny)),
          ],
        );
      } else {
        // TextAlign align = tiny ? TextAlign.left : TextAlign.center;
        TextAlign align = TextAlign.center;

        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment:
                  tiny ? CrossAxisAlignment.stretch : CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  experiences[index].headline,
                  style: fonts.headlineSmall,
                  textAlign: align,
                ),
                const SizedBox(height: 15),
                Flexible(child: getImage(index)),
                const SizedBox(height: 15),
                subt(experiences[index].bodyText,
                    align: align, selectable: false),
                const SizedBox(height: 15),
                Flexible(
                    child: OutlinedButton(
                  child: const Text('Read more'),
                  onPressed: () => showLightbox(context, index),
                )),
                const SizedBox(height: 15),
              ],
            ));
      }
    });
  }

  Column textSection(bool horiz, bool tiny) {
    TextAlign align = horiz || tiny ? TextAlign.left : TextAlign.center;
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
          const SizedBox(height: 15),
          subt(experiences[index].bodyText, align: align, selectable: false),
          if (tiny) const SizedBox(height: 15),
          if (tiny)
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
