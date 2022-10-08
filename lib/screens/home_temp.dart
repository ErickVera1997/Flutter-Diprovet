import 'package:flutter/material.dart';

class TempPage extends StatelessWidget {
  const TempPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange[400],
      body: SafeArea(
        child: Card(
          margin: const EdgeInsets.all(30),
          color: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  bottomRight: Radius.circular(70),
                ),
                child: Image(image: AssetImage('assets/logo.jpeg')),
              ),
              const SizedBox(height: 90),
              const SizedBox(width: 150),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'routeHome');
                },
                child: const Text(
                  'Iniciar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    letterSpacing: 2,
                  ),
                ),
                style: TextButton.styleFrom(
                  fixedSize: const Size(170, 50),
                  backgroundColor: Colors.deepOrange[400],
                  shape: const StadiumBorder(),
                ),
              ),
              const SizedBox(height: 140),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //const SizedBox(width: 50),

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
    );
  }
}
