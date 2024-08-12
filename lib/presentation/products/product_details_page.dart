import 'package:carousel_slider/carousel_controller.dart' as slider;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_diprovet_cliente/core/models/product.dart';
import 'package:flutter_diprovet_cliente/logic/products_provider.dart';
import 'package:flutter_diprovet_cliente/presentation/widgets/loading_overlay.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DetailArg {
  const DetailArg({required this.product});

  final Product product;
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({required this.arg, super.key});

  static String routeName = 'products-details';

  final DetailArg arg;

  @override
  Widget build(BuildContext context) {
    return DetailScreenWidget(product: arg.product);
  }
}

class DetailScreenWidget extends StatelessWidget {
  const DetailScreenWidget({required this.product, super.key});

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
                if (product.picture.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: SizedBox(
                        width: double.infinity,
                        height: 400,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            FadeInImage(
                              placeholder: const AssetImage(
                                'assets/jar-loading.gif',
                              ),
                              image: NetworkImage(product.picture),
                              fit: BoxFit.cover,
                            ),
                            Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Container(
                                  width: 140,
                                  height: 80,
                                  decoration: const BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(25),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '\$${product.price}',
                                      textAlign: TextAlign.justify,
                                      style: const TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Stack(
                              alignment: Alignment.bottomLeft,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  width: 140,
                                  height: 80,
                                  decoration: const BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(25),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Categoria',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      Text(
                                        product.category,
                                        style: const TextStyle(
                                          fontSize: 17,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                else
                  Image.asset(
                    '',
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
              ],
              options: CarouselOptions(
                height: height * 0.45,
                autoPlay: true,
                viewportFraction: 1,
              ),
              carouselController:
                  slider.CarouselController() as CarouselControllerImpl,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 25, left: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 20),
                  const SizedBox(height: 25),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '- Descripción',
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
                        '- Modo de Uso',
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
                        '- Especie de destino',
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
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
