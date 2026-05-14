import 'package:flutter/material.dart';
import '../../core/models/note_model.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class AddProductScreen extends StatefulWidget {
  final Product? existingProduct;

  const AddProductScreen({super.key, this.existingProduct});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameCtrl;
  late final TextEditingController _priceCtrl;
  late final TextEditingController _qtyCtrl;
  late ProductType _selectedType;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.existingProduct?.name ?? '');
    _priceCtrl = TextEditingController(
      text: widget.existingProduct?.unitPrice.toString() ?? '',
    );
    _qtyCtrl = TextEditingController(
      text: widget.existingProduct?.quantity.toString() ?? '',
    );
    _selectedType = widget.existingProduct?.type ?? ProductType.box;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _priceCtrl.dispose();
    _qtyCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final name = _nameCtrl.text.trim();
    final price = double.tryParse(_priceCtrl.text.trim()) ?? 0.0;
    final qty = int.tryParse(_qtyCtrl.text.trim()) ?? 1;

    final product = Product(
      name: name,
      unitPrice: price,
      quantity: qty,
      type: _selectedType,
    );

    Navigator.pop(context, product);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.existingProduct != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEdit ? 'تعديل منتج' : 'إضافة منتج',
          style: AppTextStyles.heading2,
        ),
      ),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                color: AppColors.surface,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildField(
                        controller: _nameCtrl,
                        label: 'اسم المنتج',
                        icon: Icons.shopping_basket,
                        validator: (v) => v == null || v.isEmpty
                            ? 'يرجى إدخال اسم المنتج'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _buildField(
                              controller: _priceCtrl,
                              label: 'سعر الوحدة',
                              icon: Icons.attach_money,
                              validator: (v) => v == null || v.isEmpty
                                  ? 'يرجى إدخال سعر الوحدة'
                                  : null,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildField(
                              controller: _qtyCtrl,
                              label: 'الكمية',
                              icon: Icons.add_shopping_cart,
                              validator: (v) => v == null || v.isEmpty
                                  ? 'يرجى إدخال الكمية'
                                  : null,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<ProductType>(
                        initialValue: _selectedType,
                        style: AppTextStyles.body,
                        decoration: InputDecoration(
                          labelText: 'النوع',
                          labelStyle: AppTextStyles.bodySecondary,
                          prefixIcon: const Icon(
                            Icons.category,
                            color: AppColors.odooPurple,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: ProductType.box,
                            child: Text('كرتونة'),
                          ),
                          DropdownMenuItem(
                            value: ProductType.unit,
                            child: Text('قطعة'),
                          ),
                        ],
                        onChanged: (v) => setState(() => _selectedType = v!),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.fabColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  isEdit ? 'تعديل' : 'إضافة',
                  style: AppTextStyles.heading2.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      style: AppTextStyles.body,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: AppTextStyles.bodySecondary,
        prefixIcon: Icon(icon, color: AppColors.odooPurple),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
