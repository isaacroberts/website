import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'dart:developer';
// import 'dart:math' as math;

// import 'package:decorated_icon/decorated_icon.dart';
import 'package:flutter/material.dart';
import 'package:ms_undraw/ms_undraw.dart';
import 'package:flutter/animation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'common_elements.dart';
import 'text_theme.dart';

import 'theme.dart';
import 'device.dart';

import 'experience.dart';

class ExperienceLightbox extends StatefulWidget {
  final int index;
  const ExperienceLightbox(this.index, {Key? key}) : super(key: key);

  @override
  State<ExperienceLightbox> createState() => _ExperienceLightboxState();
}

class _ExperienceLightboxState extends State<ExperienceLightbox>
    with TickerProviderStateMixin {
  bool _imageExpandedInLightbox = false;

  //TODO: Animate image resize

  int get index => widget.index;

  bool get horiz => Device.width > 900;

  void _removeOverlay() {
    Navigator.pop(context);
  }

  Widget stackWithX(bool stack, Widget child) {
    if (stack) {
      return Stack(children: [
        child,
        Positioned.fill(
            child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  iconSize: 50,
                  icon: const Icon(Icons.close),
                  onPressed: _removeOverlay,
                ))),
      ]);
    } else {
      return child;
    }
  }

  @override
  Widget build(BuildContext context) {
    //TODO: OrientationBuilder for isLandscape
    if (_imageExpandedInLightbox && Device.isPhonePort) {
      return Center(child: interactiveImage());
    } else {
      bool stackX = !(_imageExpandedInLightbox && Device.isPhonePort);

      // return Scaffold(
      //     // backgroundColor: Colors.transparent,
      //     appBar: AppBar(),
      return Center(
          // child: IgnorePointer(
          child: Card(
        margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
        child: stackWithX(
            stackX,
            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                child: lightboxRows())),
      ));
    }
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
    if (_imageExpandedInLightbox && Device.isPhonePort) {
      return Center(child: lightboxImage());
    } else if (_imageExpandedInLightbox || Device.width < 800) {
      //Vertical listView
      //Todo: Make stack so title & x can be on top

      return ListView(
        children: [
          Text(
            experiences[index].headline,
            style: fonts.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),
          lightboxImage(),
          const SizedBox(height: 15),
          lightboxSelectCol(TextAlign.left),
        ],
      );
    } else {
      //Desktop view
      return Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,

            // mainAxisAlignment: MainAxisAlignment.center,
            // mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(child: lightboxImage()),
              Flexible(child: lightTextListView()),
            ],
          ));
    }
  }

  Widget lightboxImage() {
    return GestureDetector(
        onTap: () {
          setState(() {
            _imageExpandedInLightbox = !_imageExpandedInLightbox;
          });
        },
        child: getImage(index));
  }

  Widget interactiveImage() {
    return InteractiveViewer(child: getImage(index));
  }

  List<Widget> _lightTextList(TextAlign align,
      {required bool addClose, required bool addTitle}) {
    return [
      if (addTitle)
        Text(experiences[index].headline,
            style: fonts.titleMedium, textAlign: align),
      if (addTitle) const SizedBox(height: 15),
      paraMed(experiences[index].fullText, align: align),
      const SizedBox(height: 15),
      OutlinedButton(
        onPressed: () => launchUrl(Uri.parse(experiences[index].url)),
        child: const Text('Website'),
      ),
      const SizedBox(height: 15),
      if (addClose)
        ElevatedButton(
          onPressed: _removeOverlay,
          // icon: const Icon(Icons.close),
          child: const Text('Close'),
        ),
      if (addClose) const SizedBox(height: 15),
    ];
  }

  Padding lightTextListView() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SelectionArea(
            // child: Center(
            child: ListView(
                shrinkWrap: true,
                children: _lightTextList(TextAlign.left,
                    addClose: false, addTitle: true))));
  }

  Widget lightboxSelectCol(TextAlign align) {
    return SelectionArea(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _lightTextList(align, addClose: true, addTitle: false)));
  }
}

class LightboxDialog extends PopupRoute {
  final int index;
  LightboxDialog(this.index)
      : super(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        );

  @override
  Color get barrierColor => const Color(0x90000000);

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => 'Barrier';

  @override
  bool get opaque => false;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    var offset = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(animation);
    return SlideTransition(
        position: offset,
        child: ExperienceLightbox(index, key: Key('lbx_$index')));
  }

  @override
  Duration get transitionDuration => const Duration(milliseconds: 150);
}

void showLightbox(BuildContext context, int index) {
  Navigator.push(context, LightboxDialog(index));
}
