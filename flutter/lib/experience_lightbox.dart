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
    return OrientationBuilder(builder: (context, or) {
      if (_imageExpandedInLightbox && Device.isPhonePort) {
        //Avoid the margins
        return Scaffold(
            // appBar: AppBar(title: Text(experiences[index].headline)),
            // backgroundColor: theme.cardColor,
            body: Center(child: interactiveImage()));
      }
      return Scaffold(
          appBar: AppBar(title: Text(experiences[index].headline)),
          // backgroundColor: theme.cardColor,
          body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: lightboxRows()));
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

    //brk
    //   if (_imageExpandedInLightbox) {
    // if (Device.isPhonePort) {
    //   //Expanded on phone
    //   return Center(child: lightboxImage());
    // } else {
    //   //Desktop img expanded
    //
    //   //Show full image above text
    //
    //   return ListView(
    //     children: [
    //       lightboxImage(),
    //       const Padding(padding: EdgeInsets.only(top: 45)),
    //       lightboxSelectCol(TextAlign.left),
    //     ],
    //   );
    // }
    // } else {
    //   if (Device.width < 800) {
    //     //Mobile
    //
    //     return ListView(children: [
    //       ConstrainedBox(
    //           constraints: const BoxConstraints(maxHeight: 400),
    //           child: lightboxImage()),
    //       const Padding(padding: EdgeInsets.only(top: 45)),
    //       lightboxSelectCol(TextAlign.left),
    //     ]);
    //     // const Padding(padding: EdgeInsets.only(bottom: 60)),
    //   }
    //   else {
    //     //Desktop view
    //     return Row(
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       mainAxisSize: MainAxisSize.max,
    //
    //       // mainAxisAlignment: MainAxisAlignment.center,
    //       // mainAxisSize: MainAxisSize.min,
    //       children: [
    //         Flexible(child: lightboxImage()),
    //         Flexible(child: lightTextListView()),
    //       ],
    //     );
    //   }
    // }
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

  List<Widget> _lightTextList(TextAlign align, {required bool addClose}) {
    return [
      paraMed(experiences[index].bodyText, align: align),
      const Padding(padding: EdgeInsets.only(top: 15)),
      paraMed(experiences[index].fullText, align: align),
      const Padding(padding: EdgeInsets.only(top: 15)),
      OutlinedButton(
        onPressed: () => launchUrl(Uri.parse(experiences[index].url)),
        child: const Text('Website'),
      ),
      const Padding(padding: EdgeInsets.only(top: 15)),
      if (addClose)
        ElevatedButton(
          onPressed: _removeOverlay,
          // icon: const Icon(Icons.close),
          child: const Text('Close'),
        ),
      if (addClose) const Padding(padding: EdgeInsets.only(top: 15)),
    ];
  }

  Padding lightTextListView() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SelectionArea(
            // child: Center(
            child: ListView(
                shrinkWrap: true,
                children: _lightTextList(TextAlign.left, addClose: false))));
  }

  Widget lightboxSelectCol(TextAlign align) {
    return SelectionArea(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _lightTextList(align, addClose: true)));
  }
}

OverlayEntry? _entry;

// void _removeOverlay() {
// _entry?.remove();
// _entry = null;
// }

// Widget lightbox(BuildContext context, int index) {
//   return
//       // SizedBox(
//       //   width: Device.width,
//       //   height: Device.height,
//       //   child:
//
//       // GestureDetector(
//       //     onTap: _removeOverlay,
//       //     child:
//       ExperienceLightbox(index, key: Key('lbx_$index'));
// }

class LightboxDialog extends PopupRoute {
  final int index;
  LightboxDialog(this.index)
      : super(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        );

  @override
  Color get barrierColor => const Color(0x40000000);

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
  // _entry = OverlayEntry(
  //   builder: (context) => lightbox(context, index),
  // );
  // Overlay.of(context).insert(_entry!);

  // Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //
  //         fullscreenDialog: false,
  //         builder: (BuildContext context) {
  //           return lightbox(context, index);
  //         }));

  // Navigator.push(
  //     context,
  //     PageRouteBuilder(
  //         fullscreenDialog: true,
  //         opaque: false,
  //         pageBuilder: (BuildContext context, Animation<double> animation,
  //             Animation<double> secondaryAnimation) {
  //           // var offset =
  //           //     Tween<Offset>(begin: const Offset(0, 10), end: Offset.zero)
  //           //         .animate(animation);
  //           var sigma = animation.value * 20;
  //           return SizedBox.expand(
  //               child: GestureDetector(
  //                   onTap: () {
  //                     log('touched__');
  //                     Navigator.pop(context);
  //                   },
  //                   child: BackdropFilter(
  //                       filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
  //                       // child: SlideTransition(
  //                       //     position: offset,
  //                       child: lightbox(context, index))));
  //         }));

  Navigator.push(context, LightboxDialog(index));

  // showDialog(
  //     context: context, builder: (BuildContext ct) => lightbox(ct, index));
}
