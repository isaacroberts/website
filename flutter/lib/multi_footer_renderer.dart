import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;

import 'package:isaac_roberts_consulting/signup_form.dart';

import 'footer.dart';

/*

I think RenderCustomMultiChildLayoutBox isthe way to go for the object

I don't know what the main one is supposed yo be. Possible I need a MulitiChildRenderObjectWidget with 3 SingleChildLayoutBox children.

 */

class MultiSliverFooter extends MultiChildRenderObjectWidget {
  /// Creates a sliver that fills the remaining space in the viewport.
  const MultiSliverFooter({
    super.key,
  });

  @override
  RenderMultiSliverFooter createRenderObject(BuildContext context) =>
      RenderMultiSliverFooter();
}

// const double footerHeight = 200;

enum _Slot {
  signup,
  footer,
  bgImage,
}

class MultiFooterDelegate extends SliverGridDelegate {
  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    // TODO: implement getLayout
    throw UnimplementedError();
  }

  @override
  bool shouldRelayout(covariant SliverGridDelegate oldDelegate) {
    // TODO: implement shouldRelayout
    throw UnimplementedError();
  }
}

class MultiFooterManager extends RenderSliverBoxChildManager {
  @override
  // TODO: implement childCount
  int get childCount => 3;

  List<RenderBox> children = [];

  @override
  void createChild(int index, {required RenderBox? after}) {
    // children.add(RenderBox(child: SignupForm()));
  }

  @override
  void didAdoptChild(RenderBox child) {
    // TODO: implement didAdoptChild
  }

  @override
  double estimateMaxScrollOffset(SliverConstraints constraints,
      {int? firstIndex,
      int? lastIndex,
      double? leadingScrollOffset,
      double? trailingScrollOffset}) {
    // TODO: implement estimateMaxScrollOffset
    throw UnimplementedError();
  }

  @override
  void removeChild(RenderBox child) {
    // TODO: implement removeChild
  }

  @override
  void setDidUnderflow(bool value) {
    // TODO: implement setDidUnderflow
  }
}

class RenderMultiSliverFooter extends RenderSliverGrid {
  /// Creates a [RenderSliver] that wraps a [RenderBox] which is sized to fit
  /// the remaining space in the viewport.

  RenderMultiSliverFooter()
      : super(
            gridDelegate: MultiFooterDelegate(),
            childManager: MultiFooterManager());

  // SignupForm signupForm = const SignupForm();
  // Footer footer = const Footer();
  // LoneSignupImage bgImage = const LoneSignupImage();

  // RenderBox? get signupForm => children[];
  // RenderBox? get footer => getChildrenAsList()[1];
  // RenderBox? get bgImage => getChildrenAsList()[2];

  @override
  void performLayout() {
    RenderBox? signupForm = firstChild;

    if (signupForm == null) {
      return;
    }
    RenderBox? footer = childAfter(signupForm);
    if (footer == null) {
      return;
    }
    RenderBox? bgImage = childAfter(footer);

    // const double signupFormHeight = 400;
    // const double footerMinHeight = 200;
    //
    // final double screenHeight = this.constraints.viewportMainAxisExtent;
    // double footerHeight =
    //     (screenHeight - signupFormHeight) / 2 + signupFormHeight;
    // footerHeight = math.max(footerHeight, signupFormHeight + footerMinHeight);
    double footerHeight = 200;

    if (this.constraints.crossAxisExtent < 600) {
      // log('expanded footer height');
      footerHeight += 100;
    } else {
      // log('footer width: ${this.constraints.crossAxisExtent}');
    }

    final SliverConstraints constraints =
        this.constraints.copyWith(viewportMainAxisExtent: footerHeight);
    final double extent =
        constraints.remainingPaintExtent - math.min(constraints.overlap, 0.0);
    // log('extent: ${extent}');

    double height = extent; //math.min(200, extent);

    if (footer != null) {
      (footer).layout(constraints.asBoxConstraints(
        minExtent: height,
        maxExtent: height,
      ));
    }

    final double paintedChildSize =
        calculatePaintOffset(constraints, from: 0.0, to: extent);
    assert(paintedChildSize.isFinite);
    assert(paintedChildSize >= 0.0);
    SliverGeometry footerGeometry = SliverGeometry(
      scrollExtent: constraints.viewportMainAxisExtent,
      paintExtent: paintedChildSize,
      maxPaintExtent: paintedChildSize,
      hasVisualOverflow: extent > constraints.remainingPaintExtent ||
          constraints.scrollOffset > 0.0,
    );
    // log('geom ${geometry!.toString()}');

    if (footer != null) {
      setChildParentData(footer!, constraints, footerGeometry);
    }
  }

  @protected
  void setChildParentData(RenderObject child, SliverConstraints constraints,
      SliverGeometry geometry) {
    final SliverPhysicalParentData childParentData =
        child.parentData! as SliverPhysicalParentData;
    switch (applyGrowthDirectionToAxisDirection(
        constraints.axisDirection, constraints.growthDirection)) {
      case AxisDirection.up:
        childParentData.paintOffset = Offset(
            0.0,
            -(geometry.scrollExtent -
                (geometry.paintExtent + constraints.scrollOffset)));
      case AxisDirection.right:
        childParentData.paintOffset = Offset(-constraints.scrollOffset, 0.0);
      case AxisDirection.down:
        childParentData.paintOffset = Offset(0.0, -constraints.scrollOffset);
      case AxisDirection.left:
        childParentData.paintOffset = Offset(
            -(geometry.scrollExtent -
                (geometry.paintExtent + constraints.scrollOffset)),
            0.0);
    }
  }
}

/*

typedef ManagedListElement = Widget;

class MyMultiRendererManager extends RenderSliverBoxChildManager {
  @override
  // TODO: implement childCount
  int get childCount => 3;
  List<ManagedListElement> slivers = [];

  get signupForm => slivers[0];
  get footer => slivers[1];
  get bgImage => slivers[2];

  void _addAfter(ManagedListElement? sliver, {required RenderBox? after}) {
    if (sliver != null) {
      //TODO: Fix add-after
      // if (after != null) {
      //   int ix = slivers.indexOf(after);
      //   if (ix!=-1)
      //     slivers.insert(ix+1, sliver);
      //   else
      //     slivers.add(sliver);
      // }
      // else {
      slivers.add(sliver);
      // }
    }
  }

  @override
  void createChild(int index, {required RenderBox? after}) {
    if (index == 0) {
      _addAfter(const SignupForm(), after: after);
    } else if (index == 1) {
      _addAfter(const Footer(), after: after);
    } else if (index == 2) {
      _addAfter(const LoneSignupImage(), after: after);
    }
  }

  @override
  void didAdoptChild(RenderBox child) {
    // TODO: implement didAdoptChild
  }

  @override
  double estimateMaxScrollOffset(SliverConstraints constraints,
      {int? firstIndex,
      int? lastIndex,
      double? leadingScrollOffset,
      double? trailingScrollOffset}) {
    return 700;
  }

  @override
  void removeChild(RenderBox child) {
    // TODO: implement removeChild
  }

  @override
  void setDidUnderflow(bool value) {
    // TODO: implement setDidUnderflow
  }
}
class RenderMultiSliverFooter extends RenderSliverMultiBoxAdaptor {
  /// Creates a [RenderSliver] that wraps a [RenderBox] which is sized to fit
  /// the remaining space in the viewport.
  late MyMultiRendererManager manager;

  RenderMultiSliverFooter() : super(childManager: MyMultiRendererManager()) {
    manager = childManager as MyMultiRendererManager;
  }

  @override
  void performLayout() {
    // const double signupFormHeight = 400;
    // const double footerMinHeight = 200;
    //
    // final double screenHeight = this.constraints.viewportMainAxisExtent;
    // double footerHeight =
    //     (screenHeight - signupFormHeight) / 2 + signupFormHeight;
    // footerHeight = math.max(footerHeight, signupFormHeight + footerMinHeight);
    double footerHeight = 200;

    if (this.constraints.crossAxisExtent < 600) {
      // log('expanded footer height');
      footerHeight += 100;
    } else {
      // log('footer width: ${this.constraints.crossAxisExtent}');
    }

    final SliverConstraints constraints =
        this.constraints.copyWith(viewportMainAxisExtent: footerHeight);
    final double extent =
        constraints.remainingPaintExtent - math.min(constraints.overlap, 0.0);
    // log('extent: ${extent}');

    double height = extent; //math.min(200, extent);

    if (manager.footer != null) {
      manager.footer!.layout(constraints.asBoxConstraints(
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

    // if (manager.footer != null) {
    //   setChildParentData(manager.footer!, constraints, geometry!);
    // }
  }
}
*/
