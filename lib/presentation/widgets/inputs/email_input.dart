import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_diprovet_cliente/core/utils.dart';

final _emailRegExp = RegExp(
  r"^[\w.!#$%&'*+/=?^`{|}~-]+@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)+$",
);

class EmailInput extends StatelessWidget {
  const EmailInput({required this.emailController, super.key});

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: 50,
      controller: emailController,
      cursorColor: Colors.black,
      autocorrect: false,
      enableSuggestions: false,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      autofillHints: const [AutofillHints.email],
      inputFormatters: [
        FilteringTextInputFormatter.singleLineFormatter,
        FilteringTextInputFormatter.deny(RegExp(r'\s')),
      ],
      validator: (value) {
        final email = value?.trim() ?? '';

        if (email.isEmpty) return 'Ingresa tu correo electrónico';
        if (!_emailRegExp.hasMatch(email)) return 'Ingresa un correo válido';

        return null;
      },
      decoration: decoration(
        label: 'Email',
        icon: Icons.email_outlined,
      ),
    );
  }
}
