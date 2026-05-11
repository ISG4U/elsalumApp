import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../services/webview_service.dart';
import '../services/connectivity_service.dart';
import '../widgets/app_drawer.dart';
import 'offline_screen.dart';

class MainScreen extends StatefulWidget {
  final WebviewService webviewService;
  final ConnectivityService connectivityService;

  const MainScreen({
    super.key,
    required this.webviewService,
    required this.connectivityService,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _wasOffline = false;

  @override
  void initState() {
    super.initState();
    widget.connectivityService.isOnline.addListener(_onConnectivityChanged);
  }

  @override
  void dispose() {
    widget.connectivityService.isOnline.removeListener(_onConnectivityChanged);
    super.dispose();
  }

  void _onConnectivityChanged() {
    final isOnline = widget.connectivityService.isOnline.value;
    if (isOnline && _wasOffline) {
      widget.webviewService.reload();
    }
    _wasOffline = !isOnline;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: ValueListenableBuilder<String>(
      //     valueListenable: widget.webviewService.pageTitle,
      //     builder: (context, title, child) => Text(title),
      //   ),
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.refresh),
      //       onPressed: () => widget.webviewService.reload(),
      //     ),
      //   ],
      //   bottom: PreferredSize(
      //     preferredSize: const Size.fromHeight(4.0),
      //     child: ValueListenableBuilder<double>(
      //       valueListenable: widget.webviewService.progress,
      //       builder: (context, val, child) {
      //         return val < 1.0
      //             ? LinearProgressIndicator(value: val)
      //             : const SizedBox.shrink();
      //       },
      //     ),
      //   ),
      // ),
      drawer: AppDrawer(webviewService: widget.webviewService),
      body: SafeArea(
        child: Stack(
          children: [
            // The Main WebView
            WebViewWidget(controller: widget.webviewService.controller),

            // Loading Overlay
            ValueListenableBuilder<bool>(
              valueListenable: widget.webviewService.isLoading,
              builder: (context, isLoading, child) {
                return isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : const SizedBox.shrink();
              },
            ),

            // Offline/Error Overlay
            ValueListenableBuilder<bool>(
              valueListenable: widget.connectivityService.isOnline,
              builder: (context, isOnline, child) {
                return ValueListenableBuilder<bool>(
                  valueListenable: widget.webviewService.hasError,
                  builder: (context, hasError, child) {
                    if (!isOnline || hasError) {
                      return OfflineScreen(
                        onRetry: () => widget.webviewService.reload(),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
