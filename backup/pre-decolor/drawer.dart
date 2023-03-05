import 'package:flutter/material.dart';

import 'theme.dart';
import 'device.dart';

Widget drawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          child: Text('Freelancing Website'),
          decoration: BoxDecoration(
            color: colorScheme.primary,
          ),
        ),
        ListTile(
          title: Text('Home'),
          onTap: () {
            // Navigate to the home page
          },
        ),
        ListTile(
          title: Text('My Projects'),
          onTap: () {
            // Navigate to the page for viewing and managing projects
          },
        ),
        ListTile(
          title: Text('Messages'),
          onTap: () {
            // Navigate to the messaging page
          },
        ),
        ListTile(
          title: Text('Profile'),
          onTap: () {
            // Navigate to the user's profile page
          },
        ),
        ListTile(
          title: Text('Logout'),
          onTap: () {
            // Log the user out
          },
        ),
      ],
    ),
  );
}
