import 'package:flutter/material.dart';

Color deepOrange = Colors.deepOrange.shade400;

class InputDecorations {
  static InputDecoration authInputDecoration({
    required String hintText,
    required String labelText,
    IconData? prefixIcon,
  }) {
    return InputDecoration(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: deepOrange),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: deepOrange, width: 2),
      ),
      hintText: hintText,
      labelText: labelText,
      labelStyle: TextStyle(color: deepOrange),
      prefixIcon: prefixIcon != null
          ? Icon(
              prefixIcon,
              color: Colors.deepOrange[400],
            )
          : null,
    );
  }
}
