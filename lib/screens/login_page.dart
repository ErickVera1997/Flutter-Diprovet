import 'package:flutter/material.dart';
import 'package:flutter_diprovet_cliente/providers/login_form_provider.dart';
import 'package:flutter_diprovet_cliente/services/auth_service.dart';
import 'package:flutter_diprovet_cliente/services/notifications_service.dart';
import 'package:flutter_diprovet_cliente/ui/input_decorations.dart';
import 'package:flutter_diprovet_cliente/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: Column(
          children: [
            const SizedBox(height: 250),
            CardContainer(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Text(
                    'Login',
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
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
              onPressed: () => Navigator.pushReplacementNamed(
                context,
                'routeRegister',
              ),
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(
                  Colors.indigo.withOpacity(0.1),
                ),
                shape: MaterialStateProperty.all(const StadiumBorder()),
              ),
              child: const Text(
                'Crear una nueva cuenta',
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
            ),
            const SizedBox(height: 50),
          ],
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
                loginForm.isLoading ? 'Espere...' : 'Ingresar',
                style: const TextStyle(color: Colors.white, fontSize: 17),
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

                    final String? errorMessage = await authService.login(
                      loginForm.email,
                      loginForm.password,
                    );

                    if (errorMessage == null) {
                      Navigator.pushReplacementNamed(
                        context,
                        '/routeHomeTemp',
                      );
                    } else {
                      print(errorMessage);
                      NotificationsService.showSnackbar(errorMessage);
                      loginForm.isLoading = false;
                    }
                  },
          ),
        ],
      ),
    );
  }
}
