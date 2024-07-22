import 'package:flutter/material.dart';
import 'package:flutter_diprovet_cliente/providers/products_notifier.dart';
import 'package:flutter_diprovet_cliente/screens/screens.dart';
import 'package:flutter_diprovet_cliente/services/auth_service.dart';
import 'package:flutter_diprovet_cliente/services/details_service.dart';
import 'package:flutter_diprovet_cliente/services/products_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductsNotifier(ProductsService()),
        ),
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
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''), // Inglés
          Locale('es', ''), // Español
        ],
      ),
    );
  }
}
