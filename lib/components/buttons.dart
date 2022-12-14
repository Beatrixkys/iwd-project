import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/themes.dart';

class ChangeThemeButton extends StatelessWidget {
  const ChangeThemeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemesProvider>(context);

    return Switch.adaptive(
      value: themeProvider.isDarkMode,
      onChanged: (value) {
        final provider = Provider.of<ThemesProvider>(context, listen: false);
        provider.toggleTheme(value);
      },
    );
  }
}
