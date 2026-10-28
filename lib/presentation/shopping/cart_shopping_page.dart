import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_diprovet_cliente/core/utils.dart';
import 'package:flutter_diprovet_cliente/logic/shopping_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class CartShoppingPage extends StatefulWidget {
  const CartShoppingPage({super.key});

  static const String routeName = 'cart-shopping';

  @override
  State<CartShoppingPage> createState() => _CartShoppingPageState();
}

class _CartShoppingPageState extends State<CartShoppingPage> {
  final _controller = ScreenshotController();
  bool _isSharing = false;

  Future<void> _shareOrder() async {
    if (_isSharing) return;

    setState(() => _isSharing = true);

    try {
      final image = await _controller.capture();
      if (image == null) {
        throw StateError('No se pudo generar la imagen de la nota de pedido.');
      }
      await _saveAndShareImage(image);
    } catch (err) {
      debugPrint('Error sharing order: $err');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No se pudo compartir la nota de pedido.'),
        ),
      );
    } finally {
      if (mounted) setState(() => _isSharing = false);
    }
  }

  Future<void> _saveAndShareImage(Uint8List bytes) async {
    final directory = await getTemporaryDirectory();
    final imagePath = '${directory.path}/nota_pedido_'
        '${DateTime.now().millisecondsSinceEpoch}.png';
    final image = File(imagePath);
    await image.writeAsBytes(bytes, flush: true);

    await Share.shareXFiles(
      [XFile(imagePath)],
      text: 'Nota de pedido - DIPROVET',
    );
  }

  @override
  Widget build(BuildContext context) {
    final shoppingProvider = context.watch<ShoppingProvider>();
    final details = shoppingProvider.details;
    final width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Screenshot(
          controller: _controller,
          child: Scaffold(
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
              title: const Text(
                'Agricola El Granito',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                ),
              ),
            ),
            body: Stack(
              children: [
                Positioned.fill(
                  child: Lottie.asset('assets/lottie/shopping.json'),
                ),
                ListView(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(height: 30),
                        if (details.isEmpty)
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 60,
                            ),
                            child: Text(
                              'Agrega productos al carrito para generar '
                              'tu nota de pedido.',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                          )
                        else ...[
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: DataTable(
                              columnSpacing: width * 0.05,
                              columns: const [
                                DataColumn(label: Text('Productos')),
                                DataColumn(label: Text('Cantidad')),
                                DataColumn(label: Text('Precio')),
                                DataColumn(label: Text('Subtotales')),
                              ],
                              rows: details.map((detail) {
                                return DataRow(
                                  cells: [
                                    DataCell(
                                      Center(
                                        child: Text(detail.product.name),
                                      ),
                                    ),
                                    DataCell(
                                      Center(
                                        child: Text(detail.amount.toString()),
                                      ),
                                    ),
                                    DataCell(
                                      Center(
                                        child: Text(
                                          formatCurrency(detail.product.price),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Center(
                                        child: Text(
                                          formatCurrency(detail.total),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                              border: TableBorder.all(color: Colors.green),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Total ${formatCurrency(shoppingProvider.total)}',
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: _isSharing ? null : _shareOrder,
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(250, 50),
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.black,
                              shape: const StadiumBorder(),
                            ),
                            child: const Text(
                              'Enviar nota de pedido',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                        const SizedBox(height: 20),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (_isSharing)
          const Positioned.fill(
            child: AbsorbPointer(
              child: ColoredBox(
                color: Colors.black26,
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
      ],
    );
  }
}
