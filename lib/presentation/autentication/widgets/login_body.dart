import 'package:flutter/material.dart';
import 'package:flutter_diprovet_cliente/logic/authentication_provider.dart';
import 'package:flutter_diprovet_cliente/presentation/home_page.dart';
import 'package:flutter_diprovet_cliente/presentation/widgets/buttons/btn_diprovet.dart';
import 'package:flutter_diprovet_cliente/presentation/widgets/inputs/email_input.dart';
import 'package:flutter_diprovet_cliente/presentation/widgets/inputs/password_input.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({required this.onChangeSection, super.key});

  final VoidCallback onChangeSection;

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isSavedPassword = false;

  Future<void> _signInUser() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (!_formKey.currentState!.validate()) return;

    final response = await context.read<AuthenticationProvider>().signInUser(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

    if (!mounted) return;
    response.fold(
      (errorMessage) {
        /*  showDialog<void>(
        context: context,
        builder: (context) => ErrorAlert(text: errorMessage),
      );*/
      },
      (unit) {
        context.goNamed(HomePage.routeName);
      },
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          EmailInput(emailController: _emailController),
          const SizedBox(height: 30),
          PasswordInput(
            passwordController: _passwordController,
            label: 'Contraseña',
          ),
          Row(
            children: [
              Checkbox(
                value: _isSavedPassword,
                onChanged: (value) {
                  setState(() => _isSavedPassword = value ?? false);
                },
              ),
              const Text('Recordar contraseña', style: TextStyle(fontSize: 15)),
            ],
          ),
          const SizedBox(height: 50),
          const Center(
            child: Text(
              '¿Olvidaste tu contraseña?',
              style: TextStyle(fontSize: 15, color: Colors.blueAccent),
            ),
          ),
          const SizedBox(height: 20),
          BtnDiprovet(text: 'Iniciar sesión', onTap: _signInUser),
          const SizedBox(height: 30),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '¿Aun no tienes una cuenta?',
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: widget.onChangeSection,
                  child: const Text(
                    'Regístrate',
                    style: TextStyle(fontSize: 15, color: Colors.blueAccent),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
