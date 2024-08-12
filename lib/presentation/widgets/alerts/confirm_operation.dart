import 'package:flutter/material.dart';
import 'package:flutter_diprovet_cliente/presentation/widgets/buttons/btn_diprovet.dart';
import 'package:flutter_diprovet_cliente/presentation/widgets/buttons/btn_outline_diprovet.dart';
import 'package:go_router/go_router.dart';

class ConfirmOperationAlert extends StatelessWidget {
  const ConfirmOperationAlert({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Row(
        children: [
          Icon(
            Icons.notification_important_outlined,
            color: Colors.green,
            size: 40,
          ),
          Text('Alerta!', style: TextStyle(color: Colors.green)),
        ],
      ),
      content: Text(text),
      actions: [
        BtnDiprovet(text: 'Aceptar', onTap: () => context.pop(true)),
        BtnOutlineDiprovet(text: 'Cancelar', onTap: () => context.pop(false)),
      ],
    );
  }
}
