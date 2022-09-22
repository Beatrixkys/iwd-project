import 'package:flutter/material.dart';

import '../constant.dart';
import '../services/auth.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  final AuthService _auth = AuthService();

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
              Icons.local_hospital,
            ),
            title: const Text(
              'Appointments',
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
            leading: const Icon(Icons.lock),
            title: const Text(
              'Log Out',
              style: kTitleTextStyle,
            ),
            onTap: () async {
              await _auth.signOut();

              if (!mounted) return;
              Navigator.pushNamed(context, '/');
            },
          ),
        ],
      ),
    );
  }
}
