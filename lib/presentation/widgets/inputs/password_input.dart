import 'package:flutter/material.dart';
import 'package:flutter_diprovet_cliente/core/utils.dart';

class PasswordInput extends StatefulWidget {
  const PasswordInput({
    required this.passwordController,
    required this.label,
    super.key,
    this.validatePassword,
    this.textInputAction = TextInputAction.next,
  });

  final TextEditingController passwordController;
  final String label;
  final String? validatePassword;
  final TextInputAction textInputAction;

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: 50,
      controller: widget.passwordController,
      obscureText: _isObscured,
      cursorColor: Colors.black,
      autocorrect: false,
      enableSuggestions: false,
      textInputAction: widget.textInputAction,
      keyboardType: TextInputType.visiblePassword,
      validator: (value) {
        if (value == null || value.isEmpty) return 'Campo requerido';

        // Firebase exige al menos 6 caracteres.
        if (value.length < 6) {
          return 'La contraseña debe tener mínimo 6 caracteres';
        }

        final validatePassword = widget.validatePassword;
        if (validatePassword != null && value != validatePassword) {
          return 'La contraseña no coincide';
        }

        return null;
      },
      decoration: decoration(
        label: widget.label,
        icon: Icons.lock_outline_rounded,
        suffixIcon: IconButton(
          onPressed: () => setState(() => _isObscured = !_isObscured),
          icon: Icon(
            !_isObscured
                ? Icons.visibility_off_outlined
                : Icons.remove_red_eye_outlined,
            size: 20,
          ),
        ),
      ),
    );
  }
}
