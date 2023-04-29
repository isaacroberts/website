import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isaac_roberts_consulting/parallax.dart';
import 'package:isaac_roberts_consulting/theme.dart';

import 'common_elements.dart';
import 'device.dart';
import 'dart:math' as math;

enum TextWithOptImgSlot { text, img }

class TextWithOptImgLayout extends MultiChildLayoutDelegate {
  @override
  void performLayout(Size size) {
    Size imgSize = Size.zero;
    Size textSize = Size.zero;

    if (!hasChild(TextWithOptImgSlot.img)) {
      textSize =
          layoutChild(TextWithOptImgSlot.text, BoxConstraints.loose(size));
      positionChild(TextWithOptImgSlot.text, const Offset(0, 0));
      return;
    } else if (!hasChild(TextWithOptImgSlot.text)) {
      assert(false, 'Custom TextWithOptImgLayout without text');
    }

    if (hasChild(TextWithOptImgSlot.img)) {
      imgSize = layoutChild(TextWithOptImgSlot.img, BoxConstraints.loose(size));
    }
    if (hasChild(TextWithOptImgSlot.text)) {
      Size remaining = Size(size.height, size.width - imgSize.width);
      textSize =
          layoutChild(TextWithOptImgSlot.text, BoxConstraints.loose(remaining));
      // positionChild(_Slot.text, Offset.zero);
    }

    if (textSize.height < size.height) {
      positionChild(TextWithOptImgSlot.text, const Offset(0, 0));
      positionChild(TextWithOptImgSlot.img, Offset(textSize.width, 0));
    } else {
      textSize =
          layoutChild(TextWithOptImgSlot.text, BoxConstraints.loose(size));
      positionChild(TextWithOptImgSlot.text, const Offset(0, 0));
    }
  }

  @override
  bool shouldRelayout(MultiChildLayoutDelegate oldDelegate) => false;
}

class FractionalLayout extends SingleChildLayoutDelegate {
  //Has passthrough size

  final double? widthFactor;
  final double? heightFactor;

  final double xPad;
  final double yPad;

  final Alignment alignment;

  FractionalLayout(
      {this.widthFactor,
      this.heightFactor,
      this.xPad = 0,
      this.yPad = 0,
      this.alignment = Alignment.topLeft}) {
    if (widthFactor != null) {
      assert(widthFactor! <= 1);
      assert(widthFactor! > 0);
    }
    if (heightFactor != null) {
      assert(heightFactor! <= 1);
      assert(heightFactor! > 0);
    }
  }

  @override
  Size getSize(BoxConstraints constraints) {
    double myWFrac = (widthFactor ?? (1 - xPad)) + xPad;
    double myHFrac = (heightFactor ?? (1 - yPad)) + yPad;

    double w = constraints.constrainWidth() * myWFrac;
    double h = constraints.constrainHeight() * myHFrac;
    return Size(w, h);
  }

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    double wf = widthFactor ?? (1 - xPad);
    double hf = heightFactor ?? (1 - yPad);

    return BoxConstraints(
        minWidth: constraints.minWidth * wf,
        minHeight: constraints.minHeight * hf,
        maxWidth: constraints.maxWidth * wf,
        maxHeight: constraints.maxHeight * hf);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return Offset(0, 0);
    // double xo = 0;
    // double yo = 0;
    //
    // if (alignment.x > 0) {}
  }

  @override
  bool shouldRelayout(covariant FractionalLayout oldDelegate) => false;
}

//Back sizes to contain front
enum InterlacedLayoutSlot { front, middle, back, bg, xtr }

//TODO: Remove & refactor
typedef Slot = InterlacedLayoutSlot;

class InterlacedLayout extends MultiChildLayoutDelegate {
  final double scroll;

  InterlacedLayout({required this.scroll});

  @override
  void performLayout(Size size) {
    double parallax = scroll;

    if (hasChild(Slot.bg)) {
      layoutChild(Slot.bg, BoxConstraints.tight(size));
      positionChild(Slot.bg, Offset(0, parallax * .8));
    }

    if (hasChild(Slot.middle)) {
      layoutChild(Slot.middle, BoxConstraints.loose(size));
      positionChild(Slot.middle, Offset(0, parallax * .6));
    }
    if (hasChild(Slot.xtr)) {
      layoutChild(Slot.xtr, BoxConstraints.loose(size));
      positionChild(Slot.xtr, Offset(0, parallax * .7));
    }

    if (!hasChild(Slot.back)) {
      if (hasChild(Slot.front)) {
        layoutChild(Slot.front, BoxConstraints.loose(size));
        positionChild(Slot.front, const Offset(0, 0));
      }
      return;
    } else {
      if (!hasChild(Slot.front)) {
        assert(
            false, 'InterlacedLayout needs front element for back to size to.');
      }

      double fWidth =
          clampDouble(size.width * .75, math.min(size.width - k * 2, 600), 920);

      double innerHeight = size.height - k * 2 - appBar;

      Size frontSize = layoutChild(
          Slot.front, BoxConstraints.loose(Size(fWidth, innerHeight)));

      Offset frontAlign = Offset(
          k, appBar + k + (innerHeight - frontSize.height) / 2 + parallax * .4);

      positionChild(Slot.front, frontAlign);

      layoutChild(
          Slot.back,
          BoxConstraints.expand(
              width: frontSize.width, height: frontSize.height));
      positionChild(Slot.back, frontAlign);
    }
  }

  @override
  bool shouldRelayout(MultiChildLayoutDelegate oldDelegate) => false;
}

class IndicatedLinearSimulation extends Simulation {
  bool isMoving = false;

  final double initPosition;
  final double velocity;

  IndicatedLinearSimulation(this.initPosition, double vel)
      : velocity = (vel > .1 ? vel : .1) {
    // log('pos $initPosition vel $velocity');
  }

  bool get passesThreshold => initPosition > 10;

  @override
  double dx(double time) {
    return passesThreshold ? velocity : -.01;
  }

  @override
  bool isDone(double time) {
    if (passesThreshold) {
      return time > (1 - initPosition) / dx(time);
    } else {
      return time > (initPosition) / -dx(time);
    }
  }

  @override
  double x(double time) {
    return initPosition + time * dx(time);
  }
}

class IndicatedLinearScrollPhysics extends ScrollPhysics {
  @override
  ScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return IndicatedLinearScrollPhysics();
  }

  @override
  Simulation createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    // log('creating');
    return IndicatedLinearSimulation(position.pixels, velocity);
  }
}
