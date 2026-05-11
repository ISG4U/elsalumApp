import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../config/app_config.dart';
import 'navigation_service.dart';

class WebviewService {
  late final WebViewController controller;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(true);
  final ValueNotifier<bool> hasError = ValueNotifier<bool>(false);
  final ValueNotifier<String> pageTitle = ValueNotifier<String>(
    AppConfig.appName,
  );
  final ValueNotifier<double> progress = ValueNotifier<double>(0);

  WebviewService() {
    _initController();
  }

  void _initController() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setUserAgent(AppConfig.userAgent)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int val) {
            progress.value = val / 100;
          },
          onPageStarted: (String url) {
            isLoading.value = true;
            hasError.value = false;
          },
          onPageFinished: (String url) {
            isLoading.value = false;
            _updateTitle();
            _injectCustomStyles();
          },
          onWebResourceError: (WebResourceError error) {
            log(
              "WebView Error: ${error.description} error from main frame ${error.isForMainFrame}",
            );
            if (error.isForMainFrame ?? false) {
              hasError.value = true;
              isLoading.value = false;
            }
          },
          onNavigationRequest: (NavigationRequest request) {
            final mode = NavigationService.decideUrl(request.url);

            if (mode == UrlMode.external) {
              NavigationService.launchExternal(request.url);
              return NavigationDecision.prevent;
            }

            if (mode == UrlMode.appbrowser) {
              // We will handle pushing the AppBrowser screen in the UI layer
              // but for the delegate, we cancel the main webview navigation
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(AppConfig.initialUrl));
  }

  Future<void> _updateTitle() async {
    final title = await controller.getTitle();
    if (title != null && title.isNotEmpty) {
      pageTitle.value = title;
    }
  }

  void _injectCustomStyles() {
    // Median uses androidCustomCSS.css and androidCustomJS.js
    // We can inject them here if needed
    // controller.runJavaScript("...");
  }

  void reload() async {
    final currentUrl = await controller.currentUrl();
    if (hasError.value ||
        currentUrl == null ||
        currentUrl == 'about:blank' ||
        currentUrl.startsWith('data:')) {
      controller.loadRequest(Uri.parse(AppConfig.initialUrl));
    } else {
      controller.reload();
    }
  }

  void goBack() async {
    if (await controller.canGoBack()) {
      controller.goBack();
    }
  }

  void loadUrl(String url) {
    controller.loadRequest(Uri.parse(url));
  }

  void dispose() {
    isLoading.dispose();
    hasError.dispose();
    pageTitle.dispose();
    progress.dispose();
  }
}
