import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'config/app_config.dart';
import 'screens/main_screen.dart';
import 'screens/splash_screen.dart';
import 'services/webview_service.dart';
import 'services/connectivity_service.dart';
import 'services/splash_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Services
  final webviewService = WebviewService();
  final connectivityService = ConnectivityService();
  final splashService = SplashService();

  // Start the splash timer
  splashService.startSplashTimer();

  runApp(
    ElSalumApp(
      webviewService: webviewService,
      connectivityService: connectivityService,
      splashService: splashService,
    ),
  );
}

class ElSalumApp extends StatelessWidget {
  final WebviewService webviewService;
  final ConnectivityService connectivityService;
  final SplashService splashService;

  const ElSalumApp({
    super.key,
    required this.webviewService,
    required this.connectivityService,
    required this.splashService,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: true,

      // Arabic / RTL Support
      locale: const Locale('ar'),
      supportedLocales: const [Locale('ar')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // Theme matching appConfig.json
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xFF1A100B),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1A100B),
          primary: const Color(0xFF1A100B),
          surface: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF1A100B),
          elevation: 0,
        ),
      ),

      // Use ValueListenableBuilder to handle Splash Screen
      home: ValueListenableBuilder<bool>(
        valueListenable: splashService.isSplashVisible,
        builder: (context, isVisible, child) {
          if (isVisible) {
            return const SplashScreen();
          }
          return MainScreen(
            webviewService: webviewService,
            connectivityService: connectivityService,
          );
        },
      ),
    );
  }
}
