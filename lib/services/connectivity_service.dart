import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

class ConnectivityService {
  final ValueNotifier<bool> isOnline = ValueNotifier<bool>(true);
  StreamSubscription<List<ConnectivityResult>>? _subscription;
  Timer? _pollTimer;

  bool _disposed = false;
  int _checkId = 0;

  ConnectivityService() {
    _init();
  }

  void _init() async {
    try {
      final connectivity = Connectivity();
      final List<ConnectivityResult> results = await connectivity
          .checkConnectivity();
      await _checkConnectivity(results);

      _subscription = connectivity.onConnectivityChanged.listen(
        _checkConnectivity,
      );
    } catch (e) {
      debugPrint('ConnectivityService init error: $e');
      final hasInternet = await _hasActualInternet();
      if (!_disposed) isOnline.value = hasInternet;
    }

    _startPolling();
  }

  void _startPolling() {
    _pollTimer = Timer.periodic(const Duration(seconds: 10), (_) async {
      if (_disposed) return;
      final hasInternet = await _hasActualInternet();
      if (!_disposed) isOnline.value = hasInternet;
    });
  }

  Future<void> _checkConnectivity(List<ConnectivityResult> results) async {
    final int myId = ++_checkId;
    final hasInternet = await _hasActualInternet();
    if (_disposed || myId != _checkId) return;
    isOnline.value = hasInternet;
  }

  Future<bool> _hasActualInternet() async {
    try {
      final result = await InternetAddress.lookup(
        'google.com',
      ).timeout(const Duration(seconds: 5));
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  void dispose() {
    _disposed = true;
    _pollTimer?.cancel();
    _subscription?.cancel();
    isOnline.dispose();
  }
}