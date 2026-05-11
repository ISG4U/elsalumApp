import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

class ConnectivityService {
  final ValueNotifier<bool> isOnline = ValueNotifier<bool>(true);

  ConnectivityService() {
    _init();
  }

  void _init() async {
    final connectivity = Connectivity();

    // Initial check
    final List<ConnectivityResult> results = await connectivity
        .checkConnectivity();
    _updateStatus(results);

    // Listen for changes
    connectivity.onConnectivityChanged.listen(_updateStatus);
  }

  void _updateStatus(List<ConnectivityResult> results) {
    // If any result is something other than 'none', we are online
    isOnline.value = results.any((result) => result != ConnectivityResult.none);
  }

  void dispose() {
    isOnline.dispose();
  }
}
