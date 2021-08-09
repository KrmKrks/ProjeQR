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
