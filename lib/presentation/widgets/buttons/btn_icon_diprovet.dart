import 'package:flutter/material.dart';

class BtnIconDiprovet extends StatelessWidget {
  const BtnIconDiprovet({
    required this.icon,
    required this.onTap,
    Key? key,
    this.btnColor,
  }) : super(key: key);

  final IconData icon;
  final VoidCallback onTap;
  final Color? btnColor;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          btnColor ?? const Color(0xFF4CAF50),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
      icon: Icon(icon, color: Colors.black),
    );
  }
}
