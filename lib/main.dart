import 'package:elsalum_app/core/utils/chach_service.dart';
import 'package:elsalum_app/core/utils/constant.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'config/app_config.dart';

import 'screens/mode_selection_screen.dart';
import 'screens/main_screen.dart';
import 'screens/notes/note_list_screen.dart';
import 'services/webview_service.dart';
import 'services/connectivity_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheService.init();
  final String? savedMode = CacheService.getData<String>(
    key: CacheService.keyOpenMode,
  );

  final webviewService = WebviewService();
  final connectivityService = ConnectivityService();

  runApp(
    ElSalumApp(
      webviewService: webviewService,
      connectivityService: connectivityService,
      initialMode: savedMode,
    ),
  );
}

class ElSalumApp extends StatelessWidget {
  final WebviewService webviewService;
  final ConnectivityService connectivityService;
  final String? initialMode;

  const ElSalumApp({
    super.key,
    required this.webviewService,
    required this.connectivityService,
    this.initialMode,
  });

  @override
  Widget build(BuildContext context) {
    Widget initialScreen;

    if (initialMode == onlineMode) {
      initialScreen = MainScreen(
        webviewService: webviewService,
        connectivityService: connectivityService,
      );
    } else if (initialMode == offlineMode) {
      initialScreen = NoteListScreen(
        webviewService: webviewService,
        connectivityService: connectivityService,
      );
    } else {
      initialScreen = ModeSelectionScreen(
        webviewService: webviewService,
        connectivityService: connectivityService,
      );
    }

    return MaterialApp(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: false,

      // Arabic / RTL Support
      locale: const Locale('ar'),
      // supportedLocales: const [Locale('ar')],
      // localizationsDelegates: const [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],

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

      home: initialScreen,
    );
  }
}
