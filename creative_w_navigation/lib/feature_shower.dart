import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:isaac_roberts_consulting/parallax.dart';
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

  final GlobalKey _backgroundImageKey = GlobalKey();

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

  Widget parallaxImg(BuildContext context) {
    return ParallaxImage(
        image: bgImage(), opacity: .5, distance: 2, debugLabel: title());
    // return Flow(
    //     key: const Key('feature_flow'),
    //     delegate: ParallaxFlowDelegate(
    //       scrollable: Scrollable.of(context),
    //       listItemContext: context,
    //       backgroundImageKey: _backgroundImageKey,
    //       // distance: .5,
    //     ),
    //     children: [
    //       // SizedBox(
    //       //     height: 500,
    //       Opacity(
    //           opacity: .5,
    //           child: fadeAssetBg(bgImage(), fit: BoxFit.fitHeight)),
    //     ]);
  }

  Widget parallax(BuildContext context, {required Widget child}) {
    return SizedBox(
        height: 400,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Stack(
                alignment: Alignment.center,
                fit: StackFit.expand,
                children: [parallaxImg(context), child])));
  }

  Widget boxDeco(BuildContext context, {required Widget child}) {
    return Container(
        height: 400, decoration: deco(BorderRadius.circular(15)), child: child);
  }

  Widget textContainer(BuildContext context, bool textLeft) {
    return parallax(
      context,
      child: Padding(
          padding: const EdgeInsets.all(30),
          child: textContent(context, textLeft)),
    );
    // return Card(
    //     child: Container(
    //         decoration: deco(BorderRadius.circular(15)),
    //         child: Padding(
    //             padding: const EdgeInsets.all(30),
    //             child: textContent(context, textLeft))));
  }

  Widget vertTextContainer(BuildContext context) {
    return parallax(context,
        child: InkWell(
            onTap: shouldExpandToDisplay()
                ? () => navToDisplayWidget(context)
                : null,
            child: Padding(
                padding: const EdgeInsets.all(textContainerMargin),
                child: textContent(context, true,
                    selectable: false, vert: true))));
    return Container(
        height: 400,
        decoration: deco(const BorderRadius.all(Radius.circular(15))),
        child: InkWell(
            onTap: shouldExpandToDisplay()
                ? () => navToDisplayWidget(context)
                : null,
            child: Padding(
                padding: const EdgeInsets.all(textContainerMargin),
                child: textContent(context, true,
                    selectable: false, vert: true))));
  }

  Widget separatedDisplayWidget(BuildContext context) {
    return Center(
        child: Card(
            child: SizedBox(
                width: Device.width - 60,
                height: Device.height - 120,
                child: _displayContent(context))));
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
    return displayContent(context);
    return ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: displayContent(context));
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
          Flexible(child: textContainer(context, left)),
          const SizedBox(width: 30),
          Flexible(child: _displayContent(context)),
        ];
      } else {
        return [
          Flexible(child: _displayContent(context)),
          const SizedBox(width: 30),
          Flexible(child: textContainer(context, left)),
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
  Widget textContent(BuildContext context, bool textLeft,
      {bool selectable = true, bool vert = false}) {
    TextAlign align = textLeft ? TextAlign.left : TextAlign.center;

    return selectWrap(
        selectable,
        Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: textToCA(align),
            children: [
              Text(title(), style: fonts.headlineSmall),
              // const SizedBox(height: 15),
              paraMed(subtitle(), align: align),
              const SizedBox(height: 15),
              paraMed(body(), align: align),
              if (vert) const SizedBox(height: 15),
              if (vert)
                OutlinedButton(
                    onPressed: () => navToDisplayWidget(context),
                    child: const Text("See more"))
            ]));
  }

  Widget doBuild(BuildContext context, bool textLeft) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 950) {
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Center(
                child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: processWidth),
                    child: SizedBox(
                        height: 400,
                        child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: children(context, textLeft, false))))));
      } else if (Device.width > watchSize) {
        return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: standardContainerMargin),
            child: vertTextContainer(context));
      } else {
        return watchTextContainer(context);
      }
    });
  }

  Widget watchTextContainer(BuildContext context) {
    const TextAlign align = TextAlign.left;

    return Container(
        decoration: deco(const BorderRadius.only()),
        padding: const EdgeInsets.all(15),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: textToCA(align),
            children: [
              Text(title(), style: watchSubt),
              paraMed(subtitle(), align: align),
              const SizedBox(height: 15),
              paraMed(body(), align: align)
            ]));
  }
}
