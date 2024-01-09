import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

import 'package:isaac_roberts_consulting/signup_form.dart';

import 'device.dart';
import 'footer.dart';

/*
    This was to avoid doing a sliver.
    The benefit of the sliver was that the image could cover both the signup and footer, but the footer will still stick to the bottom of the screen.
    It might be possible to do that with a Flexible


 */
class SimpleMultiFooter extends StatelessWidget {
  const SimpleMultiFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      const double signupSize = 400;
      const double minFooterSize = 200;
      double height = math.max(
          minFooterSize + signupSize, (Device.height + signupSize) / 2);
      return SizedBox(
          height: height,
          child: const Stack(fit: StackFit.passthrough, children: [
            LoneSignupImage(),
            Column(mainAxisSize: MainAxisSize.max, children: [
              SizedBox(height: signupSize, child: SignupForm()),
              Flexible(child: SizedBox.shrink()),
              SizedBox(height: minFooterSize, child: Footer()),
            ]),
          ]));
    });
  }
}
