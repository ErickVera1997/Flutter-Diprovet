import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_diprovet_cliente/logic/shopping_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class CartShoppingPage extends StatefulWidget {
  const CartShoppingPage({super.key});

  static String routeName = 'cart-shopping';

  @override
  State<CartShoppingPage> createState() => _CartShoppingPageState();
}

class _CartShoppingPageState extends State<CartShoppingPage> {
  final _controller = ScreenshotController();

  Future<void> saveAndShareImage(Uint8List bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final imagePath = '${directory.path}/flutter.png';
    final image = File(imagePath);
    await image.writeAsBytes(bytes);

    const text = 'Shared from DIPROVET';

    await Share.shareXFiles([XFile(imagePath)], text: text);
  }

  @override
  Widget build(BuildContext context) {
    final shoppingProvider = context.watch<ShoppingProvider>();
    final width = MediaQuery.of(context).size.width;

    return Screenshot(
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
            'DIPROVET',
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
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Lottie.asset('assets/lottie/shopping.json'),
            ),
            ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(height: 30),
                    DataTable(
                      columnSpacing: width * 0.05,
                      columns: const [
                        DataColumn(label: Text('Productos')),
                        DataColumn(label: Text('Cantidad')),
                        DataColumn(label: Text('Precio')),
                        DataColumn(label: Text('Subtotales')),
                      ],
                      rows: shoppingProvider.details.map((detail) {
                        return DataRow(
                          cells: [
                            DataCell(
                              Center(child: Text(detail.product!.name)),
                            ),
                            DataCell(
                              Center(child: Text(detail.amount.toString())),
                            ),
                            DataCell(
                              Center(
                                child: Text(
                                  detail.product!.price.toStringAsFixed(2),
                                ),
                              ),
                            ),
                            DataCell(
                              Center(
                                child: Text(detail.total.toStringAsFixed(2)),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                      border: TableBorder.all(color: Colors.green),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Total \$${shoppingProvider.totalProducts().toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () async {
                        final image = await _controller.capture();
                        if (image == null) return;
                        await saveAndShareImage(image);
                      },
                      style: TextButton.styleFrom(
                        fixedSize: const Size(250, 50),
                        backgroundColor: Colors.green,
                        shape: const StadiumBorder(),
                      ),
                      child: const Text(
                        'Enviar nota de pedido',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
