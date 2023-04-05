import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;

import 'device.dart';

class LockScrollSliver extends SingleChildRenderObjectWidget {
  const LockScrollSliver({required super.child, super.key});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _LockScrollSliver();
  }

  // @override
  // void updateRenderObject(
  //     BuildContext context, _LockScrollSliver renderObject) {
  //   // renderObject.mainAxisExtent = mainAxisExtent;
  // }
}

class _LockScrollSliver extends RenderSliverSingleBoxAdapter {
  _LockScrollSliver();

  double crossAxisOffset = 0;

  @override
  double childCrossAxisPosition(covariant RenderObject child) => 0.0;

  // @override
  // double get centerOffsetAdjustment => 0.33;

  @override
  void performLayout() {
    final SliverConstraints constraints = this.constraints;
    // final double extent =
    //     constraints.remainingPaintExtent - math.min(constraints.overlap, 0.0);
    // log('extent: ${extent}');

    // double height = extent; //math.min(200, extent);
    RenderBox? child = this.child;

    if (child == null) {
      log('null child');
      geometry = SliverGeometry.zero;
      return;
    } else {
      child.layout(
          constraints
              .asBoxConstraints(
                  // maxExtent: Device.height - topMargin - botMargin,
                  )
              .copyWith(maxWidth: double.infinity),
          parentUsesSize: true);

      double height = constraints.axis == Axis.vertical
          ? child.size.height
          : child.size.width;
      double width = constraints.axis == Axis.vertical
          ? child.size.width
          : child.size.height;

      double scrollRate = 1;
      double extraW = width - constraints.crossAxisExtent;

      //TODO: Add top, add stop at end
      // log('extraW: $extraW $width ${constraints.crossAxisExtent}');
      final double containerHeight = height + extraW * scrollRate;

      // double remainingSpace = containerHeight -
      //     constraints.scrollOffset; //constraints.remainingPaintExtent - height;
      const double topMargin = 100;
      // double curPosition = constraints.scrollOffset;
      double curPosition = constraints.scrollOffset;
      // (constraints.viewportMainAxisExtent - height) +
      // topMargin;

      curPosition = math.max(0, curPosition);

      //If userScrollDirection = up; return normal

      if (extraW < 0) {
        extraW = 0;
        crossAxisOffset = -extraW / 2;
      } else {
        crossAxisOffset = math.min(curPosition / scrollRate, extraW);
      }

      // log('curPosition: $curPosition ');

      double paintedChildSize = calculatePaintOffset(constraints,
          from: math.min(curPosition, containerHeight),
          to: math.min(curPosition + height, containerHeight));

      // curPosition = 10;

      // log('view height ${constraints.viewportMainAxisExtent} containerHeight $containerHeight rpe ${constraints.remainingPaintExtent}  height $height');

      // double rhs = height + remainingSpace;

      // double paintExtent = math.min(height, constraints.remainingPaintExtent);
      // paintExtent = math.min(paintExtent, remainingSpace - height);
      // paintExtent = math.max(paintExtent, 0);
      // containerHeight = math.max(containerHeight, 0);
      // paintedChildSize = math.min(remainingSpace + height, paintedChildSize);
      // paintedChildSize = math.max(paintedChildSize, 0);
      assert(paintedChildSize.isFinite);
      assert(paintedChildSize >= 0.0);

      // log('paintedChildSize= $paintedChildSize');
      geometry = SliverGeometry(
        // layoutExtent: paintedChildSize,
        // paintOrigin: topMargin,
        scrollExtent: containerHeight,

        paintExtent: paintedChildSize,
        cacheExtent: height,
        maxPaintExtent: height,
        hitTestExtent: paintedChildSize,
        hasVisualOverflow: height > constraints.remainingPaintExtent ||
            constraints.scrollOffset > 0.0,
      );

      SliverConstraints cc = constraints.copyWith(
        scrollOffset:
            math.max(0, constraints.scrollOffset - containerHeight + height),
        remainingPaintExtent: height,
        viewportMainAxisExtent: height,
      );
      // log('geom ${geometry!.toString()}');

      setChildParentData(child, cc, geometry!);
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null && geometry!.visible) {
      offset += Offset(-crossAxisOffset, 0);
      final SliverPhysicalParentData childParentData =
          child!.parentData! as SliverPhysicalParentData;
      context.paintChild(child!, offset + childParentData.paintOffset);
    }
  }
}
