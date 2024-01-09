import 'package:flutter/material.dart';
import 'package:isaac_roberts_consulting/text_theme.dart';

import 'colorable_flutter_logo.dart';
import 'sections.dart';
import 'theme.dart';
import 'device.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const ColoredFlutterLogoDecoration(
              topColor: flutterLogoTop,
              botColor: flutterLogoBot,
              margin: EdgeInsets.all(15),
            ),
            child: Text(
              'Isaac Roberts',
              style: fonts.displaySmall?.copyWith(
                  color: Colors.white, backgroundColor: Colors.transparent),
            ),
          ),
          for (int n = 0; n < Sections.values.length; ++n)
            drawerListTile(context, n),
          if (Device.width < (theme.drawerTheme.width ?? 150) + 50)
            TextButton(
                child: const Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
        ],
      ),
    );
  }

  ListTile drawerListTile(BuildContext context, int n) {
    return ListTile(
      title: Text(Sections.values[n].name),
      onTap: () {
        Navigator.of(context).pop();
        Future.delayed(const Duration(milliseconds: 350), () {
          scrollToPage(Sections.values[n]);
        });
      },
    );
  }
}
