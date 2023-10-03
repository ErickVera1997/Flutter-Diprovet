import 'package:flutter/material.dart';
import 'package:flutter_diprovet_cliente/models/category.dart';
import 'package:flutter_diprovet_cliente/services/products_service.dart';

import 'package:flutter_diprovet_cliente/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: Builder(
      //     builder: (BuildContext context) {
      //       return IconButton(
      //         icon: Icon(Icons.menu), // Icono del menú
      //         onPressed: () {
      //           Scaffold.of(context).openDrawer(); // Abre el drawer
      //         },
      //       );
      //     },
      //   ),
      // ),
      drawer: _CustomDrawer(),
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: const [
          BackgroundYellow(),
          _CardSuperior(),
        ],
      ),
    );
  }
}

class _CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.red,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text(
                  'Perfil',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Configuraciones',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.arrow_back,
            ), // Icono para indicar que hay un drawer
            title: const Text('Otra sección'),
            onTap: () {
              // Agregar navegación a la otra sección
            },
          ),
        ],
      ),
    );
  }
}

class _CardSuperior extends StatelessWidget {
  const _CardSuperior();

  @override
  Widget build(BuildContext context) {
    final newService = Provider.of<ProductsService>(context).categories;

    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 20),
          _Icons(),
          const SizedBox(height: 30),
          Expanded(
            child: ListView.separated(
              itemCount: newService.length,
              itemBuilder: (context, index) => _CardHome(newService[index]),
              separatorBuilder: (_, __) => const SizedBox(height: 30),
            ),
          ),
        ],
      ),
    );
  }
}

class _Icons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.apps, size: 40, color: Colors.white),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
        const SizedBox(width: 240),
        IconButton(
          icon: const Icon(
            Icons.add_shopping_cart_rounded,
            size: 30,
            color: Colors.black12,
          ),
          onPressed: () => Navigator.pushNamed(context, 'routeShopping'),
        ),
      ],
    );
  }
}

class _CardHome extends StatelessWidget {
  final Category category;

  const _CardHome(this.category, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<ProductsService>(context, listen: false);

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
                  color: Colors.deepOrange[400],
                ),
                child: IconButton(
                  iconSize: 30,
                  icon: const Icon(Icons.chevron_right_outlined),
                  color: Colors.white,
                  onPressed: () {
                    newsService.selectedCategory = category.name;
                    Navigator.pushNamed(context, 'routeProducts');
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
      width: 280,
      height: 110,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
