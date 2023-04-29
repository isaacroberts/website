import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:isaac_roberts_consulting/custom_layouts.dart';
import 'device.dart';

/*
Inherits Stateful widget
  -- animation<double> entry, exit
  -- inputs String nextPage
  -- inputs animation style later on

InheritedWidget with copies of all its data
  -- getAnimation()

*/

class SlightScroll extends FlowDelegate {
  final double scrollAmt;
  SlightScroll(this.scrollAmt);

  @override
  void paintChildren(FlowPaintingContext context) {
    for (int c = 0; c < context.childCount; ++c) {
      context.paintChild(
        c,
        transform:
            Transform.translate(offset: Offset(0.0, 10 * scrollAmt)).transform,
      );
    }
  }

  @override
  bool shouldRepaint(covariant SlightScroll oldDelegate) {
    return (scrollAmt != oldDelegate.scrollAmt);
  }
}

class PushedScroll extends Scrollable {
  final Widget child;

  PushedScroll(this.child, {super.key})
      : super(
            excludeFromSemantics: true,
            viewportBuilder: (context, offset) {
              double p = offset.pixels;
              return LayoutBuilder(builder: (context, constraints) {
                return Flow(delegate: SlightScroll(p), children: [
                  SizedBox(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight, // + initialScroll * 2,
                      child: child)
                ]);
              });
            });
}

class FullScreenPage extends StatefulWidget {
  final String? nextPage;
  final Widget child;
  const FullScreenPage({Key? key, this.nextPage, required this.child})
      : super(key: key);

  @override
  State<FullScreenPage> createState() => _FullScreenPageState();
}

const double initialScroll = 10;

class _FullScreenPageState extends State<FullScreenPage> {
  late ScrollController _scrollController;

  double _scrollAmt = 0;

  @override
  void initState() {
    _scrollAmt = 0;
    _scrollController = ScrollController(initialScrollOffset: initialScroll);

    // if (widget.nextPage != null) {
    _scrollController.addListener(_scrollListener);
    // }

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrolled(double p) {
    // scrollAmt = p;
    if (p >= initialScroll * .95) {
      _scrollUp();
    } else if (p <= -initialScroll * .95) {
      _scrollDown();
    }
  }

  set scrollAmt(double set) {
    if (set != _scrollAmt) {
      log('scroll= $set');
      setState(() {
        _scrollAmt = set;
      });
      _scrolled(_scrollAmt);
    }
  }

  void _scrollUp() {
    // _scrollController.animateTo(initialScroll,
    //     duration: const Duration(milliseconds: 150), curve: Curves.linear);

    // _scrollController.jumpTo(0);
    // var nav = Navigator.of(context);
    Navigator.of(context).maybePop();
    _scrollAmt = 0;
  }

  void _scrollDown() {
    // _scrollController.animateTo(initialScroll,
    //     duration: const Duration(milliseconds: 150), curve: Curves.linear);
    String? n = widget.nextPage;
    if (n != null) {
      Navigator.of(context).pushNamed(
        n,
      );
      _scrollAmt = 0;
      // _scrollController.jumpTo(0);
    }
  }

  void _scrollListener() {
    double p = -(_scrollController.position.pixels - initialScroll);
    _scrolled(p);
    // scrollAmt = p;
  }

  @override
  Widget build(BuildContext context) {
    // return NotificationListener<ScrollNotification>(
    //     onNotification: (ScrollNotification scroll) {
    //       double pixels = scroll.metrics.pixels;
    //       log('scrolled $pixels');
    //       scrollAmt = pixels;
    //       return true;
    //     },
    //     child:
    //         Flow(delegate: SlightScroll(_scrollAmt), children: [widget.child]));
    // return LayoutBuilder(builder: (context, constraints) {
    //   return GestureDetector(
    //       onTap: _scrollDown,
    //       onPanUpdate: (details) => scrollAmt = details.delta.dy,
    //       onVerticalDragUpdate: (details) => scrollAmt = details.delta.dy,
    //       child: scrollView(constraints));
    // });

    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        // const SliverAppBar(
        //   title: Text('//--'),
        //   flexibleSpace: FlexibleSpaceBar(),
        // ),
        SliverToBoxAdapter(
            child: SizedBox(
                width: Device.width,
                height: Device.height, // + initialScroll * 2,
                child: widget.child)),
        SliverFillRemaining()
      ],
    );

    // return scrollView();
    return Listener(
        onPointerPanZoomUpdate: (details) => scrollAmt = details.distance,
        onPointerHover: (details) {
          // log('hover ${details.distance}');
        },
        child: scrollView());
    return GestureDetector(
        onPanStart: (details) => log('pan start $details'),
        onTap: _scrollDown,
        onPanUpdate: (details) => scrollAmt = details.delta.dy,
        onVerticalDragUpdate: (details) => scrollAmt = details.delta.dy,
        child: Listener(
            onPointerPanZoomUpdate: (details) => scrollAmt = details.delta.dy,
            child: scrollView()));

    // return GestureDetector(
    //     onPanUpdate: (details) => __scrolled(-details.delta.dy),
    //     onVerticalDragUpdate: (details) => __scrolled(-details.delta.dy),
    //     child: widget.child);
  }

  Widget scrollView() {
    return LayoutBuilder(builder: (context, constraints) {
      return Flow(delegate: SlightScroll(_scrollAmt), children: [
        SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight, // + initialScroll * 2,
            child: widget.child)
      ]);
    });
    // return PushedScroll(widget.child);
    // return SingleChildScrollView(
    //         // controller: _scrollController,
    //         physics: AlwaysScrollableScrollPhysics(),
    //         child: SizedBox(
    //             width: constraints.maxWidth,
    //             height: constraints.maxHeight, // + initialScroll * 2,
    //             child: Flow(delegate: SlightScroll(_scrollAmt), children: [
    //               SizedBox(
    //                   width: constraints.maxWidth,
    //                   height: constraints.maxHeight, // + initialScroll * 2,
    //                   child: widget.child)
    //             ])));
  }
}
