import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'full_color.dart';
import 'text_theme.dart';
import 'device.dart';
import 'theme.dart';
import 'common_elements.dart';

class DisplayDialog extends PopupRoute {
  final Widget child;
  DisplayDialog(this.child)
      : super(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        );
  @override
  Color get barrierColor => const Color(0x40000000);

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => 'Barrier';

  @override
  bool get opaque => false;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    var offset = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(animation);
    return SlideTransition(position: offset, child: child);
  }

  @override
  Duration get transitionDuration => const Duration(milliseconds: 150);
}

abstract class FeatureShower {
  // Widget textContent(BuildContext context);
  Widget displayContent(BuildContext context);

  String title();
  String subtitle();
  String body();

  String bgImage();

  bool shouldExpandToDisplay() => true;

  BoxDecoration deco(BorderRadius borderRadius) {
    return BoxDecoration(
        borderRadius: borderRadius,
        // color: Colors.black,
        image: DecorationImage(
          // colorFilter:
          //     const ColorFilter.mode(Color(0xaa444444), BlendMode.multiply),
          image: assetProvider(bgImage()),
          fit: BoxFit.cover,
          opacity: .5,
        ));
  }

  Widget textContainer(bool textLeft) {
    return Card(
        child: SizedBox.expand(
            child: Container(
                decoration: deco(BorderRadius.circular(15)),
                child: InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () {},
                    child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: textContent(textLeft))))));
  }

  Widget vertTextContainer(BuildContext context) {
    return Container(
        height: 400,
        decoration: deco(const BorderRadius.all(Radius.circular(15))),
        child: InkWell(
            onTap: shouldExpandToDisplay()
                ? () => navToDisplayWidget(context)
                : null,
            child: Padding(
                padding: const EdgeInsets.all(textContainerMargin),
                child: textContent(true, selectable: false))));
  }

  Widget separatedDisplayWidget(BuildContext context) {
    return Center(
        child: Card(
            child: SizedBox(
                width: 400, height: 400, child: _displayContent(context))));
  }

  void navToDisplayWidget(BuildContext context) {
    if (shouldExpandToDisplay()) {
      Navigator.push(context, DisplayDialog(separatedDisplayWidget(context)));
    }
  }

  Widget getBg(Widget child, double height) {
    return Container(
        height: height,
        // width: Device.width,
        alignment: Alignment.center,
        // decoration: bgAsset.isNotEmpty
        //     ? BoxDecoration(
        //         image: DecorationImage(
        //             opacity: 1, fit: BoxFit.fill, image: AssetImage(bgAsset)))
        //     : null,
        child: child);
  }

  Widget _displayContent(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(30), child: displayContent(context));
    return Card(child: displayContent(context));
  }

  List<Widget> children(BuildContext context, bool left, bool vertical) {
    if (vertical) {
      return [
        vertTextContainer(context),
      ];
    } else {
      if (left) {
        return [
          Flexible(child: textContainer(left)),
          Flexible(child: _displayContent(context)),
          // const SizedBox(width: 15),
        ];
      } else {
        return [
          // const SizedBox(width: 15),
          Flexible(child: _displayContent(context)),
          Flexible(child: textContainer(left)),
        ];
      }
    }
  }

  Widget selectWrap(bool selectable, Widget child) {
    if (selectable) {
      return SelectionArea(child: child);
    } else {
      return child;
    }
  }

  // @override
  Widget textContent(bool textLeft, {bool selectable = true}) {
    TextAlign align = textLeft ? TextAlign.left : TextAlign.center;

    return selectWrap(
        selectable,
        Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: textToCA(align),
            children: [
              Text(title(), style: fonts.headlineSmall),
              const SizedBox(height: 15),
              paraMed(subtitle(), align: align),
              const SizedBox(height: 15),
              paraMed(body(), align: align)
            ]));
  }

  Widget doBuild(BuildContext context, bool textLeft) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 950) {
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SizedBox(
                height: 400,
                child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: children(context, textLeft, false))));
        // } else if (constraints.maxWidth >= tinyWidth) {
        //   return Padding(
        //       padding: const EdgeInsets.symmetric(horizontal: standardContainerMargin),
        //       child: Column(
        //           mainAxisSize: MainAxisSize.min,
        //           mainAxisAlignment: MainAxisAlignment.start,
        //           crossAxisAlignment: CrossAxisAlignment.stretch,
        //           children: [vertTextContainer(context)]));
      } else {
        return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: standardContainerMargin),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [vertTextContainer(context)]));
      }
    });
  }
}
