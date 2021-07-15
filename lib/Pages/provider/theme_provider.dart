import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;
  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class AppThemes {
  static final lightTheme = ThemeData(
    primaryColor: Colors.white,
    backgroundColor: Colors.white24,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(primary: Colors.black),
    iconTheme: IconThemeData(color: Colors.red, opacity: 0.8),
    shadowColor: Colors.blue,
  );

  static final darkTheme = ThemeData(
    primaryColor: Color(0xFF232b38),
    backgroundColor: Colors.black12,
    scaffoldBackgroundColor: Color(0xFF232b38),
    colorScheme: ColorScheme.light(primary: Colors.yellow),
    iconTheme: IconThemeData(color: Colors.amber[800], opacity: 0.8),
    shadowColor: Colors.white,
  );
}
