import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:isaac_roberts_consulting/parallax.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'colorable_flutter_logo.dart';
import 'device.dart';
import 'text_theme.dart';
import 'contact_page.dart';
import 'theme.dart';
// import 'package:flutter/rendering.dart';

/*
      Lemme get uhhhhh


      "Data vizualisation"  |   visual with https://pub.dev/packages/syncfusion_flutter_charts

      




 */

void contactButtonPressed(BuildContext context, bool fromFab) async {
  showDialog(
    context: context,
    builder: (context) => ContactBackdrop(fromFab),
  );
  // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
  //   return const ContactPage();
  // }));
  // launchUrl(Uri.parse(
  //     'mailto:isaaclevinroberts@gmail.com?subject=Mobile App Development!&body=Hi Isaac,\n\nI was interested in commissioning a mobile app!\n\nThanks,\n'));
}

ImageProvider<Object> assetProvider(String asset, {String? package}) {
  if (kIsWeb) {
    return NetworkImage(
      // 'assets/$asset',
      'assets/${package == null ? '' : 'packages/$package/'}$asset',
    );
  } else {
    return AssetImage('assets/$asset', package: package);
  }
}

Widget fadeProviderBg(
  ImageProvider image, {
  key,
  double imageScale = 1.0,
  // excludeFromSemantics = false,
  // imageSemanticLabel,
  width,
  height,
  fit,
  placeholderFit,
  alignment = Alignment.center,
  repeat = ImageRepeat.noRepeat,
  matchTextDirection = false,
}) {
  if (kIsWeb) {
    return FadeInImage(
      placeholder: assetProvider('empty.png'),
      image: image,
      fadeOutDuration: const Duration(milliseconds: 300),
      fadeOutCurve: Curves.easeOut,
      fadeInDuration: const Duration(milliseconds: 300),
      fadeInCurve: Curves.easeIn,
    );
  } else {
    return Image(
      image: image,
      key: key,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      matchTextDirection: matchTextDirection,
    );
  }
}

Widget fadeAssetBg(
  String asset, {
  key,
  double imageScale = 1.0,
  // excludeFromSemantics = false,
  // imageSemanticLabel,
  width,
  height,
  fit,
  placeholderFit,
  alignment = Alignment.center,
  repeat = ImageRepeat.noRepeat,
  matchTextDirection = false,
}) {
  if (kIsWeb) {
    return FadeInImage.assetNetwork(
      placeholder: 'empty.png',
      image: 'assets/$asset',
      fadeOutDuration: const Duration(milliseconds: 300),
      fadeOutCurve: Curves.easeOut,
      fadeInDuration: const Duration(milliseconds: 300),
      fadeInCurve: Curves.easeIn,
      key: key,
      imageScale: imageScale,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      matchTextDirection: matchTextDirection,
    );
  } else {
    return Image(
      image: assetProvider(asset),
      key: key,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      matchTextDirection: matchTextDirection,
    );
    return FadeInImage(
      placeholder: assetProvider('empty.png'),
      image: assetProvider(asset),
      fadeOutDuration: const Duration(milliseconds: 300),
      fadeOutCurve: Curves.easeOut,
      fadeInDuration: const Duration(milliseconds: 300),
      fadeInCurve: Curves.easeIn,
      key: key,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      matchTextDirection: matchTextDirection,
    );
  }
}

Widget fadeProviderFore(
  ImageProvider image, {
  key,
  double imageScale = 1.0,
  // excludeFromSemantics = false,
  // imageSemanticLabel,
  width,
  height,
  fit,
  placeholderFit,
  alignment = Alignment.center,
  repeat = ImageRepeat.noRepeat,
  matchTextDirection = false,
}) {
  if (kIsWeb) {
    return FadeInImage(
      placeholder: assetProvider('loader.gif'),
      image: image,
      fadeOutDuration: const Duration(milliseconds: 300),
      fadeOutCurve: Curves.easeOut,
      fadeInDuration: const Duration(milliseconds: 300),
      fadeInCurve: Curves.easeIn,
    );
  } else {
    return Image(
      image: image,
      key: key,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      matchTextDirection: matchTextDirection,
    );
  }
}

Widget fadeAssetFore(
  String asset, {
  key,
  double imageScale = 1.0,
  // excludeFromSemantics = false,
  // imageSemanticLabel,
  width,
  height,
  fit,
  placeholderFit,
  alignment = Alignment.center,
  repeat = ImageRepeat.noRepeat,
  matchTextDirection = false,
}) {
  if (kIsWeb) {
    return FadeInImage.assetNetwork(
      placeholder: 'loader.gif',
      image: 'assets/$asset',
      fadeOutDuration: const Duration(milliseconds: 300),
      fadeOutCurve: Curves.easeOut,
      fadeInDuration: const Duration(milliseconds: 300),
      fadeInCurve: Curves.easeIn,
      key: key,
      imageScale: imageScale,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      matchTextDirection: matchTextDirection,
    );
  } else {
    return Image(
      image: assetProvider(asset),
      key: key,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      matchTextDirection: matchTextDirection,
    );
    return FadeInImage(
      placeholder: assetProvider('loader.gif'),
      image: assetProvider(asset),
      fadeOutDuration: const Duration(milliseconds: 300),
      fadeOutCurve: Curves.easeOut,
      fadeInDuration: const Duration(milliseconds: 300),
      fadeInCurve: Curves.easeIn,
      key: key,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      matchTextDirection: matchTextDirection,
    );
  }
}

Widget sliverDivider() {
  return const SliverToBoxAdapter(
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 90),
          child: Divider(height: 15)));
}

SliverToBoxAdapter sliverImgSeparator() {
  return SliverToBoxAdapter(
    child: Container(
      height: 3,
      color: Grayscale.shade900,
    ),
  );
}

Widget sectionHeader(BuildContext context, String title,
    {Key? key, Color? color}) {
  return SliverToBoxAdapter(child: sectionHeaderNoSliver(title, key: key));
}

Widget headerTextRow(String title, TextStyle? style, {Key? key}) {
  return Align(
      alignment: Alignment.topLeft,
      child: Text(
        key: key,
        '// $title',
        style: style,
        textAlign: TextAlign.left,
      ));
  return SizedBox(
      width: Device.width,
      height: 120,
      child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.topCenter,
          children: [
            Positioned.fill(
                child: Center(child: Text(key: key, title, style: style))),
            Positioned.fill(
                child: Align(
              alignment: Alignment.centerLeft,
              child: Text('//', style: style),
            ))
          ]));
}

Widget sectionHeaderNoSliver(String title, {Key? key}) {
  return LayoutBuilder(builder: (context, constraints) {
    if (constraints.maxWidth > watchSize) {
      return Padding(
          padding: const EdgeInsets.only(top: 45, bottom: 30, left: 15),
          child: headerTextRow(title, fonts.displayMedium, key: key)
          // child: Text(key: key, '//$title', style: fonts.displayMedium),
          );

      // return Center(
      //     child: Padding(
      //         padding: const EdgeInsets.only(top: 45, bottom: 30, left: 15),
      //         child: headerTextRow(title, fonts.displayMedium, key: key)
      //         // child: Text(key: key, '//$title', style: fonts.displayMedium),
      //         ));
    } else {
      return Center(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: headerTextRow(title, watchHeaderLarge, key: key)));

      // child: Text(key: key, '//$title', style: watchHeaderLarge)));
    }
  });
}

Widget sectionHeaderNoSliverOrPadding(String title, {Key? key}) {
  return Center(
      child: Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 15),
          child: headerTextRow(title, fonts.displayMedium)
          // child: Text(key: key, title, style: fonts.displayMedium),
          ));
}

Widget divider() {
  return const Padding(
    padding: EdgeInsets.fromLTRB(90, 15, 90, 15),
    child: Divider(height: 15),
  );
}

Widget selectionIf(bool selectable, Widget child) {
  if (selectable) {
    return SelectionArea(child: child);
  } else {
    return child;
  }
}

CrossAxisAlignment textToCA(TextAlign align) {
  switch (align) {
    case TextAlign.left:
    case TextAlign.start:
      return CrossAxisAlignment.start;
    case TextAlign.right:
    case TextAlign.end:
      return CrossAxisAlignment.end;
    case TextAlign.center:
      return CrossAxisAlignment.center;
    case TextAlign.justify:
      return CrossAxisAlignment.stretch;
  }
}

Widget _paragraph(String para,
    {required TextStyle? style,
    TextAlign align = TextAlign.left,
    bool selectable = false}) {
  List<String> lines = para.trim().split('\n');

  double spacing = .5 * (style?.height ?? 10);
  spacing = 15;
  return selectionIf(
      selectable,
      Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: textToCA(align),
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(lines.length, (int index) {
            return Padding(
                padding: index == lines.length - 1
                    ? EdgeInsets.zero
                    : EdgeInsets.only(bottom: spacing),
                child: Text(
                  lines[index],
                  style: style,
                  maxLines: null,
                  softWrap: true,
                  overflow: TextOverflow.visible,
                  textAlign: align,
                ));
          })));
}

Widget _subt(String line,
    {required TextStyle? style,
    TextAlign align = TextAlign.left,
    bool selectable = false}) {
  double spacing = .5 * (style?.height ?? 10);
  spacing = 15;
  return selectionIf(
      selectable,
      Text(
        line,
        style: style,
        maxLines: null,
        softWrap: true,
        // strutStyle: StrutStyle(),
        overflow: TextOverflow.visible,
        textAlign: align,
      ));
}

// var paraSmall = paraLarge;
Widget paraSmall(String para,
    {TextAlign align = TextAlign.left, bool selectable = false}) {
  return _paragraph(para,
      style: fonts.bodySmall, align: align, selectable: selectable);
}

// var paraMed = paraLarge;
Widget paraMed(String para,
    {TextAlign align = TextAlign.left, bool selectable = false}) {
  return _paragraph(para,
      style: fonts.bodyMedium, align: align, selectable: selectable);
}

Widget paraLarge(String para,
    {TextAlign align = TextAlign.left, bool selectable = false}) {
  return _paragraph(para,
      style: fonts.bodyLarge, align: align, selectable: selectable);
}

var subt = paraLarge;
// Widget subt(String line,
//     {TextAlign align = TextAlign.left, bool selectable = false}) {
//   return _subt(line,
//       style: fonts.titleSmall, align: align, selectable: selectable);
// }

// Widget darkParagraph(String para,
//     {TextAlign align = TextAlign.left, bool selectable = false}) {
//   List<String> lines = para.split('\n');
//
//   // log((fonts.bodyText1?.fontSize?.toString()) ?? 'null');
//   double spacing = .5 * (fonts.bodyText1?.fontSize ?? 10);
//   const double indent = 30;
//   return selectionIf(
//       selectable,
//       Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: textToCA(align),
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: List.generate(lines.length, (int index) {
//             return Padding(
//                 padding: index == lines.length
//                     ? EdgeInsets.zero
//                     : EdgeInsets.only(bottom: spacing),
//                 child: Text(
//                   lines[index],
//                   style: darkFonts.bodyText1?.copyWith(height: 1.5),
//                   maxLines: null,
//                   softWrap: true,
//                   // strutStyle: StrutStyle(),
//                   overflow: TextOverflow.visible,
//                   textAlign: align,
//                 ));
//           })));
// }

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

class ParallaxImage extends StatefulWidget {
  final String image;
  final double? opacity;
  final String? debugLabel;
  final double distance;
  //ParallaxImage(image: , opacity: 1, debugLabel: )
  const ParallaxImage(
      {required this.image,
      this.opacity,
      double? distance,
      this.debugLabel,
      Key? key})
      : distance = distance ?? 5,
        super(key: key);

  @override
  State<ParallaxImage> createState() => _ParallaxImageState();
}

class _ParallaxImageState extends State<ParallaxImage> {
  late GlobalKey _backgroundImageKey;

  @override
  void initState() {
    _backgroundImageKey = GlobalKey(debugLabel: widget.debugLabel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double? op = widget.opacity;

    final delegate = PixelParallaxDelegate(
      scrollable: Scrollable.of(context),
      listItemContext: context,
      backgroundImageKey: _backgroundImageKey,
      distance: widget.distance,
    );

    return Flow(delegate: delegate, children: [
      ConstrainedBox(
          constraints: BoxConstraints(
              minHeight: (Device.height) * delegate.pixelsPerPixel),
          child: (op != null)
              ? Opacity(
                  opacity: op,
                  child: fadeAssetBg(widget.image, fit: BoxFit.fitHeight))
              : fadeAssetBg(widget.image, fit: BoxFit.cover))
    ]);
  }
}

class ParallaxImageFromProvider extends StatefulWidget {
  final ImageProvider image;
  final double? opacity;
  final String? debugLabel;
  final double distance;
  //ParallaxImage(image: , opacity: 1, debugLabel: )
  const ParallaxImageFromProvider(
      {required this.image,
      this.opacity,
      double? distance,
      this.debugLabel,
      Key? key})
      : distance = distance ?? 2,
        super(key: key);

  @override
  State<ParallaxImageFromProvider> createState() =>
      _ParallaxImageFromProviderState();
}

class _ParallaxImageFromProviderState extends State<ParallaxImageFromProvider> {
  late GlobalKey _backgroundImageKey;

  @override
  void initState() {
    _backgroundImageKey = GlobalKey(debugLabel: widget.debugLabel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double? op = widget.opacity;

    final delegate = PixelParallaxDelegate(
      scrollable: Scrollable.of(context),
      listItemContext: context,
      backgroundImageKey: _backgroundImageKey,
      distance: widget.distance,
    );

    return Flow(delegate: delegate, children: [
      ConstrainedBox(
          constraints: BoxConstraints(
              minHeight: (Device.height) * delegate.pixelsPerPixel),
          child: Image(
              image: widget.image,
              opacity: op != null ? AlwaysStoppedAnimation<double>(op) : null,
              fit: BoxFit.cover))
    ]);
  }
}
