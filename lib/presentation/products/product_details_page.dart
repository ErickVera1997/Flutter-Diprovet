import 'package:flutter/material.dart';
import 'package:flutter_diprovet_cliente/core/models/product.dart';
import 'package:flutter_diprovet_cliente/core/utils.dart';
import 'package:flutter_diprovet_cliente/logic/products_provider.dart';
import 'package:flutter_diprovet_cliente/logic/shopping_provider.dart';
import 'package:flutter_diprovet_cliente/presentation/widgets/loading_overlay.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProductDetailPageArg {
  const ProductDetailPageArg({required this.product});

  final Product product;
}

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({required this.arg, super.key});

  static const String routeName = 'products-details';

  final ProductDetailPageArg arg;

  @override
  Widget build(BuildContext context) {
    return _ProductDetailWidget(product: arg.product);
  }
}

class _ProductDetailWidget extends StatefulWidget {
  const _ProductDetailWidget({required this.product});

  final Product product;

  @override
  State<_ProductDetailWidget> createState() => _ProductDetailWidgetState();
}

class _ProductDetailWidgetState extends State<_ProductDetailWidget> {
  int quantity = 1;
  int selectedPresentation = 0;
  final List<String> presentations = ['3 ml', '18 ml']; // Simulado
  bool _quantityLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_quantityLoaded) return;

    _quantityLoaded = true;
    final detail = context.read<ShoppingProvider>().detailFor(widget.product);
    if (detail != null) {
      quantity = detail.amount;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select<ProductsProvider, bool>(
      (provider) => provider.isLoading,
    );
    final shoppingProvider = context.watch<ShoppingProvider>();
    final alreadyInCart = shoppingProvider.contains(widget.product);
    final product = widget.product;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 28),
          onPressed: context.pop,
        ),
      ),
      body: LoadingOverlay(
        isLoading: isLoading,
        child: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              children: [
                const SizedBox(height: 12),
                Center(
                  child: Container(
                    height: 250,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: product.picture.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: FadeInImage(
                              placeholder:
                                  const AssetImage('assets/jar-loading.gif'),
                              image: NetworkImage(product.picture),
                              fit: BoxFit.cover,
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.image_not_supported,
                                  color: Colors.grey[400],
                                  size: 80,
                                );
                              },
                            ),
                          )
                        : Icon(Icons.image, color: Colors.grey[300], size: 80),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  product.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                    letterSpacing: 1.2,
                  ),
                ),
                Text(
                  product.species,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Presentaciones disponibles:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 12,
                  children: List.generate(presentations.length, (i) {
                    final selected = selectedPresentation == i;

                    return ChoiceChip(
                      label: Text(
                        presentations[i],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      selected: selected,
                      selectedColor: Colors.tealAccent[400],
                      backgroundColor: Colors.white,
                      labelStyle: TextStyle(
                        color: selected ? Colors.black : Colors.black87,
                      ),
                      side: BorderSide(
                        color: selected
                            ? Colors.tealAccent[400]!
                            : Colors.grey.shade400,
                      ),
                      onSelected: (_) {
                        setState(() => selectedPresentation = i);
                      },
                    );
                  }),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formatCurrency(product.price),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black87),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: quantity > 1
                                ? () => setState(() => quantity--)
                                : null,
                          ),
                          Text(
                            '$quantity',
                            style: const TextStyle(fontSize: 18),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () => setState(() => quantity++),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  product.description,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 10),
                Text(
                  product.details,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 100),
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF98B136),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        elevation: 0,
                      ),
                      icon: const Icon(Icons.shopping_cart_outlined, size: 26),
                      label: Text(
                        alreadyInCart ? 'Actualizar' : 'Añadir al carrito',
                      ),
                      onPressed: () {
                        // TODO(diprovet): persistir la presentación elegida en
                        // el modelo cuando el backend la soporte.
                        shoppingProvider.setQuantity(product, quantity);
                        context.pop();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
