import 'dart:ui';

import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;
  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  static of(BuildContext context) {}
}

class AppThemes {
  static final lightTheme = ThemeData(
    primaryColor: Color(0xFF71B280),
    backgroundColor: Color(0xFF71B280),
    cardColor: Color(0xFF80CF93),
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(
      primary: Colors.white,
      background: Color(0xFF80CF93).withOpacity(0.95),
    ),
    iconTheme: IconThemeData(color: Colors.amber[900], opacity: 0.8),
    shadowColor: Colors.white,
    textTheme: TextTheme(
      headline1: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.normal,
        color: Colors.white,
      ),
      headline2: TextStyle(
        decoration: TextDecoration.none,
        fontFamily: 'Roboto',
        fontSize: 16,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
        color: Colors.white,
      ),
      button: TextStyle(
          color: Color(0xFFDFE7D0),
          backgroundColor: Color(0xDAFFA01C),
          fontSize: 18,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF134E5E),
      unselectedItemColor: Color(0xFF71B280).withOpacity(0.8),
      unselectedIconTheme: IconThemeData(
        color: Colors.amber[900],
      ),
      selectedIconTheme: IconThemeData(
        color: Colors.amber[900],
      ),
    ),
  );

  static final darkTheme = ThemeData(
    primaryColor: Color(0xFF2C5364),
    backgroundColor: Color(0xFF243B55).withOpacity(0.95),
    cardColor: Color(0xff457b9d), //Color(0xFF536B94),
    scaffoldBackgroundColor: Color(0xFF3F4D64),
    colorScheme: ColorScheme.dark(
      primary: Color(0xFFd9dad7),
      background: Color(0xFF243B55).withOpacity(0.95),
    ),
    iconTheme: IconThemeData(color: Colors.amber[800], opacity: 0.8),
    shadowColor: null,

    textTheme: TextTheme(
      headline1: TextStyle(
          decoration: TextDecoration.none,
          fontFamily: 'Roboto',
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal,
          color: Color(0xFF83D2D4)), //Color(0xFFC8C6C5)),
      headline2: TextStyle(
        decoration: TextDecoration.none,
        fontFamily: 'Roboto',
        fontSize: 16,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
        color: Color(0xFFd9dad7),
      ),
      button: TextStyle(
          color: Color(0xFFd9dad7),
          backgroundColor: Color(0xFFB9182A),
          fontSize: 18,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF141E30),
      unselectedItemColor: Color(0xFF243B55),
      unselectedIconTheme: IconThemeData(
        color: Color(0xFFB9182A),
      ),
      selectedIconTheme: IconThemeData(
        color: Color(0xFFB9182A),
      ),
      unselectedLabelStyle: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 14,
      ),
    ),
  );
}

List<Color> gradientDarkMode = [
  Color(0xFF141E30),
  Color(0xFF243B55),
];
List<Color> gradientLightMode = [
  Color(0xFF71B280),
  Color(0xFF134E5E),
  // Color(0xFF91EAE4),
  // Color(0xFF71A8E7),
  // Color(0xFF7F7FD5),
];
//Color(0xFF2BC0E4), Color(0xFFEAECC6)
