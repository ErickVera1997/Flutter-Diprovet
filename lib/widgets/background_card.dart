import 'package:flutter/material.dart';

class BackgroundCardProduct extends StatelessWidget {
  const BackgroundCardProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(width: 3, color: Colors.black),
        color: Colors.grey[50],
      ),
    );
  }
}
