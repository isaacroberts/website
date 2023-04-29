import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'device.dart';
import 'theme.dart';
import 'common_elements.dart';
import 'dart:math' as math;

class PageSliverWrap extends StatelessWidget {
  final Widget child;
  const PageSliverWrap({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return PageSliver(
        child: LayoutBuilder(
            builder: (context, constraints) => SizedBox(
                width: Device.width, height: Device.height, child: child)));

    return PageSliver(
        child: Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.white)),
            child: SizedBox(
                width: Device.width, height: Device.height, child: child)));
  }
}

class PageSliver extends SingleChildRenderObjectWidget {
  /// Creates a sliver that fills the remaining space in the viewport.
  const PageSliver({super.key, super.child});

  @override
  PageSliverRenderer createRenderObject(BuildContext context) =>
      PageSliverRenderer();
}

class PageSliverRenderer extends RenderSliverToBoxAdapter {
  double yOffset = 0;

  PageSliverRenderer();

  @override
  void performLayout() {
    if (this.child == null) {
      log('no child');
      return;
    }

    String pr(double num) {
      String str = num.toStringAsFixed(2);
      if (str.startsWith('-0')) {
        str = '-${str.substring(2)}';
      } else {
        while (str.startsWith('0')) {
          str = str.substring(1);
        }
        str = ' $str';
      }
      return str;
    }

    SliverAppBar;
    RenderBox child = this.child!;

    final SliverConstraints constraints = this.constraints;
    double dh = constraints.viewportMainAxisExtent;
    double w = constraints.crossAxisExtent;
    // TODO: Safely remove maxHeight so experience column can be longer if it wants
    child.layout(BoxConstraints(minWidth: w, maxWidth: w, minHeight: dh),
        parentUsesSize: true);
    double h = child.size.height;
    const double spacing = 500;

    double widgetOverflow = h - dh;
    double maxExtent = h + spacing;
    double paintOffset;

    double scrPos = constraints.scrollOffset;
    double relPos = (scrPos).toDouble() / dh;

    double heightTraversal = 0;

    if (scrPos > 0) {
      heightTraversal = -scrPos;
      if (heightTraversal > widgetOverflow) {
        heightTraversal = widgetOverflow;
        relPos = (scrPos - widgetOverflow) / dh;
      } else {
        relPos = 0;
      }
    }

    // if (relPos < -1) return;
    if (relPos > 1) {
      log('scroll pos = ${pr(scrPos / dh)} rel ${pr(relPos)}');
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

    //TODO: If offset is nonzero, this needs to rescale scrPos so that it transforms from (h) / (h-offset) or something like that

    final double paintExtent =
        clampDouble(h + paintOffset, 0.0, constraints.remainingPaintExtent);

    // if (paintOffset + paintExtent > constraints.remainingPaintExtent) {
    //   log('paint overflow paintOffset $paintOffset extent $paintExtent remaining ${constraints.remainingPaintExtent}');
    // }

    geometry = SliverGeometry(
      scrollExtent: maxExtent,
      paintOrigin: paintOffset,

      paintExtent: paintExtent,

      maxPaintExtent: h,
      hasVisualOverflow:
          true, // Conservatively say we do have overflow to avoid complexity.
    );
    // _childPosition = updateGeometry();
  }
}

class SignupSliver extends SingleChildRenderObjectWidget {
  /// Creates a sliver that fills the remaining space in the viewport.
  const SignupSliver({super.key, super.child});

  @override
  SignupSliverRenderer createRenderObject(BuildContext context) =>
      SignupSliverRenderer();
}

class SignupSliverRenderer extends RenderSliverToBoxAdapter {
  double yOffset = 0;

  SignupSliverRenderer();

  @override
  void performLayout() {
    if (this.child == null) {
      return;
    }

    String pr(double num) {
      String str = num.toStringAsFixed(2);
      if (str.startsWith('-0')) {
        str = '-${str.substring(2)}';
      } else {
        while (str.startsWith('0')) {
          str = str.substring(1);
        }
        str = ' $str';
      }
      return str;
    }

    SliverAppBar;
    RenderBox child = this.child!;

    final SliverConstraints constraints = this.constraints;
    double dh = constraints.viewportMainAxisExtent;
    double w = constraints.crossAxisExtent;
    // TODO: Safely remove maxHeight so experience column can be longer if it wants

    const double spacing = 500;

    double maxExtent = dh;

    double scrPos = constraints.scrollOffset;
    double relPos = (scrPos).toDouble() / dh;

    double h;

    if (relPos <= 0) {
      h = dh;
    } else if (relPos < 1) {
      h = dh * (1 - relPos);
    } else {
      h = 0;
      geometry = SliverGeometry(
        visible: false,
        scrollExtent: maxExtent,
        paintOrigin: 0,
        paintExtent: 0,
        maxPaintExtent: dh,
      );
      return;
    }

    child.layout(
        BoxConstraints(minWidth: w, maxWidth: w, minHeight: h, maxHeight: h),
        parentUsesSize: true);

    final double paintExtent =
        clampDouble(h, 0.0, constraints.remainingPaintExtent);

    geometry = SliverGeometry(
      scrollExtent: maxExtent,
      paintOrigin: 0,
      paintExtent: paintExtent,

      maxPaintExtent: h,
      hasVisualOverflow:
          true, // Conservatively say we do have overflow to avoid complexity.
    );
    // _childPosition = updateGeometry();
  }
}
