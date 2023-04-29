import 'dart:developer';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:isaac_roberts_consulting/scroll_app_bar.dart';
import 'package:isaac_roberts_consulting/text_theme.dart';
import 'device.dart';
import 'theme.dart';
import 'dart:math' as math;

class VertScroll extends FlowDelegate {
  final ScrollController scrollable;
  // final BuildContext listItemContext;

  VertScroll({required this.scrollable});

  @override
  void paintChildren(FlowPaintingContext context) {
    double scrollAmt = scrollable.offset;
    log('scroll = $scrollAmt');

    context.paintChild(1);
    context.paintChild(
      0,
      transform: Transform.translate(offset: Offset(0.0, scrollAmt)).transform,
    );
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    return true;
  }
}

/*
class ScrollStack extends StatefulWidget {
  final List<Widget> children;
  const ScrollStack({Key? key, required this.children}) : super(key: key);

  @override
  State<ScrollStack> createState() => _ScrollStackState();
}

class _ScrollStackState extends State<ScrollStack> {
  // late ScrollController controller;

  ViewportOffset? offset;
  BoxConstraints? constraints;
  final ScrollController controller = ScrollController();

  final GlobalKey<_ScrollableStackState> _scrollableStackKey =
      GlobalKey<_ScrollableStackState>();

  @override
  void initState() {
    // controller = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        controller: controller,
        child: LayoutBuilder(builder: (context, constraints) {
          return Scrollable(
              controller: controller,
              viewportBuilder: (c, o) {
                final oldOffset = offset;
                if (this.constraints != constraints) {
                  this.constraints = constraints;
                  offset = o;
                  offset!.applyViewportDimension(constraints.maxHeight);
                  offset!.applyContentDimensions(0, double.infinity);
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    setState(() {});
                  });
                }
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  if (oldOffset != null && oldOffset != o) {
                    _scrollableStackKey.currentState
                        ?._removeListener(oldOffset);
                  }
                  _scrollableStackKey.currentState?._addListener(o);
                });
                return ScrollableStack(
                  key: _scrollableStackKey,
                  children: widget.children,
                );
              });
        }));
  }
}
*/
class ScrollableStack extends StatefulWidget {
  final List<Widget> children;
  const ScrollableStack({super.key, required this.children});

  @override
  State<ScrollableStack> createState() => _ScrollableStackState();
}

class _ScrollableStackState extends State<ScrollableStack> {
  ViewportOffset? offset;

  // List<GlobalKey> scrollPastKeys = [];

  @override
  void initState() {
    // for (int n=0; n < widget.children.length; ++n) {
    //   scrollPastKeys.add(GlobalKey());
    // }
    super.initState();
  }

  void _addListener(ViewportOffset offset) {
    this.offset = offset;
    offset.addListener(_listener);
  }

  void _removeListener(ViewportOffset offset) {
    offset.removeListener(_listener);
  }

  void _listener() {
    setState(() {});
  }

  double get pixels => offset?.pixels ?? 0;

  int get frontNo => math.min(pixels ~/ Device.height, widget.children.length);
  // double get pctIntoObject => pixels % Device.height;
  @override
  Widget build(BuildContext context) {
    int f = frontNo;
    int? b;
    double pctIntoObject = pixels % Device.height;

    if (f >= widget.children.length - 1) {
      f = widget.children.length - 1;
      b = null;
      pctIntoObject = 0;
    } else {
      b = f + 1;
      if (b >= widget.children.length) b = null;
    }

    log('pos $pixels $frontNo');
    return SizedBox(
        height: 2000,
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (b != null) Positioned.fill(child: widget.children[b]),
            Positioned(
                left: 0,
                right: 0,
                height: Device.height,
                top: pctIntoObject,
                child: OverflowBox(child: widget.children[f])),
          ],
        ));
  }
}

class ScrollPast extends StatefulWidget {
  final Widget child;
  final double progress;
  const ScrollPast(this.progress, {Key? key, required this.child})
      : super(key: key);

  @override
  State<ScrollPast> createState() => _ScrollPastState();
}

class _ScrollPastState extends State<ScrollPast> {
  void _listener() {
    setState(() {});
  }

  Widget entranceAnimation(context, progress, child) {
    return FadeTransition(
        opacity: AlwaysStoppedAnimation<double>(progress), child: child);
    return SizedBox.shrink();
    // return
    return Container(color: theme.scaffoldBackgroundColor, child: child);
    // return Container(color: Colors.black.withOpacity(progress), child: null);
  }

  Widget holdAnimation(context, progress, child) {
    return child;
    return Container(color: theme.scaffoldBackgroundColor, child: child);
  }

  Widget exitAnimation(context, progress, child) {
    // return child;
    return SlideTransition(
        position: AlwaysStoppedAnimation<Offset>(Offset(0, progress)),
        // child: Container(
        //     key: Key('container'),
        //     height: Device.height,
        //     width: Device.width,
        //     color: theme.scaffoldBackgroundColor,
        child: child);
  }

  /// Called whenever the widget configuration changes.
  ///
  /// If the parent widget rebuilds and requests that this location in the tree
  /// update to display a new widget with the same [runtimeType] and
  /// [Widget.key], the framework will update the [widget] property of this
  /// [State] object to refer to the new widget and then call this method
  /// with the previous widget as an argument.
  ///
  /// Override this method to respond when the [widget] changes (e.g., to start
  /// implicit animations).
  ///
  /// The framework always calls [build] after calling [didUpdateWidget], which
  /// means any calls to [setState] in [didUpdateWidget] are redundant.
  ///
  /// {@macro flutter.widgets.State.initState}
  ///
  /// Implementations of this method should start with a call to the inherited
  /// method, as in `super.didUpdateWidget(oldWidget)`.
  @mustCallSuper
  @protected
  void didUpdateWidget(covariant ScrollPast oldWidget) {}

  double get progress => widget.progress;

  @override
  Widget build(BuildContext context) {
    double holdStart = 1;
    double holdEnd = 2;

    if (progress <= 0 || progress > 3) {
      return const SizedBox.expand();
    } else if (progress < holdStart) {
      return entranceAnimation(context, progress / holdStart, widget.child);
    } else if (progress <= holdEnd) {
      return holdAnimation(context,
          (progress - holdStart) / (holdEnd - holdStart), widget.child);
      return Stack(children: [
        const ScrollAppBar(title: 'Hold'),
        holdAnimation(context, 0, widget.child)
      ]);
    } else {
      return exitAnimation(
          context, (progress - holdEnd) / (3 - holdEnd), widget.child);
      return Stack(children: [
        const ScrollAppBar(title: 'Title'),
        exitAnimation(context, progress - 1, widget.child)
      ]);
    }
  }
}

class ScrollStack extends StatefulWidget {
  final List<Widget> children;
  const ScrollStack({Key? key, required this.children}) : super(key: key);

  @override
  State<ScrollStack> createState() => _ScrollStackState();
}

class _ScrollStackState extends State<ScrollStack> {
  // late ScrollController controller;

  ViewportOffset? offset;
  BoxConstraints? constraints;
  final ScrollController controller = ScrollController();

  // late List<GlobalKey<_ScrollPastState>> _scrollableStackKey;
  late GlobalKey<_ScrollableStackState> _scrollableStackKey =
      GlobalKey<_ScrollableStackState>();

  @override
  void initState() {
    controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  List<Widget> stackChildren(double rOffset, BoxConstraints constraints) {
    List<Widget> list = [];

    for (int index = 0; index < widget.children.length; ++index) {
      double prog = 2 * (rOffset - index + 1);

      // log('prog ($index) : $prog');
      list.add(ScrollPast(prog,
          key: ValueKey<int>(index), child: widget.children[index]));
    }
    list.add(SizedBox(
      width: Device.width,
      height: constraints.maxHeight,
    ));

    int index = (rOffset + .5).toInt();
    double extra = (rOffset + .5) % 1;
    List<String> headers = [
      'Isaac Roberts Mobile',
      'Process',
      'Features',
      'Features',
      'Features',
      'Experience',
      'Experience',
      'Experience',
      'TODO',
      'OOB1',
    ];

    String value = index < headers.length - 1 ? headers[index] : 'OOB+';

    if (extra > .8 && headers[index + 1] != headers[index]) {
      value = '//';
    } else {
      value = '//$value:';
    }
//TODO: Move this to a stateful object, copy the TypAT code, and edit it to use commands

    list.add(AnimatedTextKit(
        key: Key(value),
        isRepeatingAnimation: false,
        animatedTexts: [
          TypewriterAnimatedText(value, textStyle: fonts.displayMedium)
        ]));
    // const ScrollAppBar(title: 'SDF')
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        controller: controller,
        child: LayoutBuilder(builder: (context, constraints) {
          return Scrollable(
              controller: controller,
              viewportBuilder: (c, o) {
                double H = constraints.maxHeight * 2;

                final oldOffset = offset;
                if (this.constraints != constraints) {
                  this.constraints = constraints;
                  offset = o;
                  offset!.applyViewportDimension(constraints.maxHeight);
                  offset!.applyContentDimensions(
                      0, H * (widget.children.length - 1));
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    setState(() {});
                  });
                }
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  if (oldOffset != o) {
                    if (oldOffset != null) {
                      _scrollableStackKey.currentState
                          ?._removeListener(oldOffset);
                    }

                    _scrollableStackKey.currentState?._addListener(o);
                  }
                });
                // return ScrollableStack(
                //   key: _scrollableStackKey,
                //   children: widget.children,
                // );
                double rOffset = (offset?.pixels ?? 0) / H;
                log('rOff: $rOffset');

                return Stack(
                    fit: StackFit.expand,
                    alignment: Alignment.topLeft,
                    // key: const Key('stack'),
                    children: stackChildren(rOffset, constraints));
              });
        }));
  }
}

/*
class ScrollableStack extends StatefulWidget {
  final List<Widget> children;
  const ScrollableStack({super.key, required this.children});

  @override
  State<ScrollableStack> createState() => _ScrollableStackState();
}
*/
