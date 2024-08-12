import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_diprovet_cliente/core/routes.dart';
import 'package:flutter_diprovet_cliente/logic/products_provider.dart';
import 'package:flutter_diprovet_cliente/logic/shopping_provider.dart';
import 'package:flutter_diprovet_cliente/services/products_service.dart';

import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductsProvider(
            productService: ProductsService(Dio()),
          ),
        ),
        ChangeNotifierProvider(create: (context) => ShoppingProvider()),
      ],
      builder: (context, child) => const MyAppWidget(),
    );
  }
}

class MyAppWidget extends StatelessWidget {
  const MyAppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Diprovet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.light(primary: Colors.yellowAccent),
      ),
    );
  }
}
