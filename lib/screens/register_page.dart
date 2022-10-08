import 'package:flutter/material.dart';
import 'package:flutter_diprovet_cliente/providers/login_form_provider.dart';
import 'package:flutter_diprovet_cliente/services/auth_service.dart';
import 'package:flutter_diprovet_cliente/ui/input_decorations.dart';
import 'package:flutter_diprovet_cliente/widgets/widgets.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 250),
              CardContainer(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      'Crear Cuenta',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    const SizedBox(height: 30),
                    ChangeNotifierProvider(
                      create: (_) => LoginFormProvider(),
                      child: _LoginForm(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              TextButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, 'routeLogin'),
                style: ButtonStyle(
                  overlayColor:
                      MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
                  shape: MaterialStateProperty.all(const StadiumBorder()),
                ),
                child: const Text(
                  '¿Ya tienes una cuenta?',
                  style: TextStyle(fontSize: 15, color: Colors.black87),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Form(
      //mantener la referencia del key validaciones respectivas
      key: loginForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
              hintText: 'erickaldair97@gmail.com',
              labelText: 'Correo Electrónico',
              prefixIcon: Icons.alternate_email_rounded,
            ),
            onChanged: (value) => loginForm.email = value,
            validator: (value) {
              String pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp = RegExp(pattern);

              return regExp.hasMatch(value ?? '')
                  ? null
                  : 'El valor ingresado no luce como correo';
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
              hintText: '*****',
              labelText: 'Contraseña',
              prefixIcon: Icons.lock_open_outlined,
            ),
            onChanged: (value) => loginForm.password = value,
            validator: (value) {
              return (value != null && value.length >= 6)
                  ? null
                  : 'La contraseña debe ser de 6 caracteres';
            },
          ),
          const SizedBox(height: 30),
          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            disabledColor: Colors.grey,
            elevation: 0,
            color: Colors.deepOrange[400],
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              child: Text(
                loginForm.isLoading ? 'Espere...' : 'Registrar',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            onPressed: loginForm.isLoading
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final authService =
                        Provider.of<AuthService>(context, listen: false);

                    if (!loginForm.isvalidform()) return;

                    loginForm.isLoading = true;

                    final String? errorMessage = await authService.createUser(
                      loginForm.email,
                      loginForm.password,
                    );

                    if (errorMessage == null) {
                      Navigator.pushReplacementNamed(context, 'routeLogin');
                    } else {
                      print(errorMessage);
                      loginForm.isLoading = false;
                    }
                  },
          ),
        ],
      ),
    );
  }
}
