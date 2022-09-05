import 'package:flutter/material.dart';

class ThemesProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    appBarTheme: const AppBarTheme(
      color: Color(0xFF0F044C),
    ),
    bottomAppBarColor: Colors.black12,
    primaryColor: const Color(0xFF1A1A1D),
    primaryColorDark: Colors.white,
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFFC3073F),
      secondary: Color(0xFF6F2232),
      tertiary: Color(0xFF4E4E50),
    ),
    iconTheme: const IconThemeData(
      color: Color(0xFFC3073F),
    ),
    fontFamily: 'Nunito',
  );
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color.fromARGB(245, 255, 255, 255),
    appBarTheme: const AppBarTheme(color: Color(0xFFAFD275)),
    //bottomAppBarColor: Colors.green,
    primaryColor: const Color(0XFFC2CAD0),
    primaryColorDark: Colors.black,
    colorScheme: const ColorScheme.light(
      primary: Color(0xFFE7717D),
      secondary: Color(0xFFAFD275),
      tertiary: Color(0xFFC2B9B0),
    ),
    iconTheme: const IconThemeData(
      color: Color(0xFFE7717D),
    ),
    fontFamily: 'Nunito',
  );
}
