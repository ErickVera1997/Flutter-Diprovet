import 'package:flutter/material.dart';
import 'package:flutter_diprovet_cliente/widgets/widgets.dart';

class ThreeBackground extends StatelessWidget {
  const ThreeBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        BackgroundYellow(),
        SizedBox(width: 1),
        BackgroundYellow(),
        SizedBox(width: 1),
        BackgroundYellow(),
      ],
    );
  }
}
