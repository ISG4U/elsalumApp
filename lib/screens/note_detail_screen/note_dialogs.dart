import 'package:elsalum_app/core/theme/app_colors.dart';
import 'package:elsalum_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

abstract class NoteDialogs {
  static Future<bool?> showDelete(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('حذف الملاحظة', style: AppTextStyles.heading2),
        content: const Text(
          'هل أنت متأكد من حذف هذه الملاحظة؟',
          style: AppTextStyles.body,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text(
              'حذف',
              style: TextStyle(color: AppColors.odooError),
            ),
          ),
        ],
      ),
    );
  }

  static Future<bool?> showStatusChange(
    BuildContext context, {
    required String nextStatusLabel,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('تغيير الحالة', style: AppTextStyles.heading2),
        content: Text(
          'هل أنت متأكد من تغيير حالة الملاحظة إلى "$nextStatusLabel"؟',
          style: AppTextStyles.body,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('تأكيد'),
          ),
        ],
      ),
    );
  }
}
