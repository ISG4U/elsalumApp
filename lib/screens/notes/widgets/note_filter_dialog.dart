import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../services/note_filter_service.dart';
import 'note_metadata_fields.dart';

class NoteFilterDialog extends StatefulWidget {
  final NoteFilterOptions currentOptions;

  const NoteFilterDialog({super.key, required this.currentOptions});

  @override
  State<NoteFilterDialog> createState() => _NoteFilterDialogState();
}

class _NoteFilterDialogState extends State<NoteFilterDialog> {
  late final TextEditingController _merchantCtrl;
  late final TextEditingController _farmsCtrl;
  late final TextEditingController _trackNumCtrl;
  late final TextEditingController _userNameCtrl;
  late final TextEditingController _minTotalCtrl;
  late final TextEditingController _maxTotalCtrl;

  @override
  void initState() {
    super.initState();
    _merchantCtrl = TextEditingController(
      text: widget.currentOptions.merchant ?? '',
    );
    _farmsCtrl = TextEditingController(text: widget.currentOptions.farms ?? '');
    _trackNumCtrl = TextEditingController(
      text: widget.currentOptions.trackNum ?? '',
    );
    _userNameCtrl = TextEditingController(
      text: widget.currentOptions.userName ?? '',
    );
    _minTotalCtrl = TextEditingController(
      text: widget.currentOptions.minTotal?.toString() ?? '',
    );
    _maxTotalCtrl = TextEditingController(
      text: widget.currentOptions.maxTotal?.toString() ?? '',
    );
  }

  @override
  void dispose() {
    _merchantCtrl.dispose();
    _farmsCtrl.dispose();
    _trackNumCtrl.dispose();
    _userNameCtrl.dispose();
    _minTotalCtrl.dispose();
    _maxTotalCtrl.dispose();
    super.dispose();
  }

  void _apply() {
    final options = NoteFilterOptions(
      merchant: _merchantCtrl.text.trim(),
      farms: _farmsCtrl.text.trim(),
      trackNum: _trackNumCtrl.text.trim(),
      userName: _userNameCtrl.text.trim(),
      minTotal: double.tryParse(_minTotalCtrl.text.trim()),
      maxTotal: double.tryParse(_maxTotalCtrl.text.trim()),
    );
    Navigator.pop(context, options);
  }

  void _clear() {
    Navigator.pop(context, NoteFilterOptions());
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'تصفية الملاحظات',
              style: AppTextStyles.heading2,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            NoteMetadataFields(
              merchantCtrl: _merchantCtrl,
              farmsCtrl: _farmsCtrl,
              trackNumCtrl: _trackNumCtrl,
              userNameCtrl: _userNameCtrl,
              isFilter: true,
            ),
            const SizedBox(height: 16),
            NoteMetadataFields.buildCard(
              children: [
                Text('إجمالي الفاتورة', style: AppTextStyles.heading2),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: NoteMetadataFields.buildTextField(
                        controller: _minTotalCtrl,
                        label: 'من',
                        icon: Icons.attach_money,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: NoteMetadataFields.buildTextField(
                        controller: _maxTotalCtrl,
                        label: 'إلى',
                        icon: Icons.attach_money,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: _clear,
                    child: const Text(
                      'مسح',
                      style: TextStyle(color: AppColors.odooError),
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.odooPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: _apply,
                    child: const Text(
                      'تطبيق',
                      style: TextStyle(color: AppColors.surface),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
