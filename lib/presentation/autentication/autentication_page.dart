import 'package:flutter/material.dart';
import 'package:flutter_diprovet_cliente/logic/authentication_provider.dart';
import 'package:flutter_diprovet_cliente/presentation/autentication/login_or_register_page.dart';
import 'package:flutter_diprovet_cliente/presentation/screens.dart';
import 'package:flutter_diprovet_cliente/presentation/widgets/buttons/btn_diprovet.dart';
import 'package:flutter_diprovet_cliente/services/authentication_service.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return AuthenticationProvider(service: AuthenticationService());
      },
      builder: (context, child) => const _AuthenticatedPageWidget(),
    );
  }
}

class _AuthenticatedPageWidget extends StatefulWidget {
  const _AuthenticatedPageWidget();

  @override
  State<_AuthenticatedPageWidget> createState() {
    return _AuthenticatedPageStateWidget();
  }
}

class _AuthenticatedPageStateWidget extends State<_AuthenticatedPageWidget> {
  bool _isLoading = true;

  Future<void> _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 2500), () {});
    if (!mounted) return;
    final user = context.read<AuthenticationProvider>().user;
    setState(() => _isLoading = false);
    if (user != null) {
      context.goNamed(HomePage.routeName);
    }
  }

  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            right: 0,
            left: 0,
            child: Lottie.asset('assets/logo.json'),
          ),
          SafeArea(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.green),
                  )
                : Column(
                    children: [
                      const SizedBox(height: 50),
                      const Text(
                        'DIPROVET',
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 5,
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Column(
                          children: [
                            BtnDiprovet(
                              text: 'Iniciar sesión',
                              onTap: () => context.pushNamed(
                                LoginOrRegisterPage.routeName,
                                extra: LoginOrRegisterEnum.login,
                              ),
                            ),
                            const SizedBox(height: 5),
                            BtnDiprovet(
                              text: 'Registrarme',
                              btnColor: const Color(0xAA9B9C9D),
                              onTap: () => context.pushNamed(
                                LoginOrRegisterPage.routeName,
                                extra: LoginOrRegisterEnum.register,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
