import 'package:flutter/material.dart';
import 'package:flutter_diprovet_cliente/presentation/widgets/buttons/btn_diprovet.dart';
import 'package:go_router/go_router.dart';

class ErrorAlert extends StatelessWidget {
  const ErrorAlert({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Row(
        children: [
          Icon(Icons.error_outline, color: Colors.red, size: 40),
          Text('Error!', style: TextStyle(color: Colors.red)),
        ],
      ),
      content: Text(text),
      actions: [
        BtnDiprovet(text: 'Cerrar', onTap: context.pop),
      ],
    );
  }
}
