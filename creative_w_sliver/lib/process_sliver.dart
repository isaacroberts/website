import 'dart:math' as math;

import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'device.dart';

class ProcessSliver extends SingleChildRenderObjectWidget {
  /// Creates a sliver that fills the remaining space in the viewport.
  const ProcessSliver({super.key, super.child});

  @override
  ProcessSliverRenderer createRenderObject(BuildContext context) =>
      ProcessSliverRenderer();
}

class ProcessSliverRenderer extends RenderSliverToBoxAdapter {
  int opacity = 0;
  double t = 0;
  double pageWidth = 0, pageHeight = 0;
  ProcessSliverRenderer();

  @override
  void performLayout() {
    if (this.child == null) {
      return;
    }

    RenderBox child = this.child!;

    final SliverConstraints constraints = this.constraints;
    double dh = constraints.viewportMainAxisExtent;
    double w = constraints.crossAxisExtent;

    child.layout(BoxConstraints(minWidth: w, maxWidth: w, minHeight: dh),
        parentUsesSize: true);

    double h = child.size.height;

    pageWidth = w;
    pageHeight = h;

    // log('child h : $h');
    const double spacing = 500;

    double widgetOverflow = h - dh;
    // log('h $h dh $dh');
    double maxExtent = h + spacing;
    double paintOffset;

    double scrPos = constraints.scrollOffset;
    double relPos = (scrPos).toDouble() / dh;

    double heightTraversal = 0;

    // if (scrPos > 0) {
    //   heightTraversal = -scrPos;
    //   if (heightTraversal > widgetOverflow) {
    //     heightTraversal = widgetOverflow;
    //     relPos = (scrPos - widgetOverflow) / dh;
    //   } else {
    //     relPos = 0;
    //   }
    // }

    // if (relPos < -1) return;
    if (relPos > 1) {
      geometry = SliverGeometry(
        visible: false,
        scrollExtent: maxExtent,
        paintOrigin: -dh * 2,
        paintExtent: 0,
        maxPaintExtent: h,
      );
      return;
    }

    if (relPos < 0) {
      //Before its entered
      paintOffset = -(relPos * relPos) * dh;
    } else if (relPos == 0) {
      //Focused on-screen
      paintOffset = heightTraversal;
      //paintOffset := widgetOverflow
    } else {
      relPos = (scrPos - widgetOverflow) / dh;
      //As its leaving

      paintOffset = heightTraversal - (math.sqrt(relPos.abs())) * dh;
    }
    paintOffset = 0;
    opacity = (255 * 2 * (1 - relPos)).toInt();

    if (opacity < 0) opacity = 0;
    if (opacity > 255) opacity = 255;

    t = clampDouble(relPos, 0, 1);

    // child.applyPaintTransform(child, _effectiveTransform);

    final double paintExtent =
        clampDouble(h + paintOffset, 0.0, constraints.remainingPaintExtent);

    // if (paintOffset + paintExtent > constraints.remainingPaintExtent) {
    //   log('paint overflow paintOffset $paintOffset extent $paintExtent remaining ${constraints.remainingPaintExtent}');
    // }

    geometry = SliverGeometry(
      scrollExtent: maxExtent,
      paintOrigin: paintOffset,

      paintExtent: paintExtent,
      layoutExtent: 0,
      maxPaintExtent: h,
      hasVisualOverflow:
          true, // Conservatively say we do have overflow to avoid complexity.
    );
    // _childPosition = updateGeometry();
  }

  Matrix4 get _effectiveTransform {
    // return Matrix4.rotationX(t * math.pi);
    // .multiplied(
    // var mat = Matrix4.translationValues(
    //     t * -(math.max(Device.width - 200, 200)), -t * 50, 0);
    Matrix4 mat;
    if (pageWidth > pageHeight) {
      mat =
          Matrix4.translationValues(t * -pageWidth, t * -pageHeight / 2, t * 1);
      // var mat = Matrix4.identity();
      mat.multiply(Matrix4.rotationZ(-t * math.pi / 2));
      // mat.multiply(Matrix4.translationValues(0, t * 500, 0));
    } else {
      mat = Matrix4.translationValues(t * -200, t * -0, t);
      // mat = Matrix4.identity();
      mat.multiply(Matrix4.rotationZ(-t * math.pi / 2));
    }
    return mat;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      final Matrix4 transform = _effectiveTransform;

      // final Offset? childOffset = MatrixUtils.getAsTranslation(transform);
      // if (childOffset == null) {
      // if the matrix is singular the children would be compressed to a line or
      // single point, instead short-circuit and paint nothing.
      final double det = transform.determinant();
      if (det == 0 || !det.isFinite) {
        layer = null;
        return;
      }
      layer = context.pushTransform(
        needsCompositing,
        offset,
        transform,
        super.paint,
        oldLayer: layer is TransformLayer ? layer as TransformLayer? : null,
      );
      // } else {
      //   super.paint(context, offset + childOffset);
      //   layer = null;
      // }
    }
  }

  @override
  void applyPaintTransform(RenderBox child, Matrix4 transform) {
    transform.multiply(_effectiveTransform);
  }

  // @override
  // bool get needsCompositing => opacity < 255 && opacity > 0;
}
