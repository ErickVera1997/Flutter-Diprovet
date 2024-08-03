import 'package:flutter_diprovet_cliente/presentation/autentication/autentication_page.dart';
import 'package:flutter_diprovet_cliente/presentation/autentication/login_or_register_page.dart';
import 'package:flutter_diprovet_cliente/presentation/screens.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const AuthenticationPage(),
    ),
    GoRoute(
      name: LoginOrRegisterPage.routeName,
      path: '/${LoginOrRegisterPage.routeName}',
      builder: (context, state) {
        final sectionSelected = state.extra! as LoginOrRegisterEnum;

        return LoginOrRegisterPage(section: sectionSelected);
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
      name: DetailScreen.routeName,
      path: '/${DetailScreen.routeName}',
      builder: (context, state) {
        final arg = state.extra! as DetailArg;

        return DetailScreen(arg: arg);
      },
    ),
    GoRoute(
      name: ShoppingPage.routeName,
      path: '/${ShoppingPage.routeName}',
      builder: (context, state) {
        final arg = state.extra! as ShoppingPageArg;

        return ShoppingPage(arg: arg);
      },
    ),
  ],
);
