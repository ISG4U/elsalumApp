import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Using the primary color found in main.dart: 0xFF1A100B
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/images/logo enhanced.jpg',
          fit: BoxFit.contain,
          // If the image has a different background color,
          // we might want to use a specific width/height or BoxFit.
        ),
      ),
    );
  }
}
