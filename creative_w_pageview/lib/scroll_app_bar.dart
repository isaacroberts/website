import 'package:flutter/material.dart';
import 'package:isaac_roberts_consulting/common_elements.dart';

//Should be added in a stack

class ScrollAppBar extends StatefulWidget {
  final String title;

  const ScrollAppBar({Key? key, required this.title}) : super(key: key);

  @override
  State<ScrollAppBar> createState() => _ScrollAppBarState();
}

class _ScrollAppBarState extends State<ScrollAppBar> {
  @override
  Widget build(BuildContext context) {
    return sectionHeaderNoSliver(context, widget.title);
  }
}
