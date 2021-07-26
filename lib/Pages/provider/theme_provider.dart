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
    primaryColor: Colors.grey[200],
    backgroundColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(primary: Colors.black),
    iconTheme: IconThemeData(color: Colors.red, opacity: 0.8),
    shadowColor: Colors.blue,
    textTheme: TextTheme(
      headline1: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 16,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.normal,
      ),
    ),
  );

  static final darkTheme = ThemeData(
    primaryColor: Color(0xFF232b38),
    backgroundColor: Color(0xFF1E304E),
    scaffoldBackgroundColor: Color(0xFF232b38),
    colorScheme: ColorScheme.light(primary: Colors.yellow),
    iconTheme: IconThemeData(color: Colors.amber[800], opacity: 0.8),
    shadowColor: Colors.white,
    textTheme: TextTheme(
      headline1: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.normal,
      ),
    ),
  );
}
