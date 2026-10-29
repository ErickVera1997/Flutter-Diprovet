import 'package:flutter/material.dart';
import 'package:flutter_diprovet_cliente/presentation/widgets/buttons/btn_diprovet.dart';
import 'package:flutter_diprovet_cliente/presentation/widgets/buttons/btn_outline_diprovet.dart';

class ConfirmOperationAlert extends StatelessWidget {
  const ConfirmOperationAlert({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Alerta!', style: TextStyle(color: Colors.green)),
      content: Text(text),
      actions: [
        BtnDiprovet(
          text: 'Aceptar',
          onTap: () => Navigator.of(context).pop(true),
        ),
        BtnOutlineDiprovet(
          text: 'Cancelar',
          onTap: () => Navigator.of(context).pop(false),
        ),
      ],
    );
  }
}
