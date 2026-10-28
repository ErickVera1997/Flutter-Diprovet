import 'package:flutter/material.dart';
import 'package:flutter_diprovet_cliente/core/models/product.dart';
import 'package:flutter_diprovet_cliente/core/utils.dart';
import 'package:flutter_diprovet_cliente/logic/authentication_provider.dart';
import 'package:flutter_diprovet_cliente/logic/products_provider.dart';
import 'package:flutter_diprovet_cliente/logic/shopping_provider.dart';
import 'package:flutter_diprovet_cliente/presentation/products/product_details_page.dart';
import 'package:flutter_diprovet_cliente/presentation/shopping/shopping_page.dart';
import 'package:flutter_diprovet_cliente/presentation/widgets/alerts/confirm_operation.dart';
import 'package:flutter_diprovet_cliente/presentation/widgets/alerts/error_alert.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const String routeName = 'home';

  @override
  Widget build(BuildContext context) => const _HomePageWidget();
}

class _HomePageWidget extends StatefulWidget {
  const _HomePageWidget();

  @override
  State<_HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<_HomePageWidget> {
  int _selectedIndex = 0;
  Future<void> _onCloseSession() async {
    final validateClose = await showDialog<bool>(
          context: context,
          builder: (context) {
            return const ConfirmOperationAlert(
              text: '¿Seguro que deseas cerrar sesión?',
            );
          },
        ) ??
        false;

    if (!validateClose || !mounted) return;
    final response = await context.read<AuthenticationProvider>().logOutUser();

    if (!mounted) return;
    response.fold(
      (errorMessage) {
        showDialog<void>(
          context: context,
          builder: (context) => ErrorAlert(text: errorMessage),
        );
      },
      (unit) {
        context.read<ShoppingProvider>().clear();
        context.go('/');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final productsProvider = context.watch<ProductsProvider>();
    final categories = productsProvider.categories;
    final selectedCategory = productsProvider.selectedCategory;
    final products = productsProvider.filteredProducts;
    final isLoading = productsProvider.isLoading;
    final errorMessage = productsProvider.errorMessage;

    final cartCount = context.watch<ShoppingProvider>().productsCount;

    Widget body;
    if (_selectedIndex == 0) {
      body = ListView(
        children: [
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Categorías',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 20),
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = category.name == selectedCategory;
                return GestureDetector(
                  onTap: () {
                    context.read<ProductsProvider>().selectedCategory =
                        category.name;
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.green[100] : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? Colors.green[100]!
                            : Colors.grey.shade300,
                        width: 2,
                      ),
                      boxShadow: [
                        if (isSelected)
                          BoxShadow(
                            color: Colors.green[50]!,
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: Lottie.asset(category.path, fit: BoxFit.cover),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          category.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color:
                                isSelected ? Colors.green[800] : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          if (isLoading && products.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Center(
                child: CircularProgressIndicator(color: Color(0xFF98B136)),
              ),
            )
          else if (errorMessage != null && products.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                children: [
                  Text(
                    errorMessage,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 12),
                  TextButton.icon(
                    onPressed: productsProvider.loadProducts,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reintentar'),
                  ),
                ],
              ),
            )
          else if (products.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                selectedCategory,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: products.length,
              separatorBuilder: (_, __) => const SizedBox(height: 20),
              itemBuilder: (context, index) {
                final product = products[index];
                return _CardProducts(product);
              },
            ),
          ] else ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Center(
                child: Text(
                  'No hay productos en esta categoría',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
            ),
          ],
        ],
      );
    } else {
      body = const ShoppingPage();
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Agricola El Granito',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
            color: Color(0xFF98B136),
          ),
        ),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.logout, color: Colors.black),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 0,
                onTap: _onCloseSession,
                child: const Text('Cerrar sesión'),
              ),
            ],
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF98B136),
        unselectedItemColor: Colors.black,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                const Icon(Icons.shopping_cart_outlined),
                if (cartCount > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: const Color(0xFF98B136),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 18,
                        minHeight: 18,
                      ),
                      child: Text(
                        '$cartCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            label: 'Carrito',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        elevation: 10,
      ),
    );
  }
}

class _CardProducts extends StatelessWidget {
  const _CardProducts(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
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
            child: product.picture.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: FadeInImage(
                      placeholder: const AssetImage('assets/jar-loading.gif'),
                      image: NetworkImage(product.picture),
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
                  product.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                // const SizedBox(height: 4),
                // Text(
                //   product.species,
                //   style: TextStyle(
                //     color: Colors.grey[600],
                //     fontSize: 13,
                //   ),
                // ),
                const SizedBox(height: 6),
                Text(
                  formatCurrency(product.price),
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF98B136),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
              textStyle:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            onPressed: () {
              context.pushNamed(
                ProductDetailPage.routeName,
                extra: ProductDetailPageArg(product: product),
              );
            },
            child: const Text('Añadir'),
          ),
        ],
      ),
    );
  }
}
