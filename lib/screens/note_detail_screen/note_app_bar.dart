import 'package:elsalum_app/core/database/app_database.dart';
import 'package:elsalum_app/core/models/note_model.dart';
import 'package:elsalum_app/core/theme/app_colors.dart';
import 'package:elsalum_app/core/theme/app_text_styles.dart';
import 'package:elsalum_app/screens/note_detail_screen/note_dialogs.dart';
import 'package:elsalum_app/screens/notes/add_edit_note_screen.dart';
import 'package:elsalum_app/services/note_service.dart';
import 'package:flutter/material.dart';

class NoteAppBar extends StatelessWidget implements PreferredSizeWidget {
  final NotesTableData note;
  final NoteService noteService;

  const NoteAppBar({super.key, required this.note, required this.noteService});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  Future<void> _onEdit(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            AddEditNoteScreen(noteService: noteService, existingNote: note),
      ),
    );
  }

  Future<void> _onDelete(BuildContext context) async {
    final confirmed = await NoteDialogs.showDelete(context);
    if (confirmed == true && context.mounted) {
      await noteService.deleteNote(note.id);
      if (context.mounted) Navigator.pop(context);
    }
  }

  Future<void> _onToggleStatus(BuildContext context) async {
    final currentStatus = noteService.statusFromData(note);
    final nextStatus = currentStatus == NoteStatus.newNote
        ? NoteStatus.uploaded
        : NoteStatus.newNote;
    final nextLabel = nextStatus == NoteStatus.newNote ? 'جديد' : 'مرفوع';

    final confirmed = await NoteDialogs.showStatusChange(
      context,
      nextStatusLabel: nextLabel,
    );
    if (confirmed == true) {
      await noteService.updateNoteStatus(note.id, nextStatus.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(note.merchant, style: AppTextStyles.heading2),
      actions: [
        PopupMenuButton<String>(
          onSelected: (value) {
            switch (value) {
              case 'edit':
                _onEdit(context);
              case 'delete':
                _onDelete(context);
              case 'status':
                _onToggleStatus(context);
            }
          },
          itemBuilder: (_) => const [
            PopupMenuItem(
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit, size: 20),
                  SizedBox(width: 8),
                  Text('تعديل'),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete, color: AppColors.odooError, size: 20),
                  SizedBox(width: 8),
                  Text('حذف', style: TextStyle(color: AppColors.odooError)),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'status',
              child: Row(
                children: [
                  Icon(Icons.sync, color: AppColors.odooPurple, size: 20),
                  SizedBox(width: 8),
                  Text('تغيير الحالة'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
