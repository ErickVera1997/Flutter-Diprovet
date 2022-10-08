import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration authInputDecoration({
    required String hintText,
    required String labelText,
    IconData? prefixIcon,
  }) {
    return InputDecoration(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: green,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: green,
          width: 2,
        ),
      ),
      hintText: hintText,
      labelText: labelText,
      labelStyle: TextStyle(
        color: green,
      ),
      prefixIcon: prefixIcon != null
          ? Icon(
              prefixIcon,
              color: Colors.deepOrange[400],
            )
          : null,
    );
  }
}

Color green = Colors.deepOrange.shade400;
