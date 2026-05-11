import 'package:flutter/material.dart';
import '../services/webview_service.dart';

class AppDrawer extends StatelessWidget {
  final WebviewService webviewService;

  const AppDrawer({super.key, required this.webviewService});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: const Center(
              child: Text(
                'السلوم والغيث',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          _buildMenuItem(
            context,
            title: 'Fromlive17112025',
            url: 'https://elsalum.isg4u.com/odoo?db=fromlive17112025',
          ),
          _buildMenuItem(
            context,
            title: 'Live',
            url: 'https://elsalum.isg4u.com/odoo?db=live',
          ),
          _buildMenuItem(
            context,
            title: 'Live13012026',
            url: 'https://elsalum.isg4u.com/odoo?db=live13012026',
          ),
          _buildMenuItem(
            context,
            title: 'Test',
            url: 'https://elsalum.isg4u.com/odoo?db=test',
          ),
          _buildMenuItem(
            context,
            title: 'Test2',
            url: 'https://elsalum.isg4u.com/odoo?db=test2',
          ),
          const Divider(),
          _buildMenuItem(
            context,
            title: 'Manage databases',
            url: 'https://elsalum.isg4u.com/web/database/manager',
            icon: Icons.settings,
          ),
          _buildMenuItem(
            context,
            title: 'Privacy policy',
            url: 'https://www.odoo.com/privacy',
            icon: Icons.privacy_tip,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required String title,
    required String url,
    IconData icon = Icons.link,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        webviewService.loadUrl(url);
        Navigator.pop(context);
      },
    );
  }
}
