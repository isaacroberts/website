import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

// PageController? globalPageController;

enum Sections {
  Home,
  Process,
  Features,
  Experience,
  Contact,

  Proc0,
  Proc1,
  Proc2,
  Proc3,
  Proc4,
  Proc5,
  Proc6,
  FeatGPT,
  FeatData,
  FeatAnim
}

class VisNotification extends Notification {
  final Sections section;
  const VisNotification(this.section);
  String get title => section.name;
}

class VisWrapper extends StatelessWidget {
  final Widget child;
  final Sections section;
  const VisWrapper({Key? key, required this.child, required this.section})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
        key: Key('vis${section.index}'),
        onVisibilityChanged: (VisibilityInfo info) {
          if (info.visibleFraction > .5) {
            // log('i am visible ${section.name}');
            VisNotification(section).dispatch(context);
          }
        },
        child: child);
  }
}

const List<Sections> displayScrollList = [
  Sections.Home,
  Sections.Process,
  Sections.Features,
  Sections.Experience,
  Sections.Contact
];

class ScrollTo extends LabeledGlobalKey {
  final String name;
  ScrollTo(this.name) : super(name);
  ScrollTo.fromSection(Sections s)
      : name = s.name,
        super(s.name);
}

final List<ScrollTo> scrollTos = [
  for (int n = 0; n < Sections.values.length; ++n)
    ScrollTo.fromSection(Sections.values[n])
];

void scrollToPage(Sections page) {
  var ct = scrollTos[page.index].currentContext;
  if (ct != null) {
    Scrollable.ensureVisible(ct,
        duration: const Duration(milliseconds: 750), curve: Curves.ease);
  }
}

// Sections visibleSection (BuildContext context) {
//   for (int n = 0; n < Sections.values.length; ++n)
// {
//   var key = scrollTos[n];
//   Scrollable.of(context).position.
// }
//   return Sections.Home;
// }

class ScrollMarker extends StatelessWidget {
  final Sections section;
  const ScrollMarker(this.section, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
        padding: EdgeInsets.zero, key: scrollTos[section.index]);
  }
}

const List<String> pageTitles = [
  'Isaac Roberts',
  'Process',
  'Features',
  'Features',
  'Features',
  'Experience',
  'TODO',
];
final String DEFAULT_PAGE_TITLE = '//${pageTitles[0]}';
