import 'package:flutter/material.dart';

class BackgroundCardProduct extends StatelessWidget {
  const BackgroundCardProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
    );
  }
}
