import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../services/webview_service.dart';
import '../services/connectivity_service.dart';
import '../core/utils/cache_service.dart';
import 'mode_selection_screen.dart';
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
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        await CacheService.removeData(key: CacheService.keyOpenMode);
        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => ModeSelectionScreen(
                webviewService: widget.webviewService,
                connectivityService: widget.connectivityService,
              ),
            ),
          );
        }
      },
      child: Scaffold(
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
      ),
    );
  }
}
