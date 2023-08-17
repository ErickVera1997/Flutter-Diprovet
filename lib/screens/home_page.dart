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

class _CardSuperior extends StatelessWidget {
  const _CardSuperior({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newService = Provider.of<ProductsService>(context).categories;

    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 20),
          _Icons(),
          const SizedBox(height: 30),
          SizedBox(
            width: 390,
            height: 650,
            child: ListView.separated(
              itemCount: newService.length,
              itemBuilder: (context, index) => _CardHome(newService[index]),
              separatorBuilder: (_, __) => const SizedBox(height: 10),
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
        const Icon(Icons.apps, size: 40, color: Colors.white),
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

    return SizedBox(
      height: 110,
      width: 320,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          const _BackGroundWhite(),
          Row(
            children: [
              const SizedBox(width: 25),
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(70),
                ),
                child: ClipOval(
                  child: Image.asset(
                    category.path,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              SizedBox(
                width: 160,
                height: 60,
                //color: Colors.blue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.name,
                      style: const TextStyle(
                        fontSize: 20,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
              const SizedBox(width: 35),
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
        ],
      ),
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
