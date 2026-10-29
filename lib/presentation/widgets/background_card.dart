import 'package:flutter/material.dart';

class BackgroundCardProduct extends StatelessWidget {
  const BackgroundCardProduct({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      width: width * 0.8,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
    );
  }
}
