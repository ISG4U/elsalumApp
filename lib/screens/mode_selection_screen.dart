import 'package:elsalum_app/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/webview_service.dart';
import '../services/connectivity_service.dart';
import 'main_screen.dart';
import 'notes/note_list_screen.dart';
import '../core/utils/cache_service.dart';

class ModeSelectionScreen extends StatelessWidget {
  final WebviewService webviewService;
  final ConnectivityService connectivityService;

  static const String _privacyPolicyUrl = 'https://www.youtube.com/';

  const ModeSelectionScreen({
    super.key,
    required this.webviewService,
    required this.connectivityService,
  });

  Future<void> _openPrivacyPolicy(BuildContext context) async {
    final uri = Uri.parse(_privacyPolicyUrl);
    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!launched && context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('تعذر فتح سياسة الخصوصية')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Logo
              Expanded(
                child: Center(
                  child: Image.asset(
                    'assets/images/logo_enhanced.jpg',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Online Mode Button
              ElevatedButton.icon(
                onPressed: () async {
                  await CacheService.setData(
                    key: CacheService.keyOpenMode,
                    value: onlineMode,
                  );
                  if (context.mounted) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MainScreen(
                          webviewService: webviewService,
                          connectivityService: connectivityService,
                        ),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.language),
                label: const Text(
                  'وضع الاتصال بالإنترنت (Online)',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: const Color(0xFF1A100B),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Offline Mode Button
              OutlinedButton.icon(
                onPressed: () async {
                  await CacheService.setData(
                    key: CacheService.keyOpenMode,
                    value: offlineMode,
                  );
                  if (context.mounted) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => NoteListScreen(
                          webviewService: webviewService,
                          connectivityService: connectivityService,
                        ),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.note_alt_outlined),
                label: const Text(
                  'وضع عدم الاتصال (Offline - الملاحظات)',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  foregroundColor: const Color(0xFF1A100B),
                  side: const BorderSide(color: Color(0xFF1A100B), width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Privacy Policy Button
              TextButton.icon(
                onPressed: () => _openPrivacyPolicy(context),
                icon: const Icon(Icons.privacy_tip_outlined, size: 18),
                label: const Text(
                  'سياسة الخصوصية',
                  style: TextStyle(fontSize: 14),
                ),
                style: TextButton.styleFrom(foregroundColor: Colors.grey[700]),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
