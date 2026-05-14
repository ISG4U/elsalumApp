import 'package:elsalum_app/core/models/note_model.dart';
import 'package:elsalum_app/core/theme/app_colors.dart';
import 'package:elsalum_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class ProductListItem extends StatelessWidget {
  final Product product;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final bool showActions;

  const ProductListItem({
    super.key,
    required this.product,
    this.onEdit,
    this.onDelete,
    this.showActions = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: AppTextStyles.body.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'السعر: ${product.unitPrice}',
                  style: AppTextStyles.caption,
                ),
                Text(
                  'الكمية: ${product.quantity} (${product.type == ProductType.box ? 'كرتونة' : 'قطعة'})',
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,

            children: [
              Text(
                'الإجمالي: ${product.total}',
                style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold),
              ),
              if (showActions)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, size: 20),
                      onPressed: onEdit,
                      constraints: const BoxConstraints(),
                      padding: const EdgeInsets.all(8),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.delete,
                        size: 20,
                        color: AppColors.odooError,
                      ),
                      onPressed: onDelete,
                      constraints: const BoxConstraints(),
                      padding: const EdgeInsets.all(8),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}
