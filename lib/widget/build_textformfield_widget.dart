import 'package:flutter/material.dart';
import 'package:projeqr/provider/theme_provider.dart';
import 'package:provider/provider.dart';

buildTextFormField(
    TextEditingController controller, String labelText, context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
        border: Border.all(
            color:
                Provider.of<ThemeProvider>(context as BuildContext).isDarkMode
                    ? Colors.blue
                    : Color(0xFF84EE9D),
            width: 2),
        borderRadius: BorderRadius.circular(10)),
    child: TextFormField(
      validator: (value) =>
          value!.isEmpty ? 'Bu alanı boş geçemezsiniz.' : null,
      controller: controller,
      style: Theme.of(context).textTheme.headline2,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          labelText: labelText,
          labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
          border: InputBorder.none),
    ),
  );
}
