import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'common_elements.dart';
import 'device.dart';
import 'theme.dart';

class PixelParallaxDelegate extends FlowDelegate {
  final double pixelsPerPixel;

  PixelParallaxDelegate(
      {required this.scrollable,
      required this.listItemContext,
      required this.backgroundImageKey,
      double? distance})
      : pixelsPerPixel = 1 - 1 / ((distance ?? 1.333)),
        super(repaint: scrollable.position) {
    assert(distance! > 0);
  }

  final ScrollableState scrollable;
  final BuildContext listItemContext;
  final GlobalKey backgroundImageKey;

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints.tightFor(
      width: constraints.maxWidth,
    );
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    // Calculate the position of this list item within the viewport.

    final RenderObject? listItemBox = listItemContext.findRenderObject();

    double scrollAmt;
    if (listItemBox == null) {
      log('null listItemBox in parallax');
      scrollAmt = 0;
    } else if (listItemBox is RenderBox) {
      final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
      final listItemOffset = listItemBox.localToGlobal(
          listItemBox.size.topLeft(Offset.zero),
          ancestor: scrollableBox);

      // final listItemSize = context.size;

      // final viewportDimension = scrollable.position.viewportDimension;
      scrollAmt = (listItemOffset.dy);
    } else if (listItemBox is RenderSliver) {
      log('untested PixelParallaxDelegate on RenderSliver');
      final scrollOffset = listItemBox.geometry?.scrollExtent ?? 0;
      final pos = scrollable.position.extentBefore +
          scrollable.position.extentInside / 2;
      scrollAmt = pos - scrollOffset;
    } else {
      log('unrecognized listItemBox type in PixelParallaxDelegate ${listItemBox.runtimeType}');
      scrollAmt = 0;
    }
    context.paintChild(
      0,
      transform: Transform.translate(
              offset: Offset(0.0, (appBar - scrollAmt) * pixelsPerPixel))
          .transform,
    );
  }

  @override
  bool shouldRepaint(PixelParallaxDelegate oldDelegate) {
    return scrollable != oldDelegate.scrollable ||
        listItemContext != oldDelegate.listItemContext ||
        backgroundImageKey != oldDelegate.backgroundImageKey;
  }
}

class RelativeParallaxDelegate extends FlowDelegate {
  final double distance;

  RelativeParallaxDelegate(
      {required this.scrollable,
      required this.listItemContext,
      required this.backgroundImageKey,
      double? distance})
      : distance = distance ?? 1,
        super(repaint: scrollable.position);

  final ScrollableState scrollable;
  final BuildContext listItemContext;
  final GlobalKey backgroundImageKey;

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    // log('getConstraints $constraints');
    double height = constraints.maxHeight;

    return BoxConstraints(
        minWidth: constraints.maxWidth,
        maxWidth: constraints.maxWidth,
        minHeight: height * distance);
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    // Calculate the position of this list item within the viewport.

    final RenderObject? listItemBox = listItemContext.findRenderObject();

    if (listItemBox == null) {
      log('null listItemBox in parallax');
    } else if (listItemBox is RenderBox) {
      final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
      final listItemOffset = listItemBox.localToGlobal(
          listItemBox.size.topLeft(Offset.zero),
          ancestor: scrollableBox);

      final listItemSize = context.size;
      // log('size: $listItemSize');

      // Determine the percent position of this list item within the
      // scrollable area.
      final viewportDimension = scrollable.position.viewportDimension;
      final scrollFraction = ((listItemOffset.dy + listItemSize.height) /
              (viewportDimension + listItemSize.height))
          .clamp(0.0, 1.0);

      // log('scrol Frac: $scrollFraction');

      // Calculate the vertical alignment of the background
      // based on the scroll percent.
      final verticalAlignment = Alignment(0.0, scrollFraction * 2 - 1);
      // log(' ${listItemOffset.dy}  = $verticalAlignment');
      // log('box relpar $verticalAlignment');
      // Convert the background alignment into a pixel offset for
      // painting purposes.
      // log('bg context ${backgroundImageKey.currentContext}');
      // final backgroundSize =
      //     (backgroundImageKey.currentContext!.findRenderObject() as RenderBox)
      //         .size;

      double overshoot = distance;

      Size backgroundSize =
          Size(listItemSize.width, listItemSize.height * overshoot);

      final childRect = verticalAlignment.inscribe(
          backgroundSize, Offset.zero & listItemSize);

      // log('\t\tsize $backgroundSize    rect  $childRect');
      // log('bgKey box $backgroundImageKey context ${backgroundImageKey.currentContext}');

      // Paint the background.
      double transform = childRect.top;
      context.paintChild(
        0,
        transform:
            Transform.translate(offset: Offset(0.0, transform)).transform,
      );
    } else if (listItemBox is RenderSliver) {
      final listItemSize = context.size;

      final scrollOffset = listItemBox.geometry?.scrollExtent ?? 0;
      final pos = scrollable.position.extentBefore +
          scrollable.position.extentInside / 2;
      final offset = pos - scrollOffset;
      // Determine the percent position of this list item within the
      // scrollable area.
      final viewportDimension =
          scrollable.position.viewportDimension + listItemSize.height;
      final scrollFraction = (offset / viewportDimension).clamp(0.0, 1.0);
      // Calculate the vertical alignment of the background
      // based on the scroll percent.
      final verticalAlignment = Alignment(0.0, -scrollFraction * 2 + 1);
      // Convert the background alignment into a pixel offset for
      // painting purposes.
      // log('sliver relpar $verticalAlignment');
      Size backgroundSize =
          Size(listItemSize.width, (distance) * listItemSize.height);
      // if (backgroundImageKey.currentContext == null) {
      //   backgroundSize = Size(listItemSize.width, distance * listItemSize.height);
      // } else {
      //   backgroundSize =
      //       (backgroundImageKey.currentContext!.findRenderObject() as RenderBox)
      //           .paintBounds
      //           .size;
      // }
      final childRect = verticalAlignment.inscribe(
          backgroundSize, Offset.zero & listItemSize);
      // final childRect = Offset.zero & listItemSize;
      // Paint the background.

      context.paintChild(
        0,
        transform:
            Transform.translate(offset: Offset(0.0, childRect.top)).transform,
      );
    }
  }

  @override
  bool shouldRepaint(RelativeParallaxDelegate oldDelegate) {
    return scrollable != oldDelegate.scrollable ||
        listItemContext != oldDelegate.listItemContext ||
        backgroundImageKey != oldDelegate.backgroundImageKey;
  }
}

class ParallaxImage extends StatefulWidget {
  final String image;
  final double? opacity;
  final String? debugLabel;
  final double distance;
  //ParallaxImage(image: , opacity: 1, debugLabel: )
  const ParallaxImage(
      {required this.image,
      this.opacity,
      double? distance,
      this.debugLabel,
      Key? key})
      : distance = distance ?? 5,
        super(key: key);

  @override
  State<ParallaxImage> createState() => _ParallaxImageState();
}

class _ParallaxImageState extends State<ParallaxImage> {
  late GlobalKey _backgroundImageKey;

  @override
  void initState() {
    _backgroundImageKey = GlobalKey(debugLabel: widget.debugLabel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double? op = widget.opacity;

    final delegate = PixelParallaxDelegate(
      scrollable: Scrollable.of(context),
      listItemContext: context,
      backgroundImageKey: _backgroundImageKey,
      distance: widget.distance,
    );

    return Flow(delegate: delegate, children: [
      ConstrainedBox(
          constraints: BoxConstraints(
              minHeight: (Device.height) * delegate.pixelsPerPixel),
          child: (op != null)
              ? Opacity(
                  opacity: op,
                  child: fadeAssetBg(widget.image, fit: BoxFit.fitHeight))
              : fadeAssetBg(widget.image, fit: BoxFit.fitHeight))
    ]);
  }
}

class ParallaxImageFromProvider extends StatefulWidget {
  final ImageProvider image;
  final double? opacity;
  final String? debugLabel;
  final double distance;
  //ParallaxImage(image: , opacity: 1, debugLabel: )
  const ParallaxImageFromProvider(
      {required this.image,
      this.opacity,
      double? distance,
      this.debugLabel,
      Key? key})
      : distance = distance ?? 2,
        super(key: key);

  @override
  State<ParallaxImageFromProvider> createState() =>
      _ParallaxImageFromProviderState();
}

class _ParallaxImageFromProviderState extends State<ParallaxImageFromProvider> {
  late GlobalKey _backgroundImageKey;

  @override
  void initState() {
    _backgroundImageKey = GlobalKey(debugLabel: widget.debugLabel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double? op = widget.opacity;

    final delegate = PixelParallaxDelegate(
      scrollable: Scrollable.of(context),
      listItemContext: context,
      backgroundImageKey: _backgroundImageKey,
      distance: widget.distance,
    );

    return Flow(delegate: delegate, children: [
      ConstrainedBox(
          constraints: BoxConstraints(
              minHeight: (Device.height) * delegate.pixelsPerPixel),
          child: Image(
              image: widget.image,
              opacity: op != null ? AlwaysStoppedAnimation<double>(op) : null,
              fit: BoxFit.cover))
    ]);
  }
}
