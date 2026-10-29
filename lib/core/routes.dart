import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_diprovet_cliente/presentation/autentication/autentication_page.dart';
import 'package:flutter_diprovet_cliente/presentation/autentication/login_or_register_page.dart';
import 'package:flutter_diprovet_cliente/presentation/screens.dart';
import 'package:flutter_diprovet_cliente/presentation/shopping/cart_shopping_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  redirect: (context, state) {
    final isLoggedIn = FirebaseAuth.instance.currentUser != null;
    final isPublicRoute = state.matchedLocation == '/' ||
        state.matchedLocation == '/${LoginOrRegisterPage.routeName}';

    if (!isLoggedIn && !isPublicRoute) return '/';

    return null;
  },
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const AuthenticationPage(),
    ),
    GoRoute(
      name: LoginOrRegisterPage.routeName,
      path: '/${LoginOrRegisterPage.routeName}',
      builder: (context, state) {
        final extra = state.extra;
        final section =
            extra is LoginOrRegisterEnum ? extra : LoginOrRegisterEnum.login;

        return LoginOrRegisterPage(section: section);
      },
    ),
    GoRoute(
      name: HomePage.routeName,
      path: '/${HomePage.routeName}',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      name: ProductsPage.routeName,
      path: '/${ProductsPage.routeName}',
      builder: (context, state) => const ProductsPage(),
    ),
    GoRoute(
      name: ProductDetailPage.routeName,
      path: '/${ProductDetailPage.routeName}',
      builder: (context, state) {
        final extra = state.extra;
        if (extra is! ProductDetailPageArg) return const HomePage();

        return ProductDetailPage(arg: extra);
      },
    ),
    GoRoute(
      name: ShoppingPage.routeName,
      path: '/${ShoppingPage.routeName}',
      builder: (context, state) => const ShoppingPage(),
    ),
    GoRoute(
      name: CartShoppingPage.routeName,
      path: '/${CartShoppingPage.routeName}',
      builder: (context, state) => const CartShoppingPage(),
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Página no encontrada'),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () => context.go('/'),
            child: const Text('Volver al inicio'),
          ),
        ],
      ),
    ),
  ),
);
