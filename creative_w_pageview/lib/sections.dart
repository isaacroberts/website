import 'package:flutter/material.dart';

PageController? globalPageController;
void scrollToPage(int page) {
  globalPageController?.animateToPage(page,
      duration: const Duration(milliseconds: 750), curve: Curves.ease);
}

enum Sections { Home, Process, Features, Experience, Contact }

extension PageExt on Sections {
  int get pageStart {
    switch (this) {
      case Sections.Home:
        return 0;
      case Sections.Process:
        return 1;
      case Sections.Features:
        return 2;
      case Sections.Experience:
        return 5;
      case Sections.Contact:
        return 8;
      default:
        return 0;
    }
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
