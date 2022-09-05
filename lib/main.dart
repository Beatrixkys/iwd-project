import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:website_wireframe/services/themes.dart';

import 'screens/authscreen.dart';
import 'screens/contactscreen.dart';
import 'screens/formscreen.dart';
import 'screens/homescreen.dart';
import 'screens/servicesscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemesProvider(),
      builder: (context, _) {
        final themeProvider = Provider.of<ThemesProvider>(context);
        return MaterialApp(
          title: "Website",
          themeMode: themeProvider.themeMode,
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
          initialRoute: '/',
          routes: {
            '/': (context) => const HomeScreen(),
            '/services': (context) => const ServiceScreen(),
            '/form': (context) => const FormScreen(),
            '/contact': (context) => const ContactScreen(),
            '/auth': (context) => const AuthScreen(),
            '/signin': (context) => const RegisterLoginScreen(),
          },
        );
      },
    );
  }
}
