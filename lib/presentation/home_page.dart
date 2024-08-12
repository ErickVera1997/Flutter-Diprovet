import 'package:flutter/material.dart';
import 'package:flutter_diprovet_cliente/core/models/category.dart';
import 'package:flutter_diprovet_cliente/logic/authentication_provider.dart';
import 'package:flutter_diprovet_cliente/logic/products_provider.dart';
import 'package:flutter_diprovet_cliente/presentation/products/products_page.dart';
import 'package:flutter_diprovet_cliente/presentation/widgets/alerts/confirm_operation.dart';
import 'package:flutter_diprovet_cliente/services/authentication_service.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static String routeName = 'home';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return AuthenticationProvider(service: AuthenticationService());
      },
      builder: (context, child) => const _HomePageWidget(),
    );
  }
}

class _HomePageWidget extends StatefulWidget {
  const _HomePageWidget();

  @override
  State<_HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<_HomePageWidget> {
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
    final categories = context.watch<ProductsProvider>().categories;
    final userName = context.select<AuthenticationProvider, String>(
      (provider) => provider.user?.displayName ?? '',
    );
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.yellow[50],
      appBar: AppBar(
        centerTitle: false,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomCenter,
              stops: const [0.3, 0.8],
              colors: [
                const Color.fromARGB(197, 128, 185, 224),
                Colors.green[700]!,
              ],
            ),
          ),
        ),
        title: const Text(
          '   Diprovet',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          const Icon(Icons.person, color: Colors.black),
          const SizedBox(width: 5),
          const Icon(Icons.notifications_none, color: Colors.black),
          const SizedBox(width: 5),
          PopupMenuButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 0,
                onTap: _onCloseSession,
                child: const Text('Cerrar sesión'),
              ),
            ],
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hola $userName!',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Lottie.asset(
                      'assets/lottie/horse_home.json',
                      height: 35,
                    ),
                  ],
                ),
              ),
              const Divider(color: Colors.black12),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Categorias',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: height * 0.65,
                child: ListView.separated(
                  itemCount: categories.length,
                  itemBuilder: (context, index) => _CardHome(categories[index]),
                  separatorBuilder: (_, __) => const SizedBox(height: 30),
                ),
              ),
              const SizedBox(height: 20),
              const Divider(color: Colors.black12),
            ],
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
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Row(
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(90),
                ),
                child: ClipOval(
                  child: Lottie.asset(
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
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.blue[100],
                ),
                child: IconButton(
                  iconSize: 30,
                  icon: const Icon(Icons.chevron_right_outlined),
                  color: Colors.black,
                  onPressed: () {
                    context.read<ProductsProvider>().selectedCategory =
                        category.name;
                    context.goNamed(ProductsPage.routeName);
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
      width: 320,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
