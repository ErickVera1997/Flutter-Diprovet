import 'package:flutter/material.dart';
import 'package:flutter_diprovet_cliente/core/models/product.dart';

class CardDetailProduct extends StatelessWidget {
  const CardDetailProduct({required this.product, super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
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
                    height: 60,
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
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
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
                    height: 60,
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
                        ),
                        Text(
                          product.category,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
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
    );
  }
}
