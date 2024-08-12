import 'package:flutter/material.dart';
import 'package:flutter_diprovet_cliente/logic/authentication_provider.dart';
import 'package:flutter_diprovet_cliente/presentation/autentication/widgets/login_body.dart';
import 'package:flutter_diprovet_cliente/presentation/autentication/widgets/register_body.dart';
import 'package:flutter_diprovet_cliente/presentation/widgets/buttons/btn_icon_diprovet.dart';
import 'package:flutter_diprovet_cliente/presentation/widgets/loading_overlay.dart';
import 'package:flutter_diprovet_cliente/services/authentication_service.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

enum LoginOrRegisterEnum { login, register }

class LoginOrRegisterPage extends StatelessWidget {
  const LoginOrRegisterPage({
    required this.section,
    super.key,
  });

  static String routeName = 'login-or-register';

  final LoginOrRegisterEnum section;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthenticationProvider(
        service: AuthenticationService(),
      ),
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

    _sectionSelected = widget.section;
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select<AuthenticationProvider, bool>(
      (provider) => provider.isLoading,
    );

    return Scaffold(
      body: LoadingOverlay(
        isLoading: isLoading,
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Stack(
                children: [
                  Center(
                    child: Lottie.asset(
                      'assets/lottie/user.json',
                      repeat: false,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: BtnIconDiprovet(
                      icon: Icons.arrow_back,
                      onTap: context.pop,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _sectionSelected == LoginOrRegisterEnum.login
                          ? 'Iniciar Sesión'
                          : 'Registro',
                      style: const TextStyle(
                        fontSize: 25,
                        letterSpacing: 3,
                        fontWeight: FontWeight.bold,
                      ),
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
            ],
          ),
        ),
      ),
    );
  }
}
