import 'package:flutter/material.dart';
import 'package:flutter_diprovet_cliente/core/models/shopping_detail.dart';
import 'package:flutter_diprovet_cliente/logic/shopping_provider.dart';
import 'package:flutter_diprovet_cliente/presentation/products/products_page.dart';
import 'package:flutter_diprovet_cliente/widgets/background_card.dart';
import 'package:flutter_diprovet_cliente/widgets/cart_shopping.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ShoppingPageArg {
  const ShoppingPageArg({
    required this.details,
  });

  final List<Detail> details;
}

class ShoppingPage extends StatelessWidget {
  const ShoppingPage({required this.arg, Key? key}) : super(key: key);

  static String routeName = 'shopping';

  final ShoppingPageArg arg;

  @override
  Widget build(BuildContext context) {
    return _ShoppingPageWidget(details: arg.details);
  }
}

class _ShoppingPageWidget extends StatelessWidget {
  const _ShoppingPageWidget({required this.details, Key? key})
      : super(key: key);

  final List<Detail> details;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () => context.goNamed(ProductsPage.routeName),
        ),
        centerTitle: true,
        title: const Text(
          'Shopping',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            letterSpacing: 4,
          ),
        ),
      ),
      backgroundColor: Colors.yellow[50],
      body: ListView(
        children: [
          SizedBox(
            height: 600,
            child: ListView.builder(
              itemCount: details.length,
              itemBuilder: (context, index) => _Card(details[index]),
            ),
          ),
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
            onTap: () => secondDetailPage(context),
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

class _Card extends StatelessWidget {
  const _Card(this.detail);

  final Detail detail;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      width: 320,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          const BackgroundCardProduct(),
          Positioned(
            bottom: -5,
            right: 90,
            child: GestureDetector(
              child: const Icon(
                Icons.delete,
                size: 35,
                color: Colors.yellow,
              ),
              onTap: () => Provider.of<ShoppingProvider>(context, listen: false)
                  .removeProduct(detail.product!),
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
                    detail.product!.picture,
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
                      detail.product!.name,
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
                        const Text(r'$'),
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
                height: 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.yellow,
                ),
                child: _Counter(
                  amount: detail.amount!,
                  onIncrement: () {
                    Provider.of<ShoppingProvider>(context, listen: false)
                        .incrementAmount(detail);
                  },
                  onDecrement: () {
                    if (detail.amount! > 0) {
                      Provider.of<ShoppingProvider>(context, listen: false)
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
    required this.amount,
    required this.onIncrement,
    required this.onDecrement,
    Key? key,
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
          onTap: onDecrement,
          child: const Icon(Icons.remove, size: 30, color: Colors.white),
        ),
        const SizedBox(height: 5),
        Text(
          amount.toString(),
          style: const TextStyle(color: Colors.black, fontSize: 15),
        ),
        const SizedBox(height: 5),
        GestureDetector(
          onTap: onIncrement,
          child: const Icon(Icons.add, size: 30, color: Colors.white),
        ),
      ],
    );
  }
}
