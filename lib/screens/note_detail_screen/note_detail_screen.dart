import 'package:elsalum_app/screens/note_detail_screen/card.dart';
import 'package:elsalum_app/screens/note_detail_screen/note_app_bar.dart';
import 'package:elsalum_app/screens/note_detail_screen/note_status_info.dart';
import 'package:flutter/material.dart';
import '../../core/database/app_database.dart';
import '../../core/theme/app_colors.dart';
import '../../services/note_service.dart';

// ── Screen ───────────────────────────────────────────────────────────────────

class NoteDetailScreen extends StatelessWidget {
  final String noteId;
  final NoteService noteService;
  final NotesTableData? initialNote;

  const NoteDetailScreen({
    super.key,
    required this.noteId,
    required this.noteService,
    this.initialNote,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<NotesTableData?>(
      stream: noteService.watchNoteById(noteId),
      initialData: initialNote,
      builder: (context, snapshot) {
        final note = snapshot.data;

        if (note == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: Text('الملاحظة غير موجودة')),
          );
        }

        final statusInfo = NoteStatusInfo.from(
          noteService.statusFromData(note),
        );
        final total = note.products.fold<double>(0, (sum, p) => sum + p.total);

        return Scaffold(
          appBar: NoteAppBar(note: note, noteService: noteService),
          backgroundColor: AppColors.background,
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                HeaderCard(note: note, statusInfo: statusInfo),
                const SizedBox(height: 16),
                DetailsCard(note: note),
                const SizedBox(height: 16),
                ProductsCard(note: note),
                const SizedBox(height: 16),
                TotalCard(total: total),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}
