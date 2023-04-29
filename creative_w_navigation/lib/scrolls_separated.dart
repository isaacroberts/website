import 'package:flutter/material.dart';
import 'theme.dart';
import 'common_elements.dart';

//TODO: Come up with different name to mean "the progress of the transition across pages)

class ScrollWatcher extends InheritedWidget {
  final double value;
  const ScrollWatcher(double v, {super.key, required super.child})
      : value = (v > 1 ? 1 : (v < 0 ? 0 : v));

  static ScrollWatcher? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ScrollWatcher>();
  }

  static ScrollWatcher of(BuildContext context) {
    final ScrollWatcher? result = maybeOf(context);
    assert(result != null, 'No ScrollWatcher found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant ScrollWatcher oldWidget) {
    return value != oldWidget.value;
  }
}

class ScrollAnim extends InheritedWidget {
  final AnimationController anim;

  const ScrollAnim(this.anim, {super.key, required super.child});

  static ScrollAnim? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ScrollAnim>();
  }

  static ScrollAnim of(BuildContext context) {
    final ScrollAnim? result = maybeOf(context);
    assert(result != null, 'No ScrollWatcher found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant ScrollAnim oldWidget) {
    return anim != oldWidget.anim;
  }
}

class IndivScroll extends StatefulWidget {
  final Widget child;
  final IndivScroll? next;

  const IndivScroll({Key? key, required this.child, this.next})
      : super(key: key);

  @override
  State<IndivScroll> createState() => _IndivScrollState();
}

class _IndivScrollState extends State<IndivScroll> {
  ScrollController? _controller;

  //Stores controller's clamped value even when controller is null
  double _scrollPos = 0;
  double get scrollPos => clip(_scrollPos, 0, 1);

  @override
  void initState() {
    _controller = ScrollController();
    _controller!.addListener(_controllerScrolled);
    super.initState();
  }

  @override
  void dispose() {
    _controller?.removeListener(_controllerScrolled);
    _controller = null;
    super.dispose();
  }

  void _controllerScrolled() {
    ScrollPosition? pos = _controller?.position;

    if (pos != null) {
      // calls update function
      scrollPos = (pos.extentBefore - pos.minScrollExtent) /
          (pos.maxScrollExtent - pos.minScrollExtent);
    }
  }

  set scrollPos(double s) {
    if (s != _scrollPos) {
      //ignore values that are both out of bounds
      if ((s <= 0) && (_scrollPos <= 0)) {
        return;
      } else if ((s >= 1) && (_scrollPos >= 1)) {
        return;
      } else {
        setState(() {
          _scrollPos = s;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScrollWatcher(scrollPos, child: widget.child);
  }
}
