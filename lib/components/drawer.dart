import 'package:flutter/material.dart';

import '../constant.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).primaryColor,
      child: ListView(
        children: [
          ListTile(
            leading: const Icon(
              Icons.home_outlined,
            ),
            title: const Text(
              'Home',
              style: kTitleTextStyle,
            ),
            onTap: () {
              Navigator.pushNamed(context, '/');
            },
          ),
          ListTile(
            leading: const Icon(Icons.miscellaneous_services),
            title: const Text(
              'Services',
              style: kTitleTextStyle,
            ),
            onTap: () {
              Navigator.pushNamed(context, '/services');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.dynamic_form,
            ),
            title: const Text(
              'Form',
              style: kTitleTextStyle,
            ),
            onTap: () {
              Navigator.pushNamed(context, '/form');
            },
          ),
          ListTile(
            leading: const Icon(Icons.phone),
            title: const Text(
              'Contact',
              style: kTitleTextStyle,
            ),
            onTap: () {
              Navigator.pushNamed(context, '/contact');
            },
          ),
          ListTile(
            leading: const Icon(Icons.phone),
            title: const Text(
              'Contact',
              style: kTitleTextStyle,
            ),
            onTap: () {
              Navigator.pushNamed(context, '/auth');
            },
          ),
        ],
      ),
    );
  }
}
