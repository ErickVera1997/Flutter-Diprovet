import 'package:flutter/material.dart';
import 'package:flutter_diprovet_cliente/screens/home_page.dart';
import 'package:flutter_diprovet_cliente/screens/home_temp.dart';
import 'package:flutter_diprovet_cliente/screens/login_page.dart';
import 'package:flutter_diprovet_cliente/screens/product_screen/products_screen.dart';
import 'package:flutter_diprovet_cliente/screens/register_page.dart';
import 'package:flutter_diprovet_cliente/screens/shopping_page.dart';
import 'package:flutter_diprovet_cliente/services/auth_service.dart';
import 'package:flutter_diprovet_cliente/services/details_service.dart';
import 'package:flutter_diprovet_cliente/services/products_service.dart';

import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductsNotifier()),
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => DetailService()),
      ],
      child: MaterialApp(
        initialRoute: '/routeHomeTemp',
        routes: {
          '/routeHome': (_) => const HomePage(),
          '/routeHomeTemp': (_) => const TempPage(),
          '/routeProducts': (_) => const ProductsScreen(),
          '/routeShopping': (_) => const ShoppingCardPage(),
          '/routeLogin': (_) => const LoginPage(),
          '/routeRegister': (_) => const RegisterPage(),
        },
      ),
    );
  }
}
