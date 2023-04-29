import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:get/get.dart';
import 'package:isaac_roberts_consulting/parallax.dart';

import 'common_elements.dart';
import 'device.dart';

enum Slot { text, img }

class TextWithOptImgLayout extends MultiChildLayoutDelegate {
  @override
  void performLayout(Size size) {
    // Widget row = Row(
    //     mainAxisSize: MainAxisSize.max,
    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Expanded(
    //           child: Align(
    //               alignment: Alignment.topCenter,
    //               // child: Card(
    //               //     color: Colors.white,
    //               child: textColumn(ix, headline, body))),
    //       if (constraints.maxWidth > 300)
    //         Flexible(
    //           // child: Padding(
    //           //     padding: const EdgeInsets.all(45),
    //             child: undrawImage(svg, undraw, true))
    //       // const Padding(padding: EdgeInsets.only(right: 60)),
    //     ]);

    Size imgSize = Size.zero;
    Size textSize = Size.zero;

    if (!hasChild(Slot.img)) {
      textSize = layoutChild(Slot.text, BoxConstraints.loose(size));
      positionChild(Slot.text, const Offset(0, 0));
      return;
    } else if (!hasChild(Slot.text)) {
      assert(false, 'Custom TextWithOptImgLayout without text');
    }

    if (hasChild(Slot.img)) {
      imgSize = layoutChild(Slot.img, BoxConstraints.loose(size));
    }
    if (hasChild(Slot.text)) {
      Size remaining = Size(size.height, size.width - imgSize.width);
      textSize = layoutChild(Slot.text, BoxConstraints.loose(remaining));
      // positionChild(_Slot.text, Offset.zero);
    }

    if (textSize.height < size.height) {
      positionChild(Slot.text, const Offset(0, 0));
      positionChild(Slot.img, Offset(textSize.width, 0));
    } else {
      textSize = layoutChild(Slot.text, BoxConstraints.loose(size));
      positionChild(Slot.text, const Offset(0, 0));
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
  bool shouldRelayout(covariant FractionalLayout oldDelegate) {
    return true;
  }
}

class IndicatedLinearSimulation extends Simulation {
  bool isMoving = false;

  final double initPosition;
  final double velocity;

  IndicatedLinearSimulation(this.initPosition, double vel) : velocity = (vel) {
    // log('pos $initPosition vel $velocity');
  }

  bool get passesThreshold => initPosition > 10;

  @override
  double dx(double time) {
    return velocity;
    return passesThreshold ? velocity : -.01;
  }

  @override
  bool isDone(double time) {
    return time > 1;
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
  const IndicatedLinearScrollPhysics();

  @override // TODO: implement maxFlingVelocity
  double get maxFlingVelocity => 10;

  @override
  ScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return const IndicatedLinearScrollPhysics();
  }

  @override
  Simulation? createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    // log('creating');
    // return IndicatedLinearSimulation(position.pixels, velocity);
    return FrictionSimulation(.1, position.pixels, velocity);
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    log('abc $value');
    return 0;
  }

  @override
  double carriedMomentum(double existingVelocity) {
    return -existingVelocity;
  }

  @override
  bool shouldAcceptUserOffset(ScrollMetrics position) {
    // position.
    log('shouldAccept ${position.pixels}');
    // return position.pixels != 0;
    return true;
  }
}
