import 'dart:io';

import 'package:flutter/material.dart';
import 'package:projeqr/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class ChangeThemeButtonWidget extends StatefulWidget {
  @override
  _ChangeThemeButtonWidgetState createState() =>
      _ChangeThemeButtonWidgetState();
}

class _ChangeThemeButtonWidgetState extends State<ChangeThemeButtonWidget> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Transform.scale(
      scale: Platform.isAndroid ? 1.5 : 1,
      child: Switch.adaptive(
        value: themeProvider.isDarkMode,
        activeThumbImage: AssetImage('assets/images/half-moon.png'),
        inactiveThumbImage: AssetImage('assets/images/clouds-and-sun.png'),
        inactiveTrackColor: Colors.yellow,
        onChanged: (value) {
          final provider = Provider.of<ThemeProvider>(context, listen: false);
          provider.toggleTheme(value);
        },
      ),
    );
  }
}
