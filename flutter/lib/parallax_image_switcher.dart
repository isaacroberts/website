import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:isaac_roberts_consulting/parallax.dart';
import 'dart:developer';
import 'common_elements.dart';
import 'device.dart';
import 'process_sidebar.dart';
import 'theme.dart';

class ParallaxImageSwitcher extends StatefulWidget {
  final double opacity;
  // final ImageProvider image;
  final List<String> images;
  final String? debugLabel;
  final double distance;
  final int current;

  const ParallaxImageSwitcher(
      {required this.images,
      required this.current,
      double? opacity,
      this.distance = 1.5,
      this.debugLabel,
      Key? key})
      : opacity = opacity ?? 1,
        super(key: key);

  @override
  State<ParallaxImageSwitcher> createState() => _ParallaxImageSwitcherState();
}

class _ParallaxImageSwitcherState extends State<ParallaxImageSwitcher>
    with SingleTickerProviderStateMixin {
  final List<NetworkImage> _bgs = [];
  final GlobalKey _backgroundImageKey =
      GlobalKey(debugLabel: 'parallax_image_switcher');

  // late Animation<double> topOpacity;
  // late AnimationController controller;

  // int _front=0;
  late int _current = 0;

  // int? _back;

  ImageProvider<Object> getBg(int ix) {
    // return assetProvider('card_bgs/${cardBgs[ix]}');
    if (kIsWeb) {
      return _bgs[ix];
    } else {
      return assetProvider('card_bgs/${cardBgs[ix]}');
    }
  }

  @override
  void didUpdateWidget(covariant ParallaxImageSwitcher oldWidget) {
    super.didUpdateWidget(oldWidget);
    current = widget.current;
  }

  @override
  void initState() {
    _current = widget.current;
    super.initState();

    if (kIsWeb) {
      for (int n = 0; n < cardBgs.length; ++n) {
        _bgs.add(NetworkImage('assets/card_bgs/${cardBgs[n]}'));
      }
    }
  }

  // void animationListener() {
  //   if (_back != null && topOpacity.isCompleted) {
  //     setState(() {
  //       _back = null;
  //     });
  //   }
  // }

  int get current => _current;
  set current(int set) {
    if (set != _current) {
      // if (controller.isAnimating) {
      //
      // }
      setState(() {
        _current = set;
      });
      // setState(() {
      //   _back = _current;
      //   _current = set;
      // });
      //
      // controller.animateTo(1);
      // _back = _front;
      // _front = _current;
    }
  }

  @override
  Widget build(BuildContext context) {
    // int? b = _back;

    final delegate = RelativeParallaxDelegate(
      scrollable: Scrollable.of(context),
      listItemContext: context,
      backgroundImageKey: _backgroundImageKey,
      distance: widget.distance,
    );

    return AnimatedSwitcher(
        key: const Key('pis_switcher'),
        duration: const Duration(milliseconds: 450),
        // switchInCurve: Curves.ease,
        // switchOutCurve: Curves.ease,
        child: Flow(
            key: ValueKey<int>(_current),
            // key: const Key('pis_flow'),
            delegate: delegate,
            children: [
              Image(
                  key: ValueKey<int>(_current),
                  image: getBg(current),
                  fit: BoxFit.cover,
                  opacity: AlwaysStoppedAnimation<double>(widget.opacity))
            ]));
  }
}
