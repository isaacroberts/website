import 'package:flutter/material.dart';
import 'common_elements.dart';
import 'dart:developer';
import 'device.dart';
import 'theme.dart';
import 'text_theme.dart';

class ColorSwitcher extends StatefulWidget {
  const ColorSwitcher({Key? key}) : super(key: key);

  @override
  State<ColorSwitcher> createState() => _ColorSwitcherState();
}

class _ColorSwitcherState extends State<ColorSwitcher> {
  int current = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(child: row1(context)),
          Flexible(child: row2(context)),
        ]);
  }

  Widget row1(BuildContext context) {
    return Container(
        height: 500,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: assetProvider(
                  'images/bg_field.jpg',
                ),
                fit: BoxFit.cover)),
        child: Card(
            margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text('Customizable Design', style: fonts.headlineLarge),
                      // const SizedBox(height: 15),
                      // paragraph(lorem(words: 20), leftAlign: false)
                    ]))));
  }

  Widget row2(BuildContext context) {
    return Center(child: colorIconRow(context));
  }

  Widget colorIcon(BuildContext context, Color color) {
    return IconButton(
      icon: const Icon(Icons.circle),
      color: color,
      onPressed: () {},
    );
  }

  Widget colorIconRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        colorIcon(context, Colors.red),
        // SizedBox(width: 15,)
        colorIcon(context, colorScheme.primary),
        colorIcon(context, Colors.blue),
      ],
    );
  }
}
