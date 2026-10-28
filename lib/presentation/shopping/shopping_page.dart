import 'package:flutter/material.dart';
import 'package:flutter_diprovet_cliente/core/models/shopping_detail.dart';
import 'package:flutter_diprovet_cliente/core/utils.dart';
import 'package:flutter_diprovet_cliente/logic/shopping_provider.dart';
import 'package:flutter_diprovet_cliente/presentation/products/product_details_page.dart';
import 'package:flutter_diprovet_cliente/presentation/shopping/cart_shopping_page.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ShoppingPage extends StatelessWidget {
  const ShoppingPage({super.key});

  static const String routeName = 'shopping';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            right: 0,
            left: 0,
            child: Image.asset(
              'assets/logo_one.png',
            ),
          ),
          ListView(
            children: [
              Consumer<ShoppingProvider>(
                builder: (context, shoppingProvider, child) {
                  final details = shoppingProvider.details;
                  if (details.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 120),
                      child: Center(
                        child: Text(
                          'Tu carrito está vacío',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ),
                    );
                  }

                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: ListView.separated(
                      itemCount: details.length,
                      itemBuilder: (context, index) => _Card(details[index]),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 20),
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
              onPressed: () => context.pushNamed(CartShoppingPage.routeName),
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: GestureDetector(
        onTap: () {
          context.pushNamed(
            ProductDetailPage.routeName,
            extra: ProductDetailPageArg(product: detail.product),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: detail.product.picture.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: FadeInImage(
                          placeholder:
                              const AssetImage('assets/jar-loading.gif'),
                          image: NetworkImage(detail.product.picture),
                          fit: BoxFit.cover,
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.image_not_supported,
                              color: Colors.grey[400],
                              size: 32,
                            );
                          },
                        ),
                      )
                    : Icon(Icons.image, color: Colors.grey[300], size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      detail.product.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      formatCurrency(detail.product.price),
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Color(0xFF98B136),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove, size: 18),
                      onPressed: () {
                        if (detail.amount > 0) {
                          context
                              .read<ShoppingProvider>()
                              .decrementAmount(detail);
                        }
                      },
                    ),
                    Text(
                      detail.amount.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add, size: 18),
                      onPressed: () {
                        context
                            .read<ShoppingProvider>()
                            .incrementAmount(detail);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
