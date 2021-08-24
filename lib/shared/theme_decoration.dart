import 'package:flutter/material.dart';
import 'package:projeqr/provider/theme_provider.dart';
import 'package:provider/provider.dart';

Decoration themeDecoration(context, BorderRadius borderRadius) {
  return BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: Provider.of<ThemeProvider>(context as BuildContext).isDarkMode
            ? gradientDarkMode
            : gradientLightMode),
    borderRadius: borderRadius,
  );
}

Decoration themeDecorationForm(context) {
  return BoxDecoration(
    color: Theme.of(context as BuildContext).colorScheme.background,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(
      color: Provider.of<ThemeProvider>(context).isDarkMode
          ? Colors.blue
          : Color(0xFF84EE9D),
      width: 1,
    ),
  );
}

InputDecoration themeInputDecoration(context, String labelText) {
  return InputDecoration(
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Provider.of<ThemeProvider>(context as BuildContext).isDarkMode
            ? Colors.blue
            : Color(0xFF84EE9D),
      ),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Provider.of<ThemeProvider>(context).isDarkMode
            ? Colors.blue
            : Color(0xFF84EE9D),
      ),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 10),
    labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
    labelText: labelText,
  );
}
