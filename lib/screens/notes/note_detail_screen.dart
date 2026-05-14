import 'package:flutter/material.dart';
import '../../core/database/app_database.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/models/note_model.dart';
import '../../services/note_service.dart';
import 'add_edit_note_screen.dart';
import 'package:intl/intl.dart';

class NoteDetailScreen extends StatelessWidget {
  final NotesTableData note;
  final NoteService noteService;

  const NoteDetailScreen({
    super.key,
    required this.note,
    required this.noteService,
  });

  Future<bool?> _showDeleteDialog(BuildContext context) {
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

  @override
  Widget build(BuildContext context) {
    // Determine status
    final status = noteService.statusFromData(note);
    final statusColor = status == NoteStatus.newNote
        ? AppColors.statusNew
        : AppColors.statusUploaded;
    final statusText = status == NoteStatus.newNote ? 'جديد' : 'مرفوع';

    return Scaffold(
      appBar: AppBar(
        title: Text(note.merchant, style: AppTextStyles.heading2),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'edit') {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AddEditNoteScreen(
                      noteService: noteService,
                      existingNote: note,
                    ),
                  ),
                );
                // Note: when going back from edit, this screen might show old data
                // until rebuilt if the DB push triggers it, but since this receives a final note
                // it might be better to watch this single note or just pop. For simplicity, just pop.
                if (context.mounted) Navigator.pop(context);
              } else if (value == 'delete') {
                final confirmed = await _showDeleteDialog(context);
                if (confirmed == true) {
                  await noteService.deleteNote(note.id);
                  if (context.mounted) Navigator.pop(context);
                }
              }
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(Icons.edit, size: 20),
                    SizedBox(width: 8),
                    Text('تعديل'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete, color: AppColors.odooError, size: 20),
                    SizedBox(width: 8),
                    Text('حذف', style: TextStyle(color: AppColors.odooError)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Card
            Card(
              color: AppColors.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(26), // 10% opacity
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        statusText,
                        style: AppTextStyles.chipText.copyWith(
                          color: statusColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      note.merchant,
                      style: AppTextStyles.heading1,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'رقم التتبع: #${note.trackNumber}',
                      style: AppTextStyles.bodySecondary,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Details Card
            Card(
              color: AppColors.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('التفاصيل', style: AppTextStyles.heading2),
                    const Divider(height: 24),
                    _buildDetailRow('المزارع:', note.farms),
                    const SizedBox(height: 16),
                    _buildDetailRow('اسم المستخدم:', note.userName),
                    const SizedBox(height: 16),
                    _buildDetailRow(
                      'تاريخ الإنشاء:',
                      DateFormat('yyyy-MM-dd HH:mm').format(note.creationDate),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Products Card
            Card(
              color: AppColors.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('المنتجات', style: AppTextStyles.heading2),
                    const Divider(height: 24),
                    Text(note.products, style: AppTextStyles.body),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 100, child: Text(label, style: AppTextStyles.label)),
        Expanded(child: Text(value, style: AppTextStyles.body)),
      ],
    );
  }
}
