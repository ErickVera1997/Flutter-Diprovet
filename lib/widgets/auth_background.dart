import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;

  const AuthBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          _PurpleBox(),
          _HeaderIcon(),
          child,
        ],
      ),
    );
  }
}

class _HeaderIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 70),
        child: const Text(
          'DIPROVET',
          style: TextStyle(fontSize: 50, color: Colors.black54),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _PurpleBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      decoration: _purpleBackground(),
      child: Stack(
        children: [
          Positioned(child: _Bubble(), top: 90, left: 30),
          Positioned(child: _Bubble(), top: -40, left: -30),
          Positioned(child: _Bubble(), top: -50, right: -20),
          Positioned(child: _Bubble(), bottom: -50, left: 10),
          Positioned(child: _Bubble(), bottom: 90, right: 20),
        ],
      ),
    );
  }

  BoxDecoration _purpleBackground() => const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(240, 200, 10, 1),
            Color.fromRGBO(250, 150, 150, 1),
          ],
        ),
      );
}

class _Bubble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: const Color.fromRGBO(255, 255, 255, 0.05),
      ),
    );
  }
}
