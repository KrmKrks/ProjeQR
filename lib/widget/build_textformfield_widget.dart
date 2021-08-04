import 'package:flutter/material.dart';

class BuildTextFormField {
  _buildTextFormField(
      TextEditingController controller, String labelText, context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
      child: TextFormField(
        validator: (value) =>
            value!.isEmpty ? 'Bu alanı boş geçemezsiniz.' : null,
        controller: controller,
        style: TextStyle(
            color: Theme.of(context as BuildContext).colorScheme.primary),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            labelText: labelText,
            labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
            border: InputBorder.none),
      ),
    );
  }
}
