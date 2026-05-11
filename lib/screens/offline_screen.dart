import 'package:flutter/material.dart';

class OfflineScreen extends StatelessWidget {
  final VoidCallback onRetry;

  const OfflineScreen({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.wifi_off, size: 100, color: Colors.grey),
          const SizedBox(height: 20),
          const Text(
            'لا يوجد اتصال بالإنترنت',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto', // Default, but RTL aware
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'يرجى التحقق من اتصالك والمحاولة مرة أخرى',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('إعادة المحاولة'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }
}
