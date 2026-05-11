import 'package:url_launcher/url_launcher.dart';

enum UrlMode { internal, external, appbrowser }

class NavigationService {
  static UrlMode decideUrl(String url) {
    // 1. Non-web links (tel, mailto, etc.)
    if (!url.startsWith('http')) {
      return UrlMode.external;
    }

    final uri = Uri.parse(url);
    final host = uri.host.toLowerCase();

    // 2. Social Media & Maps -> appbrowser
    if (host.contains('facebook.com') ||
        host.contains('twitter.com') ||
        host.contains('x.com') ||
        host.contains('instagram.com') ||
        host.contains('linkedin.com') ||
        host.contains('maps.google.com') ||
        host.contains('google.com/maps')) {
      return UrlMode.appbrowser;
    }

    // 3. Microsoft Login -> internal
    if (host.contains('login.microsoftonline.com')) {
      return UrlMode.internal;
    }

    // 4. Main domain -> internal
    if (host.contains('isg4u.com')) {
      return UrlMode.internal;
    }

    // 5. Catch-all for other links -> appbrowser
    return UrlMode.appbrowser;
  }

  static Future<void> launchExternal(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
