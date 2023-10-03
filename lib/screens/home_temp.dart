import 'package:flutter/material.dart';

class TempPage extends StatefulWidget {
  const TempPage({Key? key}) : super(key: key);

  @override
  State<TempPage> createState() => _TempPageState();
}

class _TempPageState extends State<TempPage> {
  bool _isButtonEnabled = true;

  void _startNavigation() async {
    setState(() {
      _isButtonEnabled = false;
    });

    await Future.delayed(const Duration(seconds: 2));

    Navigator.pushNamed(context, 'routeHome');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Card(
              margin: const EdgeInsets.all(20),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(70)),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(70)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.grey[200]!, // Color más claro
                      Colors.grey[50]!, // Color intermedio
                      Colors.grey[50]!, // Color más oscuro
                    ],
                    stops: const [0.0, 0.5, 1.0],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(70),
                        bottomRight: Radius.circular(70),
                      ),
                      child: Image(image: AssetImage('assets/logo.jpeg')),
                    ),
                    const SizedBox(height: 140),
                    ElevatedButton(
                      onPressed: _isButtonEnabled ? _startNavigation : null,
                      child: const Text(
                        'Iniciar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          letterSpacing: 2,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(240, 70),
                        backgroundColor: Colors.amber.shade300,
                        shape: const StadiumBorder(),
                      ),
                    ),
                    const SizedBox(height: 100),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/logo_calidad.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const Text(
                          'Like Barcelona',
                          style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 1,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
