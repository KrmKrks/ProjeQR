import 'package:flutter/material.dart';
import 'package:projeqr/provider/theme_provider.dart';
import 'package:projeqr/shared/theme_decoration.dart';
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

groupTextFormField(
    TextEditingController controller1,
    TextEditingController controller2,
    String introduction,
    String labelText1,
    String labelText2,
    context) {
  return Container(
    decoration: BoxDecoration(
      color: Theme.of(context as BuildContext).colorScheme.background,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: Provider.of<ThemeProvider>(context).isDarkMode
            ? Colors.blue
            : Color(0xFF84EE9D),
        width: 1,
      ),
    ),
    child: Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
              child: Text(
                introduction,
                style: Theme.of(context)
                    .textTheme
                    .headline1
                    ?.copyWith(color: Color(0xFF83D2D4).withOpacity(0.8)),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: TextFormField(
            validator: (value) =>
                value!.isEmpty ? 'Bu alanı boş geçemezsiniz.' : null,
            controller: controller1,
            decoration: themeInputDecoration(context, labelText1),
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 7),
          child: TextFormField(
            controller: controller2,
            decoration: themeInputDecoration(context, labelText2),
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
      ],
    ),
  );
}

customTextFormField(
    TextEditingController controller, String labelText, context) {
  return TextFormField(
    validator: (value) => value!.isEmpty ? 'Bu alanı boş geçemezsiniz.' : null,
    controller: controller,
    decoration: themeInputDecoration(context, labelText),
    style: Theme.of(context as BuildContext).textTheme.headline2,
  );
}
