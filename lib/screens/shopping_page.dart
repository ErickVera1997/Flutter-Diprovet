import 'package:flutter/material.dart';
import 'package:flutter_diprovet_cliente/models/shopingdetalle.dart';
import 'package:flutter_diprovet_cliente/services/detalis_service.dart';
import 'package:flutter_diprovet_cliente/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ShopingPage extends StatelessWidget {
  const ShopingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          fondoShoping(),
          const MenuShoping(),
        ],
      ),
      floatingActionButton: buttomShoping(context),
    );
  }
}

class MenuShoping extends StatelessWidget {
  const MenuShoping({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final details = Provider.of<DetailService>(context).details;

    return SafeArea(
      child: Column(
        children: [
          const Superior(
            'routeProducts',
            'routeShoping',
            'Shoping',
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: 410,
            height: 500,
            child: ListView.separated(
              itemCount: details.length,
              itemBuilder: (context, index) => Tarjeta(details[index]),
              separatorBuilder: (_, __) => const SizedBox(height: 10),
            ),
          ),
        ],
      ),
    );
  }
}

class Tarjeta extends StatelessWidget {
  const Tarjeta(this.detail);

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
                  .removeProduct(detail.product),
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
                    detail.product.picture,
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
                      detail.product.name,
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
                        Text(detail.product.share.toString()),
                        const Text('ml'),
                        const SizedBox(width: 50),
                        const Text('\$'),
                        Text(detail.product.price.toString()),
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
                child: Contador(
                  amount: detail.amount,
                  onIncrement: () =>
                      Provider.of<DetailService>(context, listen: false)
                          .incrementAmount(detail),
                  onDecrement: () {
                    if (detail.amount > 0) {
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

class Contador extends StatelessWidget {
  const Contador({
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
