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

import 'theme.dart';
import 'device.dart';

import 'experience.dart';

class ExperienceLightbox extends StatefulWidget {
  final int index;
  const ExperienceLightbox(this.index, {Key? key}) : super(key: key);

  @override
  State<ExperienceLightbox> createState() => _ExperienceLightboxState();
}

class _ExperienceLightboxState extends State<ExperienceLightbox> {
  bool _imageExpandedInLightbox = false;

  //TODO: Animate image resize

  int get index => widget.index;

  bool get horiz => Device.isLandscape;

  Widget stackWithCloseButton(
      BuildContext context, bool onTransparent, Widget child) {
    return Stack(children: [
      child,
      IconButton(
        iconSize: 50,
        alignment: Alignment.topLeft,
        color:
            onTransparent ? theme.scaffoldBackgroundColor : theme.disabledColor,
        icon: const Icon(Icons.close),
        onPressed: () {
          Navigator.pop(context);
        },
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    //TODO: OrientationBuilder for isLandscape

    return OrientationBuilder(builder: (context, or) {
      if (_imageExpandedInLightbox && Device.isPhone) {
        //Avoid the margins
        return Scaffold(
            backgroundColor: colorScheme.secondary,
            body: stackWithCloseButton(
                context, false, Center(child: lightboxImage())));
      }

      return Scaffold(
          backgroundColor: colorScheme.secondary,
          body: Card(
              margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
              child: stackWithCloseButton(
                  context,
                  false,
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30, vertical: horiz ? 60 : 30),
                      child: lightboxRows()))));
    });
  }

  Widget imgSizer({required Widget child}) {
    if (_imageExpandedInLightbox) {
      // return Expanded(child: child);
      return child;
    } else {
      return Flexible(child: child);
    }
  }

  Widget lightboxRows() {
    if (!horiz) {
      bool leftAlign = true;
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,

        // mainAxisAlignment: MainAxisAlignment.center,
        // mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            experiences[index].headline,
            style: fonts.headlineSmall,
            textAlign: leftAlign ? TextAlign.left : TextAlign.center,
          ),
          const Padding(padding: EdgeInsets.only(top: 60)),
          Expanded(
              child: ListView(children: [
            lightboxImage(),
            const Padding(padding: EdgeInsets.only(top: 60)),
            paragraph(experiences[index].bodyText, leftAlign: leftAlign),
            const Padding(padding: EdgeInsets.only(top: 15)),
            paragraph(lorem(paragraphs: 2), leftAlign: leftAlign),
            const Padding(padding: EdgeInsets.only(top: 15)),
            OutlinedButton(
              child: const Text('Website'),
              onPressed: () => launchUrl(Uri.parse(experiences[index].url)),
            )
          ])),
          // const Padding(padding: EdgeInsets.only(bottom: 60)),
        ],
      );
    } else if (!_imageExpandedInLightbox) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,

        // mainAxisAlignment: MainAxisAlignment.center,
        // mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(child: lightboxImage()),
          Flexible(child: lightTextCol()),
        ],
      );
    } else {
      if (Device.isPhone) {
        //Expanded on phone
        return Center(child: lightboxImage());
      } else {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,

          // mainAxisAlignment: MainAxisAlignment.center,
          // mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: Device.width - 240),
              child: lightboxImage(),
            ),
            Flexible(child: LayoutBuilder(builder: (context, constraints) {
              if (constraints.maxWidth > 150) {
                return lightTextCol();
              } else {
                return const SizedBox.shrink();
              }
            }))
          ],
        );
      }
    }
  }

  Widget lightboxImage() {
    if (Device.isPhone) {
      return GestureDetector(
          onTap: () {
            setState(() {
              _imageExpandedInLightbox = !_imageExpandedInLightbox;
            });
          },
          child: getImage(index));
    } else {
      return getImage(index);
    }
  }

  Padding lightTextCol() {
    return Padding(
        padding:
            EdgeInsets.symmetric(vertical: (horiz ? 0 : 0), horizontal: 30),
        child: lightboxText());
  }

  Widget lightboxText() {
    bool leftAlign = horiz;
    leftAlign = true;
    return Center(
        child: ListView(shrinkWrap: true, children: [
      if (horiz)
        Text(
          experiences[index].headline,
          style: fonts.headlineSmall,
          textAlign: leftAlign ? TextAlign.left : TextAlign.center,
        ),
      if (horiz) const Padding(padding: EdgeInsets.only(top: 15)),
      paragraph(experiences[index].bodyText, leftAlign: leftAlign),
      const Padding(padding: EdgeInsets.only(top: 15)),
      paragraph(lorem(paragraphs: 2), leftAlign: leftAlign),
      const Padding(padding: EdgeInsets.only(top: 15)),
      OutlinedButton(
        child: const Text('Website'),
        onPressed: () => launchUrl(Uri.parse(experiences[index].url)),
      )
    ]));
  }
}

Widget lightbox(BuildContext context, int index) {
  return SizedBox(
      width: Device.width,
      height: Device.height,
      child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: ExperienceLightbox(index, key: Key('lbx_$index'))));
}

void showLightbox(BuildContext context, int index) {
  Navigator.push(
      context,
      MaterialPageRoute(
          fullscreenDialog: true,
          builder: (BuildContext context) {
            return lightbox(context, index);
          }));

  // showDialog(
  //     context: context, builder: (BuildContext ct) => lightbox(ct, index));
}
