import 'package:flutter/material.dart';
import 'package:flutter_diprovet_cliente/models/category.dart';
import 'package:flutter_diprovet_cliente/presentation/product_screen/products_screen.dart';
import 'package:flutter_diprovet_cliente/presentation/widgets/alerts/confirm_operation.dart';
import 'package:flutter_diprovet_cliente/providers/authentication_provider.dart';
import 'package:flutter_diprovet_cliente/providers/products_notifier.dart';
import 'package:flutter_diprovet_cliente/services/authentication_service.dart';
import 'package:flutter_diprovet_cliente/widgets/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static String routeName = 'home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          const BackgroundYellow(),
          ChangeNotifierProvider(
            create: (context) {
              return AuthenticationProvider(service: AuthenticationService());
            },
            builder: (context, child) => const _CardSuperior(),
          ),
        ],
      ),
    );
  }
}

class _CardSuperior extends StatefulWidget {
  const _CardSuperior();

  @override
  State<_CardSuperior> createState() => _CardSuperiorState();
}

class _CardSuperiorState extends State<_CardSuperior> {
  Future<void> _onCloseSession() async {
    final validateClose = await showDialog<bool>(
          context: context,
          builder: (context) {
            return const ConfirmOperationAlert(
              text: 'Al cerrar sesión perdera todos'
                  ' sus registros, ¿Desea continuar?',
            );
          },
        ) ??
        false;

    if (!validateClose || !mounted) return;
    final response = await context.read<AuthenticationProvider>().logOutUser();

    if (!mounted) return;
    response.fold(
      (errorMessage) {
        /*showDialog<void>(
          context: context,
          builder: (context) => ErrorAlert(text: errorMessage),
        );*/
      },
      (unit) {
        context.go('/');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final categories = context.watch<ProductsNotifier>().categories;

    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.apps, size: 40, color: Colors.black),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
              const SizedBox(width: 240),
              IconButton(
                icon: const Icon(
                  Icons.add_shopping_cart_rounded,
                  size: 30,
                  color: Colors.black,
                ),
                onPressed: _onCloseSession,
              ),
            ],
          ),
          const SizedBox(height: 30),
          Expanded(
            child: ListView.separated(
              itemCount: categories.length,
              itemBuilder: (context, index) => _CardHome(categories[index]),
              separatorBuilder: (_, __) => const SizedBox(height: 30),
            ),
          ),
        ],
      ),
    );
  }
}

class _CardHome extends StatelessWidget {
  const _CardHome(this.category);

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        const _BackGroundWhite(),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 40),
          child: Row(
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(90),
                ),
                child: ClipOval(
                  child: Image.asset(
                    category.path,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    category.name,
                    style: const TextStyle(
                      color: Colors.amber,
                      fontSize: 20,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.yellow,
                ),
                child: IconButton(
                  iconSize: 30,
                  icon: const Icon(Icons.chevron_right_outlined),
                  color: Colors.black,
                  onPressed: () {
                    context.read<ProductsNotifier>().selectedCategory =
                        category.name;
                    context.goNamed(ProductsScreen.routeName);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _BackGroundWhite extends StatelessWidget {
  const _BackGroundWhite();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 110,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
