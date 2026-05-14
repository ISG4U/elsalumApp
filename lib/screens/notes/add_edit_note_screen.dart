import 'package:elsalum_app/screens/notes/product_list_item.dart';
import 'package:flutter/material.dart';
import '../../core/database/app_database.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../services/note_service.dart';
import '../../core/models/note_model.dart';
import 'add_product_screen.dart';
import 'widgets/note_metadata_fields.dart';

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
  List<Product> _products = [];

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
    _products = widget.existingNote?.products ?? [];
  }

  @override
  void dispose() {
    _farmsCtrl.dispose();
    _merchantCtrl.dispose();
    _trackNumCtrl.dispose();
    _userNameCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final farms = _farmsCtrl.text.trim();
    final merchant = _merchantCtrl.text.trim();
    final trackNumber = int.tryParse(_trackNumCtrl.text.trim()) ?? 0;
    final userName = _userNameCtrl.text.trim();

    if (_products.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى إضافة منتج واحد على الأقل')),
      );
      return;
    }

    if (widget.existingNote == null) {
      await widget.noteService.addNote(
        farms: farms,
        merchant: merchant,
        trackNumber: trackNumber,
        userName: userName,
        products: _products,
      );
    } else {
      await widget.noteService.editNote(
        id: widget.existingNote!.id,
        farms: farms,
        merchant: merchant,
        trackNumber: trackNumber,
        userName: userName,
        products: _products,
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
                NoteMetadataFields(
                  merchantCtrl: _merchantCtrl,
                  farmsCtrl: _farmsCtrl,
                  trackNumCtrl: _trackNumCtrl,
                  userNameCtrl: _userNameCtrl,
                ),
                const SizedBox(height: 16),
                _buildProductSection(),
                const SizedBox(height: 16),
                NoteMetadataFields.buildCard(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('إجمالي الفاتورة', style: AppTextStyles.heading2),
                        Text(
                          _products
                              .fold<double>(0, (sum, p) => sum + p.total)
                              .toStringAsFixed(2),
                          style: AppTextStyles.heading2.copyWith(
                            color: AppColors.odooPurple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
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

  Widget _buildProductSection() {
    return NoteMetadataFields.buildCard(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('المنتجات', style: AppTextStyles.heading2),
            IconButton(
              onPressed: _addProduct,
              icon: const Icon(Icons.add_circle, color: AppColors.odooPurple),
            ),
          ],
        ),
        const Divider(),
        if (_products.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: Text(
                'لم يتم إضافة منتجات',
                style: AppTextStyles.bodySecondary,
              ),
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _products.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final prod = _products[index];
              return ProductListItem(
                product: prod,
                onEdit: () => _editProduct(index),
                onDelete: () => _deleteProduct(index),
              );
            },
          ),
      ],
    );
  }

  void _addProduct() async {
    final result = await Navigator.push<Product>(
      context,
      MaterialPageRoute(builder: (_) => const AddProductScreen()),
    );
    if (result != null) {
      setState(() => _products.add(result));
    }
  }

  void _editProduct(int index) async {
    final result = await Navigator.push<Product>(
      context,
      MaterialPageRoute(
        builder: (_) => AddProductScreen(existingProduct: _products[index]),
      ),
    );
    if (result != null) {
      setState(() => _products[index] = result);
    }
  }

  void _deleteProduct(int index) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('حذف المنتج', style: AppTextStyles.heading2),
        content: Text(
          'هل أنت متأكد من حذف ${(_products[index].name)}؟',
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

    if (confirmed == true) {
      setState(() => _products.removeAt(index));
    }
  }
}
