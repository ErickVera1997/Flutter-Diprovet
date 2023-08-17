import 'package:flutter/material.dart';
import 'package:flutter_diprovet_cliente/models/shopingdetalle.dart';
import 'package:flutter_diprovet_cliente/services/detalis_service.dart';
import 'package:flutter_diprovet_cliente/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';

class ShoppingCardPage extends StatelessWidget {
  const ShoppingCardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: const [
          ThreeBackground(),
          _MenuShopping(),
        ],
      ),
      floatingActionButton: const _Button(),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 385,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Nota de Pedido DIPROVET',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 130),
          GestureDetector(
            onTap: () => secondDetallePage(context),
            child: Icon(
              Icons.expand_less,
              size: 30,
              color: Colors.deepOrange[400],
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuShopping extends StatelessWidget {
  const _MenuShopping({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final details = Provider.of<DetailService>(context).details;

    return SafeArea(
      child: Column(
        children: [
          const Superior(
            'routeProducts',
            'routeShopping',
            'Shopping',
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: 410,
            height: 500,
            child: ListView.separated(
              itemCount: details.length,
              itemBuilder: (context, index) => Card(details[index]),
              separatorBuilder: (_, __) => const SizedBox(height: 10),
            ),
          ),
        ],
      ),
    );
  }
}

class Card extends StatelessWidget {
  const Card(this.detail, {Key? key}) : super(key: key);

  final Detail detail;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      width: 320,
      //color: Colors.white,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          const SizedBox(width: 30),
          _fondoTarjeta(),
          Positioned(
            bottom: -5,
            right: 90,
            child: GestureDetector(
              child: const Icon(
                Icons.delete,
                size: 35,
                color: Colors.black,
              ),
              onTap: () => Provider.of<DetailService>(context, listen: false)
                  .removeProduct(detail.product ?? Product()),
            ),
          ),
          Row(
            children: [
              const SizedBox(width: 10),
              SizedBox(
                width: 120,
                height: 110,
                child: ClipOval(
                  child: Image.network(
                    detail.product!.picture!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              SizedBox(
                width: 150,
                height: 100,
                //color: Colors.red,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      detail.product!.name!,
                      style: const TextStyle(fontSize: 18, letterSpacing: 2),
                    ),
                    const Text('Product Stock', style: TextStyle(fontSize: 12)),
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
                        Text(detail.product!.share.toString()),
                        const Text('ml'),
                        const SizedBox(width: 50),
                        const Text('\$'),
                        Text(detail.product!.price.toString()),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 60),
              Container(
                width: 40,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.grey[100],
                ),
                child: _Counter(
                  amount: detail.amount!,
                  onIncrement: () =>
                      Provider.of<DetailService>(context, listen: false)
                          .incrementAmount(detail),
                  onDecrement: () {
                    if (detail.amount! > 0) {
                      Provider.of<DetailService>(context, listen: false)
                          .decrementAmount(detail);
                    }
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

class _Counter extends StatelessWidget {
  const _Counter({
    Key? key,
    required this.amount,
    required this.onIncrement,
    required this.onDecrement,
  }) : super(key: key);

  final int amount;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          child: const Icon(Icons.remove, size: 30, color: Colors.black),
          onTap: onDecrement,
        ),
        const SizedBox(height: 5),
        Text(
          amount.toString(),
          style: const TextStyle(color: Colors.red, fontSize: 15),
        ),
        const SizedBox(height: 5),
        GestureDetector(
          child: const Icon(Icons.add, size: 30, color: Colors.black),
          onTap: onIncrement,
        ),
      ],
    );
  }
}

_fondoTarjeta() {
  return Container(
    width: 320,
    height: 130,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25),
      border: Border.all(width: 3, color: Colors.brown.shade100),
      color: Colors.grey[50],
    ),
  );
}
