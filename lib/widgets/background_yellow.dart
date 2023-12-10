import 'package:flutter/material.dart';

class BackgroundYellow extends StatelessWidget {
  const BackgroundYellow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: MediaQuery.of(context).size.width * 0.32,
      color: Colors.yellow,
    );
  }
}
