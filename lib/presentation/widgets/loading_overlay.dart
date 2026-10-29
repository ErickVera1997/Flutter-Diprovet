import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({
    required this.child,
    super.key,
    this.isLoading = false,
  });

  final Widget child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading) ...[
          const Positioned.fill(
            child: ModalBarrier(
              dismissible: false,
              color: Colors.black45,
            ),
          ),
          const Center(
            child: CircularProgressIndicator(color: Colors.green),
          ),
        ],
      ],
    );
  }
}
