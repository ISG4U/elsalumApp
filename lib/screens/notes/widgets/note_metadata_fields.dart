import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class NoteMetadataFields extends StatelessWidget {
  final TextEditingController merchantCtrl;
  final TextEditingController farmsCtrl;
  final TextEditingController trackNumCtrl;
  final TextEditingController userNameCtrl;
  final bool isFilter;

  const NoteMetadataFields({
    super.key,
    required this.merchantCtrl,
    required this.farmsCtrl,
    required this.trackNumCtrl,
    required this.userNameCtrl,
    this.isFilter = false,
  });

  @override
  Widget build(BuildContext context) {
    return buildCard(
      children: [
        buildTextField(
          controller: merchantCtrl,
          label: 'التاجر',
          icon: Icons.person,
          validator: isFilter
              ? null
              : (v) => v == null || v.isEmpty ? 'يرجى إدخال اسم التاجر' : null,
        ),
        const SizedBox(height: 16),
        buildTextField(
          controller: farmsCtrl,
          label: 'المزارع',
          icon: Icons.landscape,
          validator: isFilter
              ? null
              : (v) => v == null || v.isEmpty ? 'يرجى إدخال اسم المزرعة' : null,
        ),
        const SizedBox(height: 16),
        buildTextField(
          controller: trackNumCtrl,
          label: 'رقم المسار',
          icon: Icons.numbers,
          keyboardType: TextInputType.number,
          validator: isFilter
              ? null
              : (v) => v == null || v.isEmpty ? 'يرجى إدخال رقم المسار' : null,
        ),
        const SizedBox(height: 16),
        buildTextField(
          controller: userNameCtrl,
          label: 'اسم المستخدم',
          icon: Icons.account_circle,
          validator: isFilter
              ? null
              : (v) =>
                    v == null || v.isEmpty ? 'يرجى إدخال اسم المستخدم' : null,
        ),
      ],
    );
  }

  static Widget buildCard({required List<Widget> children}) {
    return Card(
      color: AppColors.surface,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children,
        ),
      ),
    );
  }

  static Widget buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      style: AppTextStyles.body,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: AppTextStyles.bodySecondary,
        prefixIcon: Icon(icon, color: AppColors.odooPurple),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.odooPurple),
        ),
      ),
    );
  }
}
