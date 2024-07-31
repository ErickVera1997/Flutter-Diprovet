import 'package:flutter/material.dart';
import 'package:flutter_diprovet_cliente/presentation/autentication/widgets/login_body.dart';
import 'package:flutter_diprovet_cliente/presentation/autentication/widgets/resgister_body.dart';
import 'package:flutter_diprovet_cliente/presentation/widgets/buttons/btn_icon_diprovet.dart';
import 'package:flutter_diprovet_cliente/presentation/widgets/loading_overlay.dart';
import 'package:flutter_diprovet_cliente/providers/authentication_provider.dart';
import 'package:flutter_diprovet_cliente/services/authentication_service.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

enum LoginOrRegisterEnum { login, register }

class LoginOrRegisterPage extends StatelessWidget {
  const LoginOrRegisterPage({
    required this.section,
    Key? key,
  }) : super(key: key);

  static String routeName = 'login-or-register';

  final LoginOrRegisterEnum section;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          AuthenticationProvider(service: AuthenticationService()),
      builder: (context, child) => _LoginOrRegisterPageWidget(section),
    );
  }
}

class _LoginOrRegisterPageWidget extends StatefulWidget {
  const _LoginOrRegisterPageWidget(this.section);

  final LoginOrRegisterEnum section;

  @override
  State<_LoginOrRegisterPageWidget> createState() {
    return _LoginOrRegisterPageWidgetState();
  }
}

class _LoginOrRegisterPageWidgetState
    extends State<_LoginOrRegisterPageWidget> {
  late LoginOrRegisterEnum _sectionSelected;

  @override
  void initState() {
    super.initState();

    setState(() => _sectionSelected = widget.section);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select<AuthenticationProvider, bool>(
      (provider) => provider.isLoading,
    );

    return Scaffold(
      body: LoadingOverlay(
        isLoading: isLoading,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/logo.jpeg',
                  height: 260,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: BtnIconDiprovet(
                      icon: Icons.arrow_back,
                      onTap: context.pop,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _sectionSelected == LoginOrRegisterEnum.login
                          ? 'Iniciar Sesión'
                          : 'Registro',
                      style: const TextStyle(fontSize: 25),
                    ),
                    const SizedBox(
                      width: 200,
                      child: Divider(color: Colors.yellowAccent),
                    ),
                    const SizedBox(height: 30),
                    if (_sectionSelected == LoginOrRegisterEnum.login)
                      LoginBody(
                        onChangeSection: () => setState(() {
                          _sectionSelected = LoginOrRegisterEnum.register;
                        }),
                      )
                    else
                      RegisterBody(
                        onChangeSection: () => setState(() {
                          _sectionSelected = LoginOrRegisterEnum.login;
                        }),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
