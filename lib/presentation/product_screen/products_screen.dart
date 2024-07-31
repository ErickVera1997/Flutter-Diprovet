import 'package:flutter/material.dart';
import 'package:flutter_diprovet_cliente/models/product.dart';
import 'package:flutter_diprovet_cliente/presentation/home_page.dart';
import 'package:flutter_diprovet_cliente/providers/products_provider.dart';
import 'package:flutter_diprovet_cliente/services/details_service.dart';
import 'package:flutter_diprovet_cliente/widgets/background_card.dart';
import 'package:flutter_diprovet_cliente/widgets/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);
  static String routeName = 'products';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          const BackgroundYellow(),
          _MenuCenter(),
        ],
      ),
    );
  }
}

class _MenuCenter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final products = context.watch<ProductsNotifier>().filteredProducts;

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 40,
            ),
            onPressed: () => context.goNamed(HomePage.routeName),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (_, index) => _CardProducts(products[index]),
            ),
          ),
        ],
      ),
    );
  }
}

class _CardProducts extends StatelessWidget {
  const _CardProducts(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      width: 320,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          const SizedBox(width: 30),
          const BackgroundCardProduct(),
          Row(
            children: [
              const SizedBox(width: 10),
              Container(
                width: 130,
                height: 122,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                ),
                child: GestureDetector(
                  onTap: () {}
                  /*Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailScreen(product: product),
                    ),
                  ),*/
                  ,
                  child: ClipOval(
                    child: FadeInImage(
                      placeholder: const AssetImage('assets/jar-loading.gif'),
                      image: NetworkImage(product.picture!),
                      fit: BoxFit.cover,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/logo.jpeg',
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 5),
              SizedBox(
                width: 150,
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name ?? '',
                      style: const TextStyle(fontSize: 15, letterSpacing: 2),
                    ),
                    Text(
                      product.available ?? false
                          ? 'Product Stock'
                          : 'Producto Agotado',
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.yellow, size: 15),
                        const Icon(Icons.star, color: Colors.yellow, size: 15),
                        const Icon(Icons.star, color: Colors.yellow, size: 15),
                        const Icon(Icons.star, color: Colors.yellow, size: 15),
                        Icon(
                          Icons.star,
                          color: Colors.blueGrey.shade100,
                          size: 15,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(product.share.toString()),
                        const Text('ml'),
                        const SizedBox(width: 60),
                        const Text(r'$'),
                        Text(product.price.toString()),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 50),
              GestureDetector(
                onTap: () {
                  context.read<DetailService>().addProduct(product);
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.yellow,
                  ),
                  child: const Icon(
                    Icons.add,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
