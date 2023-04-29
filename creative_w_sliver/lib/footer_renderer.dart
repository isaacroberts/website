import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;

import 'device.dart';

class SliverFooter extends SingleChildRenderObjectWidget {
  /// Creates a sliver that fills the remaining space in the viewport.
  const SliverFooter({
    super.key,
    super.child,
  });

  @override
  RenderSliverFooter createRenderObject(BuildContext context) =>
      RenderSliverFooter();
}

// const double footerHeight = 200;

class RenderSliverFooter extends RenderSliverSingleBoxAdapter {
  /// Creates a [RenderSliver] that wraps a [RenderBox] which is sized to fit
  /// the remaining space in the viewport.

  RenderSliverFooter({
    super.child,
  });

  @override
  void performLayout() {
    double footerHeight = math.max(350, Device.height / 3);
    // if (this.constraints.crossAxisExtent < 600) {
    //   // log('expanded footer height');
    //   footerHeight = 300;
    // } else {
    //   // log('footer width: ${this.constraints.crossAxisExtent}');
    // }

    final SliverConstraints constraints =
        this.constraints.copyWith(viewportMainAxisExtent: footerHeight);
    final double extent =
        constraints.remainingPaintExtent - math.min(constraints.overlap, 0.0);
    // log('extent: ${extent}');

    double height = extent; //math.min(200, extent);

    if (child != null) {
      child!.layout(constraints.asBoxConstraints(
        minExtent: height,
        maxExtent: height,
      ));
    }

    final double paintedChildSize =
        calculatePaintOffset(constraints, from: 0.0, to: extent);
    assert(paintedChildSize.isFinite);
    assert(paintedChildSize >= 0.0);
    geometry = SliverGeometry(
      scrollExtent: constraints.viewportMainAxisExtent,
      paintExtent: paintedChildSize,
      maxPaintExtent: paintedChildSize,
      hasVisualOverflow: extent > constraints.remainingPaintExtent ||
          constraints.scrollOffset > 0.0,
    );
    // log('geom ${geometry!.toString()}');

    if (child != null) {
      setChildParentData(child!, constraints, geometry!);
    }
  }
}
