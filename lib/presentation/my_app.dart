import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_diprovet_cliente/core/dio_interceptors.dart';
import 'package:flutter_diprovet_cliente/core/routes.dart';
import 'package:flutter_diprovet_cliente/logic/authentication_provider.dart';
import 'package:flutter_diprovet_cliente/logic/products_provider.dart';
import 'package:flutter_diprovet_cliente/logic/shopping_provider.dart';
import 'package:flutter_diprovet_cliente/services/authentication_service.dart';
import 'package:flutter_diprovet_cliente/services/products_service.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthenticationProvider(
            service: AuthenticationService(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductsProvider(
            productService: ProductsService(_createDio()),
          ),
        ),
        ChangeNotifierProvider(create: (_) => ShoppingProvider()),
      ],
      builder: (context, child) => const _MyAppWidget(),
    );
  }

  Dio _createDio() {
    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ),
    );

    return DioInterceptors(dio).dioWithInterceptors;
  }
}

class _MyAppWidget extends StatelessWidget {
  const _MyAppWidget();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Diprovet',
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.light(primary: Color(0xFF98B136)),
      ),
    );
  }
}
