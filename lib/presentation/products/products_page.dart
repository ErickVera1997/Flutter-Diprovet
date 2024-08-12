import 'package:flutter/material.dart';
import 'package:flutter_diprovet_cliente/core/models/product.dart';
import 'package:flutter_diprovet_cliente/logic/products_provider.dart';
import 'package:flutter_diprovet_cliente/logic/shopping_provider.dart';
import 'package:flutter_diprovet_cliente/presentation/screens.dart';
import 'package:flutter_diprovet_cliente/widgets/background_card.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  static String routeName = 'products';

  @override
  Widget build(BuildContext context) {
    final products = context.watch<ProductsProvider>().filteredProducts;

    final category =
        products.isNotEmpty ? products.first.category : 'Categoría';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () => context.goNamed(HomePage.routeName),
        ),
        centerTitle: true,
        title: const Text(
          'PRODUCTOS',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            letterSpacing: 4,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {
              context.pushNamed(
                ShoppingPage.routeName,
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.yellow[50],
      body: Stack(
        children: [
          Positioned(
            //top: 0,
            bottom: 0,
            right: 0,
            left: 0,
            child: Lottie.asset('assets/lottie/dog_home.json'),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Text(
                    category,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
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
      height: 130,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          const BackgroundCardProduct(),
          Row(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                ),
                child: GestureDetector(
                  onTap: () {
                    context.pushNamed(
                      DetailScreen.routeName,
                      extra: DetailArg(product: product),
                    );
                  },
                  child: ClipOval(
                    child: FadeInImage(
                      placeholder: const AssetImage('assets/jar-loading.gif'),
                      image: NetworkImage(product.picture),
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
                      product.name,
                      style: const TextStyle(fontSize: 15, letterSpacing: 2),
                    ),
                    Text(
                      product.available ? 'Product Stock' : 'Producto Agotado',
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
              const SizedBox(width: 40),
              IconButton(
                icon: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.green,
                  ),
                  child: const Icon(
                    Icons.add,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  context.read<ShoppingProvider>().addProduct(product);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
