import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:isaac_roberts_consulting/app_bar.dart';
import 'package:isaac_roberts_consulting/sections.dart';
import 'common_elements.dart';
import 'text_theme.dart';

class AppBarTitle extends ChangeNotifier {
  String? _targetTitle;

  String get title => _targetTitle ?? DEFAULT_PAGE_TITLE;

  set title(String? s) {
    _targetTitle = s;
    notifyListeners();
  }

  set page(int page) {
    if (page == 0) {
      _targetTitle = DEFAULT_PAGE_TITLE;
    } else {
      _targetTitle = '//${pageTitles[page]}:';
    }
    notifyListeners();
  }
}

AppBarTitle appBarTitle = AppBarTitle();

class Typer extends StatefulWidget {
  // final String targetText;
  final int page;
  const Typer(this.page, {Key? key}) : super(key: key);

  @override
  State<Typer> createState() => _TyperState();
}

class _TyperState extends State<Typer> {
  String appBarText = '';
  String targetText = DEFAULT_PAGE_TITLE;

  bool typeQueued = false;

  @override
  void initState() {
    super.initState();
    typeQueued = true;
    _updateTargetText();
    Future.delayed(const Duration(milliseconds: 500))
        .then((_) => _startTyping());
  }

  void _deleteChar() {
    setState(() {
      appBarText = appBarText.substring(0, appBarText.length - 1);
    });
  }

  void _typeChar(String c) {
    setState(() {
      appBarText = appBarText + c;
    });
  }

  bool firstBackspace = true;

  void typeLetter() {
    String tt = targetText;

    int unit = 15;

    void next(int delay, [int? d1]) {
      if (d1 != null) {
        delay = randi(delay, d1);
      }
      Future.delayed(Duration(milliseconds: unit * delay))
          .then((_) => typeLetter());
    }

    if (tt == appBarText) {
      typeQueued = false;
      return;
    } else if (tt.isEmpty) {
      if (appBarText.isNotEmpty) {
        _deleteChar();
        next(4);
      } else {
        typeQueued = false;
        return;
      }
    } else if (appBarText.isEmpty) {
      _typeChar(tt[0]);
      firstBackspace = true;
      next(10, 11);
    } else if (tt.length > appBarText.length) {
      if (tt.substring(0, appBarText.length) == appBarText) {
        _typeChar(tt[appBarText.length]);
        firstBackspace = true;
        next(4, 5);
      } else {
        _deleteChar();
        next(10);
      }
    } else {
      _deleteChar();
      if (firstBackspace) {
        next(6, 10);
      } else {
        next(2, 3);
      }
      firstBackspace = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(appBarText, style: fonts.displayMedium);
  }

  void _updateTargetText() {
    if (widget.page == 0) {
      targetText = DEFAULT_PAGE_TITLE;
    } else {
      targetText = '//${pageTitles[widget.page]}:';
    }
  }

  void _startTyping() {
    typeQueued = true;
    typeLetter();
  }

  @override
  void didUpdateWidget(covariant Typer oldWidget) {
    _updateTargetText();
    if (!typeQueued) {
      _startTyping();
    }
    super.didUpdateWidget(oldWidget);
  }
}

class TypingAppBar extends StatefulWidget implements PreferredSizeWidget {
  final PageController pageController;
  const TypingAppBar({Key? key, required this.pageController})
      : super(key: key);

  @override
  State<TypingAppBar> createState() => _TypingAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class _TypingAppBarState extends State<TypingAppBar> {
  int page = 0;

  @override
  void initState() {
    widget.pageController.addListener(_pageChanged);
    super.initState();
  }

  @override
  void dispose() {
    widget.pageController.removeListener(_pageChanged);
    super.dispose();
  }

  void _pageChanged() {
    int? i = widget.pageController.page?.round();
    if (i != null && page != i && i < pageTitles.length) {
      setState(() {
        page = i;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Typer(page, key: const ValueKey<String>('typer')),
        actions: buildActions(
            context, (section) => scrollToPage(section.pageStart)));
  }
}
