import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:website_wireframe/services/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'models/usermodel.dart';
import 'screens/authscreen.dart';
import 'screens/contactscreen.dart';
import 'screens/aptscreen.dart';
import 'screens/homescreen.dart';
import 'screens/servicesscreen.dart';
import 'services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
      initialData: null,
      value: AuthService().user,
      child: ChangeNotifierProvider(
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
              '/': (context) => const AuthenticationWrapper(),
              '/services': (context) => const ServiceScreen(),
              '/form': (context) => const AptScreen(),
              '/contact': (context) => const ContactScreen(),
              '/signin': (context) => const RegisterLoginScreen(),
            },
          );
        },
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);

    if (user == null) {
      return const RegisterLoginScreen();
    } else {
      return const HomeScreen();
    }
  }
}
