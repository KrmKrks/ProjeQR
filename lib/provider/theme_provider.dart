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
    primaryColor: Color(0xFF71A8E7),
    backgroundColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(primary: Colors.black),
    iconTheme: IconThemeData(color: Color(0xFF212d40), opacity: 0.8),
    shadowColor: Colors.blue,
    buttonColor: Color(0xFFff9f1c) /*Color(0xFF91f3fc)*/,
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
    primaryColor: Color(0xFF2C5364)

    /*Color(0xFF232b38)*/,
    backgroundColor: Color(0xFF8AA8DD),
    cardColor: Color(0xFF536B94),
    scaffoldBackgroundColor: Color(0xFF3F4D64),
    colorScheme: ColorScheme.light(primary: Color(0xFFd9dad7)),
    iconTheme: IconThemeData(color: Colors.amber[800], opacity: 0.8),
    shadowColor: Colors.white,
    buttonColor: Color(0xFFB9182A) /*Color(0xFFc24d2c)*/,
    textTheme: TextTheme(
      headline1: TextStyle(
        decoration: TextDecoration.none,
        fontFamily: 'Roboto',
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.normal,
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
