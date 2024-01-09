import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'dart:developer';
import 'dart:math' as math;

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'text_theme.dart';
import 'trio_lottie.dart';

import 'theme.dart';
import 'common_elements.dart';

import 'device.dart';
import 'trio_bar_scroll.dart';

const bool leftAlign = false;

// final List<IconData> icons = [
//   MdiIcons.codeBraces,
//   MdiIcons.brush,
//   MdiIcons.shieldBug
// ];

final List<String> icons = ['responsive', 'brush', 'caliper'];

final List<String> titles = ['Develop', 'Design', 'Debug'];
final List<String> bodies = [
  "I can build robust, high-quality apps that are easy to maintain and upgrade.",
  "With my UI/UX design skills, I can create an app that is both beautiful and easy to use.",
  "Don't let bugs and glitches ruin your app. I can fix existing apps."
];

class PopItemHorizontal extends StatefulWidget {
  static const bool useScroll = false;
  static const bool useSliver = false;

  final String icon, header, body;

  const PopItemHorizontal(this.icon, this.header, this.body, {Key? key})
      : super(key: key);

  @override
  State<PopItemHorizontal> createState() => _PopItemHorizontalState();
}

class _PopItemHorizontalState extends TrioLottieHaver<PopItemHorizontal> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: k / 2),
        child: SizedBox(
            width: Device.width / 4,
            child: Card(
                // shape: RoundedRectangleBorder(),
                margin: EdgeInsets.zero,
                child: inkwellWrapper(Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 30),
                    child: popColumn())))));
  }

  Widget popColumn() {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment:
            leftAlign ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          buildLottie(widget.icon),
          const Padding(padding: EdgeInsets.only(top: 15)),
          buildHeadline(widget.header),
          const Padding(padding: EdgeInsets.only(top: 15)),
          buildBodyText(widget.body)
        ]);
  }
}

class HoveryPop extends StatefulWidget {
  static const bool useScroll = false;
  static const bool useSliver = false;

  final String icon, header, body;

  const HoveryPop(this.icon, this.header, this.body, {Key? key})
      : super(key: key);

  @override
  State<HoveryPop> createState() => _HoveryPopState();
}

class _HoveryPopState extends State<HoveryPop> {
  bool _isHovered = false;
  bool _modified = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: k),
        child: SizedBox(width: 15 * 15, child: myInkwellWrapper(switcher())));
  }

  Widget myInkwellWrapper(Widget child) {
    return InkWell(
      hoverColor: Colors.transparent,
      onTap: () {
        // setState(() {
        //   _isHovered = !_isHovered;
        // });
      },
      onHover: (b) {
        if (_isHovered != b) {
          if (_isHovered) {
            _modified = false;
            Future.delayed(const Duration(milliseconds: 350), () {
              if (!_modified) {
                setState(() {
                  _isHovered = b;
                });
              }
            });
          } else {
            setState(() {
              _modified = true;
              _isHovered = b;
            });
          }
        }
      },
      child: child,
    );
  }

  Widget smootherSwitcher() {
    return Stack(fit: StackFit.expand, children: [
      back(),
      AnimatedOpacity(
          opacity: _isHovered ? 0 : 1,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOut,
          child: front())
    ]);
  }

  Widget switcher() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 350),
      transitionBuilder: __transitionBuilder,
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut.flipped,
      child: _isHovered ? back() : front(),
    );
  }

  Widget __transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: math.pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        // log('key: ${widget?.key?.value}');
        bool isFront = (widget!.key as ValueKey<bool>).value;
        bool isUnder = (ValueKey(_isHovered) == widget?.key);

        bool start = animation.value < .5;

        bool frontShowing = !(isFront == start);

        if (isFront != frontShowing) {
          return const SizedBox.shrink();
        }

        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;

        tilt *= isUnder ? -1.0 : 1.0;
        final value = isUnder
            ? math.min(rotateAnim.value, math.pi / 2)
            : rotateAnim.value;

        return Transform(
          transform: Matrix4.rotationY(value)..setEntry(3, 0, tilt),
          alignment: Alignment.center,
          child: widget,
        );
      },
    );
  }

  Widget front() {
    return Container(
        key: const ValueKey<bool>(true),
        decoration: BoxDecoration(
            color: secondary, borderRadius: BorderRadius.circular(k)),
        child: icconn());
  }

  Widget icconn() {
    // return buildLottie(widget.icon);
    return SvgPicture.asset('lottie/${widget.icon}_white.svg');
  }

  Widget back() {
    return
        // Padding(
        //   padding: const EdgeInsets.all(k * 2),
        //   child:
        Container(
            key: const ValueKey<bool>(false),
            decoration: BoxDecoration(
                color: primary, borderRadius: BorderRadius.circular(k)),
            // decoration: BoxDecoration(
            //     color: primary, borderRadius: BorderRadius.circular(0)),
            child: Padding(
                padding: const EdgeInsets.all(k),
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.header,
                        style: fonts.displaySmall,
                      ),
                      const Padding(padding: EdgeInsets.only(top: 15)),
                      buildBodyText(widget.body)
                    ])));
  }
}

Container buildBodyText(String body) {
  return Container(
      // width: 250,
      alignment: leftAlign ? Alignment.topLeft : Alignment.topCenter,
      child: paraSmall(body,
          align: leftAlign ? TextAlign.left : TextAlign.center));
}

Text buildHeadline(String header) {
  return Text(
    header,
    style: fonts.displayMedium,
  );
}

Widget headlineWithIcon(String header, String icon) {
  TextStyle style = fonts.displayMedium ?? watchFonts.headlineMedium!;
  return RichText(
      text: TextSpan(children: <InlineSpan>[
    TextSpan(
      text: '$header ',
      style: style,
    ),
    WidgetSpan(
      child: SvgPicture.asset('lottie/$icon.svg', height: style.fontSize),
      alignment: PlaceholderAlignment.bottom,
    ),
  ]));
}

List<Widget> popHorizontal(BuildContext contex) {
  return [
    HoveryPop(icons[0], titles[0], bodies[0]),
    HoveryPop(icons[1], titles[1], bodies[1]),
    HoveryPop(icons[2], titles[2], bodies[2]),
  ];
}

List<Widget> popScrolls(BuildContext context) {
  return [
    PopColumnScrollWithIcon(icons[0], titles[0], bodies[0]),
    PopColumnScrollWithIcon(icons[1], titles[1], bodies[1]),
    PopColumnScrollWithIcon(icons[2], titles[2], bodies[2]),
  ];
}

List<Widget> popScrollNoIcons(BuildContext context) {
  return [
    PopScrollNoIcon(icons[0], titles[0], bodies[0]),
    PopScrollNoIcon(icons[1], titles[1], bodies[1]),
    PopScrollNoIcon(icons[2], titles[2], bodies[2]),
  ];
}

List<Widget> popScrollWatch(BuildContext context) {
  return [
    PopScrollWatch(icons[0], titles[0], bodies[0]),
    PopScrollWatch(icons[1], titles[1], bodies[1]),
    PopScrollWatch(icons[2], titles[2], bodies[2]),
  ];
}

// bool get useScroll => Device.width < (trioHorizWidth * 3 + k);

Widget trioSliver(BuildContext context) {
  return SliverLayoutBuilder(builder: (context, constraints) {
    if (Device.width <= watchSize) {
      return SliverList(
          delegate: SliverChildListDelegate(popScrollWatch(context)));
    }
    if (Device.width <= 550) {
      return SliverList(
          delegate: SliverChildListDelegate(popScrollNoIcons(context)));
    } else if (Device.width < 775) {
      return SliverList(delegate: SliverChildListDelegate(popScrolls(context)));
    } else {
      return SliverToBoxAdapter(child: trioContainerNoScroll(context));
    }
  });
}

Widget trioContainerNoScroll(BuildContext context) {
  return Center(
      child: Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: SizedBox(
              // width: trioHorizWidth * 3 + k * 4,
              height: 20 * 15,
              child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: popHorizontal(context)))));
}
