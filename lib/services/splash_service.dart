import 'dart:async';
import 'package:flutter/foundation.dart';
import '../config/app_config.dart';

class SplashService {
  final ValueNotifier<bool> isSplashVisible = ValueNotifier<bool>(true);

  void startSplashTimer() {
    Timer(const Duration(seconds: AppConfig.splashDurationSeconds), () {
      isSplashVisible.value = false;
    });
  }

  void dispose() {
    isSplashVisible.dispose();
  }
}
