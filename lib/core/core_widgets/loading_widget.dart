import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingAnimation extends StatelessWidget {
  const LoadingAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'assets/image/loading-juggle-red.json',
        width: 120,
        height: 120,
        fit: BoxFit.contain,
      ),
    );
  }
}
