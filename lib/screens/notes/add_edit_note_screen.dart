import 'package:flutter/material.dart';
import '../../core/database/app_database.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../services/note_service.dart';

class AddEditNoteScreen extends StatefulWidget {
  final NoteService noteService;
  final NotesTableData? existingNote;

  const AddEditNoteScreen({
    super.key,
    required this.noteService,
    this.existingNote,
  });

  @override
  State<AddEditNoteScreen> createState() => _AddEditNoteScreenState();
}

class _AddEditNoteScreenState extends State<AddEditNoteScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _farmsCtrl;
  late final TextEditingController _merchantCtrl;
  late final TextEditingController _trackNumCtrl;
  late final TextEditingController _userNameCtrl;
  late final TextEditingController _productsCtrl;

  @override
  void initState() {
    super.initState();
    _farmsCtrl = TextEditingController(text: widget.existingNote?.farms ?? '');
    _merchantCtrl = TextEditingController(
      text: widget.existingNote?.merchant ?? '',
    );
    _trackNumCtrl = TextEditingController(
      text: widget.existingNote != null
          ? widget.existingNote!.trackNumber.toString()
          : '',
    );
    _userNameCtrl = TextEditingController(
      text: widget.existingNote?.userName ?? '',
    );
    _productsCtrl = TextEditingController(
      text: widget.existingNote?.products ?? '',
    );
  }

  @override
  void dispose() {
    _farmsCtrl.dispose();
    _merchantCtrl.dispose();
    _trackNumCtrl.dispose();
    _userNameCtrl.dispose();
    _productsCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final farms = _farmsCtrl.text.trim();
    final merchant = _merchantCtrl.text.trim();
    final trackNumber = int.tryParse(_trackNumCtrl.text.trim()) ?? 0;
    final userName = _userNameCtrl.text.trim();
    final products = _productsCtrl.text.trim();

    if (widget.existingNote == null) {
      await widget.noteService.addNote(
        farms: farms,
        merchant: merchant,
        trackNumber: trackNumber,
        userName: userName,
        products: products,
      );
    } else {
      await widget.noteService.editNote(
        id: widget.existingNote!.id,
        farms: farms,
        merchant: merchant,
        trackNumber: trackNumber,
        userName: userName,
        products: products,
      );
    }

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.existingNote != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEdit ? 'تعديل ملاحظة' : 'إضافة ملاحظة',
          style: AppTextStyles.heading2,
        ),
      ),
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildCard(
                  children: [
                    _buildTextField(
                      controller: _merchantCtrl,
                      label: 'التاجر',
                      icon: Icons.person,
                      validator: (v) => v == null || v.isEmpty
                          ? 'يرجى إدخال اسم التاجر'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _farmsCtrl,
                      label: 'المزارع',
                      icon: Icons.landscape,
                      validator: (v) => v == null || v.isEmpty
                          ? 'يرجى إدخال اسم المزرعة'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _trackNumCtrl,
                      label: 'رقم التتبع',
                      icon: Icons.numbers,
                      keyboardType: TextInputType.number,
                      validator: (v) => v == null || v.isEmpty
                          ? 'يرجى إدخال رقم التتبع'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _userNameCtrl,
                      label: 'اسم المستخدم',
                      icon: Icons.account_circle,
                      validator: (v) => v == null || v.isEmpty
                          ? 'يرجى إدخال اسم المستخدم'
                          : null,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildCard(
                  children: [
                    _buildTextField(
                      controller: _productsCtrl,
                      label: 'المنتجات',
                      icon: Icons.inventory,
                      maxLines: 4,
                      validator: (v) =>
                          v == null || v.isEmpty ? 'يرجى إدخال المنتجات' : null,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                ValueListenableBuilder<bool>(
                  valueListenable: widget.noteService.isLoading,
                  builder: (context, isLoading, child) {
                    return ElevatedButton(
                      onPressed: isLoading ? null : _save,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.fabColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator(
                              color: AppColors.surface,
                            )
                          : Text(
                              'حفظ',
                              style: AppTextStyles.heading2.copyWith(
                                color: AppColors.surface,
                              ),
                            ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard({required List<Widget> children}) {
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

  Widget _buildTextField({
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
