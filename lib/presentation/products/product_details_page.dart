import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_diprovet_cliente/core/models/product.dart';
import 'package:flutter_diprovet_cliente/logic/products_provider.dart';
import 'package:flutter_diprovet_cliente/presentation/products/widget/card_detail_product.dart';
import 'package:flutter_diprovet_cliente/presentation/widgets/loading_overlay.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ProductDetailPageArg {
  const ProductDetailPageArg({required this.product});

  final Product product;
}

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({required this.arg, super.key});

  static String routeName = 'products-details';

  final ProductDetailPageArg arg;

  @override
  Widget build(BuildContext context) {
    return _ProductDetailWidget(product: arg.product);
  }
}

class _ProductDetailWidget extends StatelessWidget {
  const _ProductDetailWidget({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final isLoading = context.select<ProductsProvider, bool>(
      (provider) => provider.isLoading,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          ),
          onPressed: context.pop,
        ),
        centerTitle: true,
        title: Text(
          product.name,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            letterSpacing: 4,
          ),
        ),
      ),
      body: LoadingOverlay(
        isLoading: isLoading,
        child: ListView(
          children: [
            CarouselSlider(
              items: [
                CardDetailProduct(product: product),
                Lottie.asset('assets/logo.json'),
              ],
              options: CarouselOptions(
                height: height * 0.45,
                autoPlay: true,
                viewportFraction: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Descripción',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    product.description,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Modo de Uso',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    product.details,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Especie de destino',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    product.species,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
