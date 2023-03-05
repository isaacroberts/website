import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:website/text_theme.dart';
import 'theme.dart';
import 'package:flutter/rendering.dart';

Widget sliverDivider() {
  return const SliverToBoxAdapter(
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 90),
          child: Divider(height: 30)));
}

Widget sectionHeader(BuildContext context, String title,
    {Key? key, Color? color}) {
  color ??= theme.scaffoldBackgroundColor;
  return SliverToBoxAdapter(
      key: key,
      child: Container(
          color: color,
          // padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Column(children: [
            // Divider(height: 15),
            const Padding(
                padding: EdgeInsets.fromLTRB(90, 0, 90, 60),
                child: Divider(height: 15)),
            // const Padding(padding: EdgeInsets.only(top: 30)),
            Text(title, style: fonts.headlineMedium),
          ])));
}

Widget paragraphWithIndent(String para, {bool leftAlign = true}) {
  List<String> lines = para.split('\n');

  // log((fonts.bodyText1?.fontSize?.toString()) ?? 'null');
  double spacing = .5 * (fonts.bodyText1?.fontSize ?? 10);
  double indent = spacing * 3;
  return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment:
          leftAlign ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(lines.length * 2 - 1, (int absIdx) {
        if (absIdx % 2 == 0) {
          int lIx = absIdx ~/ 2;
          return RichText(
            text: TextSpan(children: [
              WidgetSpan(
                  child: Padding(
                padding: EdgeInsets.only(left: indent),
              )),
              TextSpan(text: lines[lIx], style: fonts.bodyText2),
            ]),
            maxLines: null,
            softWrap: true,
            // strutStyle: StrutStyle(),
            overflow: TextOverflow.visible,
            textAlign: leftAlign ? TextAlign.left : TextAlign.center,
          );
        } else {
          return Padding(padding: EdgeInsets.only(top: spacing));
        }
      }));
}

Widget selectionIf(bool selectable, Widget child) {
  if (selectable) {
    return SelectionArea(child: child);
  } else {
    return child;
  }
}

Widget paragraph(String para,
    {bool leftAlign = true, bool selectable = false}) {
  List<String> lines = para.split('\n');

  // log((fonts.bodyText1?.fontSize?.toString()) ?? 'null');
  double spacing = .5 * (fonts.bodyText1?.fontSize ?? 10);
  const double indent = 30;
  return selectionIf(
      selectable,
      Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
              leftAlign ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(lines.length, (int index) {
            return Padding(
                padding: index == lines.length
                    ? EdgeInsets.zero
                    : EdgeInsets.only(bottom: spacing),
                child: Text(
                  lines[index],
                  style: fonts.bodyText1?.copyWith(height: 1.5),
                  maxLines: null,
                  softWrap: true,
                  // strutStyle: StrutStyle(),
                  overflow: TextOverflow.visible,
                  textAlign: leftAlign ? TextAlign.left : TextAlign.center,
                ));
          })));
}

class ParallaxFlowDelegate extends FlowDelegate {
  final double distance;

  ParallaxFlowDelegate(
      {required this.scrollable,
      required this.listItemContext,
      required this.backgroundImageKey,
      this.distance = 10})
      : super(repaint: scrollable.position);

  final ScrollableState scrollable;
  final BuildContext listItemContext;
  final GlobalKey backgroundImageKey;

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints.tightFor(
      width: constraints.maxWidth,
    );
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    // Calculate the position of this list item within the viewport.
    final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
    final listItemBox = listItemContext.findRenderObject() as RenderBox;
    final listItemOffset = listItemBox.localToGlobal(
        listItemBox.size.centerLeft(Offset.zero),
        ancestor: scrollableBox);

    // Determine the percent position of this list item within the
    // scrollable area.
    final viewportDimension = scrollable.position.viewportDimension;
    final scrollFraction =
        (listItemOffset.dy / viewportDimension).clamp(0.0, 1.0);

    // Calculate the vertical alignment of the background
    // based on the scroll percent.
    final verticalAlignment = Alignment(0.0, scrollFraction * 2 - 1);

    // Convert the background alignment into a pixel offset for
    // painting purposes.
    final backgroundSize =
        (backgroundImageKey.currentContext!.findRenderObject() as RenderBox)
            .size;
    final listItemSize = context.size;
    final childRect =
        verticalAlignment.inscribe(backgroundSize, Offset.zero & listItemSize);

    // Paint the background.
    context.paintChild(
      0,
      transform:
          Transform.translate(offset: Offset(0.0, childRect.top)).transform,
    );
  }

  @override
  bool shouldRepaint(ParallaxFlowDelegate oldDelegate) {
    return scrollable != oldDelegate.scrollable ||
        listItemContext != oldDelegate.listItemContext ||
        backgroundImageKey != oldDelegate.backgroundImageKey;
  }
}
