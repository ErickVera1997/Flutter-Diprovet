import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_diprovet_cliente/models/shopping_detail.dart';
import 'package:flutter_diprovet_cliente/services/details_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

void secondDetailPage(BuildContext context) {
  final controller = ScreenshotController();
  final product = Provider.of<DetailService>(context, listen: false);

  Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (BuildContext context) => Screenshot(
        controller: controller,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.amber,
            title: const Text(
              'DIPROVET',
              style: TextStyle(fontSize: 35),
            ),
          ),
          body: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Producto',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Cantidad',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Precio',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Subtotales',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              const Divider(
                height: 5,
                color: Colors.amber,
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 410,
                height: 300,
                child: ListView.separated(
                  itemCount: product.details.length,
                  itemBuilder: (context, index) => List(product.details[index]),
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Total de Compra =  ',
                    style: TextStyle(fontSize: 25),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Row(
                    children: [
                      const Text(
                        '\$',
                        style: TextStyle(fontSize: 30),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        product.totalProducts().toStringAsFixed(2),
                        style: const TextStyle(fontSize: 25),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(70),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/logo.jpeg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final image = await controller.capture();
                      if (image == null) return;
                      await saveImage(image);
                    },
                    child: const Text(
                      'Enviar nota de pedido',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        letterSpacing: 2,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      fixedSize: const Size(270, 50),
                      backgroundColor: Colors.amber,
                      shape: const StadiumBorder(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Future saveImage(Uint8List bytes) async {
  final directory = await getApplicationDocumentsDirectory();
  final image = File('${directory.path}/flutter.png');
  image.writeAsBytesSync(bytes);
  const text = 'Shared from DIPROVET';
  await Share.shareFiles([image.path], text: text);
}

class List extends StatelessWidget {
  final Detail details;

  const List(this.details, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          details.product!.name!,
          style: const TextStyle(color: Colors.amber),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(details.amount.toString()),
        const SizedBox(
          width: 10,
        ),
        Text(details.product!.price!.toStringAsFixed(2)),
        const SizedBox(
          width: 20,
        ),
        Text(
          details.total.toStringAsFixed(2),
        ),
      ],
    );
  }
}
