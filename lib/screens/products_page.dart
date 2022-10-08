import 'package:flutter/material.dart';
import 'package:flutter_diprovet_cliente/models/product.dart';
import 'package:flutter_diprovet_cliente/services/detalis_service.dart';
import 'package:flutter_diprovet_cliente/services/products_service.dart';
import 'package:flutter_diprovet_cliente/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _fondo = fondo();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Row(
            children: [
              _fondo,
              const SizedBox(width: 1),
              _fondo,
            ],
          ),
          MenuCenter(),
        ],
      ),
    );
  }
}

class MenuCenter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductsService>(context).filteredProducts;

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Superior(
            'routeHome',
            'routeShoping',
            'Productos',
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: 410,
            height: 500,
            child: ListView.separated(
              itemCount: products.length,
              itemBuilder: (context, index) => Tarjeta(products[index]),
              separatorBuilder: (_, __) => const SizedBox(height: 10),
            ),
          ),
        ],
      ),
    );
  }
}

class Tarjeta extends StatelessWidget {
  const Tarjeta(this.product);

  final Product product;

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
          Row(
            children: [
              const SizedBox(width: 10),
              Container(
                width: 130,
                height: 122,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                ),
                //color: Colors.grey,
                child: GestureDetector(
                  onTap: () => _secondDetallePage(context),
                  child: ClipOval(
                    child: FadeInImage(
                      placeholder: const AssetImage('assets/jar-loading.gif'),
                      image: NetworkImage(product.picture),
                      fit: BoxFit.cover,
                    ),
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
                      product.name,
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
                        Text(product.share.toString()),
                        const Text('ml'),
                        const SizedBox(width: 60),
                        const Text('\$'),
                        Text(product.price.toString()),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 50),
              GestureDetector(
                onTap: () {
                  final details =
                      Provider.of<DetailService>(context, listen: false);
                  details.addProduct(product);
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.deepOrange[400],
                  ),
                  child: const Icon(
                    Icons.add,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _secondDetallePage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.amber,
            title: Text(
              product.name,
              style: const TextStyle(
                fontSize: 30,
                letterSpacing: 4,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(25.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox(
                      width: double.infinity,
                      height: 400,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          FadeInImage(
                            placeholder:
                                const AssetImage('assets/jar-loading.gif'),
                            image: NetworkImage(product.picture),
                            fit: BoxFit.cover,
                          ),
                          Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                width: 140,
                                height: 80,
                                decoration: const BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(25),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      '\$',
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      product.price.toString(),
                                      style: const TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: 140,
                                height: 80,
                                decoration: const BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(25),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Categoria',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      product.category,
                                      style: const TextStyle(fontSize: 17),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '- Descripción',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.amber,
                        ),
                      ),
                      Text(
                        product.description,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        '- Modo de Uso',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.amber,
                        ),
                      ),
                      Text(
                        product.details,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        '- Especie de destino',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.amber,
                        ),
                      ),
                      Text(
                        product.especie,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

_fondoTarjeta() => Container(
      width: 320,
      height: 230,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(width: 3, color: Colors.brown.shade100),
        color: Colors.grey[50],
      ),
    );
