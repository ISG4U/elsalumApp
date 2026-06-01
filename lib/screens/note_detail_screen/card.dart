import 'package:elsalum_app/core/database/app_database.dart';
import 'package:elsalum_app/core/theme/app_colors.dart';
import 'package:elsalum_app/core/theme/app_text_styles.dart';
import 'package:elsalum_app/screens/note_detail_screen/note_status_info.dart';
import 'package:elsalum_app/screens/note_detail_screen/status_badge.dart';
import 'package:elsalum_app/screens/notes/product_list_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HeaderCard extends StatelessWidget {
  final NotesTableData note;
  final NoteStatusInfo statusInfo;

  const HeaderCard({super.key, required this.note, required this.statusInfo});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            StatusBadge(statusInfo: statusInfo),
            const SizedBox(height: 12),
            Text(
              note.merchant,
              style: AppTextStyles.heading1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'رقم المسار: ${note.trackNumber}',
              style: AppTextStyles.bodySecondary,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class DetailsCard extends StatelessWidget {
  final NotesTableData note;

  const DetailsCard({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('التفاصيل', style: AppTextStyles.heading2),
            const Divider(height: 24),
            NoteDetailRow(label: 'المزارع:', value: note.farms),
            const SizedBox(height: 16),
            NoteDetailRow(label: 'اسم المستخدم:', value: note.userName),
            const SizedBox(height: 16),
            NoteDetailRow(
              label: 'تاريخ الإنشاء:',
              value: DateFormat('yyyy-MM-dd HH:mm').format(note.creationDate),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductsCard extends StatelessWidget {
  final NotesTableData note;

  const ProductsCard({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('المنتجات', style: AppTextStyles.heading2),
            const Divider(height: 24),
            if (note.products.isEmpty)
              const Text('لا توجد منتجات', style: AppTextStyles.bodySecondary)
            else
              ...note.products.map(
                (p) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: ProductListItem(product: p, showActions: false),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class TotalCard extends StatelessWidget {
  final double total;

  const TotalCard({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: TotalBillWidget(total: total),
      ),
    );
  }
}

class TotalBillWidget extends StatelessWidget {
  const TotalBillWidget({
    super.key,
    required this.total,
  });

  final double total;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('إجمالي الفاتورة', style: AppTextStyles.heading2),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            total.toStringAsFixed(2),
            style: AppTextStyles.heading1.copyWith(
              color: AppColors.odooPurple,
            ),
          ),
        ),
      ],
    );
  }
}
