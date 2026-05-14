import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'config/app_config.dart';

import 'screens/mode_selection_screen.dart';
import 'services/webview_service.dart';
import 'services/connectivity_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final webviewService = WebviewService();
  final connectivityService = ConnectivityService();

  runApp(
    ElSalumApp(
      webviewService: webviewService,
      connectivityService: connectivityService,
    ),
  );
}

class ElSalumApp extends StatelessWidget {
  final WebviewService webviewService;
  final ConnectivityService connectivityService;

  const ElSalumApp({
    super.key,
    required this.webviewService,
    required this.connectivityService,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: false,

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

      home: ModeSelectionScreen(
        webviewService: webviewService,
        connectivityService: connectivityService,
      ),
    );
  }
}
