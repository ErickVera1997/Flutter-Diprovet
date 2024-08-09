import 'package:flutter/material.dart';
import 'package:flutter_diprovet_cliente/core/models/shopping_detail.dart';
import 'package:flutter_diprovet_cliente/logic/shopping_provider.dart';
import 'package:flutter_diprovet_cliente/presentation/products/products_page.dart';
import 'package:flutter_diprovet_cliente/widgets/background_card.dart';
import 'package:flutter_diprovet_cliente/widgets/cart_shopping.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ShoppingPage extends StatelessWidget {
  const ShoppingPage({Key? key}) : super(key: key);

  static String routeName = 'shopping';

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
      body: Stack(
        children: [
          Positioned(
            right: 0,
            left: 0,
            child: Lottie.asset('assets/lottie/horse_home.json'),
          ),
          ListView(
            children: [
              Consumer<ShoppingProvider>(
                builder: (context, shoppingProvider, child) {
                  return SizedBox(
                    height: 600,
                    child: ListView.builder(
                      itemCount: shoppingProvider.details.length,
                      itemBuilder: (context, index) =>
                          _Card(shoppingProvider.details[index]),
                    ),
                  );
                },
              ),
            ],
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
    return Padding(
      padding: const EdgeInsets.only(left: 40),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              'Nota de Pedido',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                child: Lottie.asset(
                  'assets/lottie/shopping.json',
                  height: 50,
                ),
              ),
              onPressed: () => secondDetailPage(context),
            ),
          ],
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card(this.detail);

  final Detail detail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: SizedBox(
        height: 140,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            const BackgroundCardProduct(),
            // Positioned(
            //   bottom: -5,
            //   right: 90,
            //   child: GestureDetector(
            //     child: const Icon(
            //       Icons.delete,
            //       size: 35,
            //       color: Colors.green,
            //     ),
            //     onTap: () =>
            //         Provider.of<ShoppingProvider>(context, listen: false)
            //             .removeProduct(detail.product!),
            //   ),
            // ),
            Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: ClipOval(
                    child: FadeInImage(
                      placeholder: const AssetImage('assets/jar-loading.gif'),
                      image: NetworkImage(detail.product!.picture),
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
                const SizedBox(width: 10),
                SizedBox(
                  width: 140,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        detail.product!.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '\$${detail.product!.price}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Container(
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.green,
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
