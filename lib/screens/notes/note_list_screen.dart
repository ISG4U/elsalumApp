import 'package:flutter/material.dart';
import '../../core/database/app_database.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/models/note_model.dart';
import '../../services/note_service.dart';
import '../note_detail_screen/note_detail_screen.dart';
import 'add_edit_note_screen.dart';
import 'package:intl/intl.dart';
import '../../services/webview_service.dart';
import '../../services/connectivity_service.dart';
import '../../core/utils/chach_service.dart';
import '../mode_selection_screen.dart';

class NoteListScreen extends StatefulWidget {
  final WebviewService webviewService;
  final ConnectivityService connectivityService;

  const NoteListScreen({
    super.key,
    required this.webviewService,
    required this.connectivityService,
  });

  @override
  State<NoteListScreen> createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  final NoteService noteService = NoteService();

  @override
  void initState() {
    super.initState();
    noteService.startWatching();
  }

  @override
  void dispose() {
    noteService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        await CacheService.removeData(key: CacheService.keyOpenMode);
        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => ModeSelectionScreen(
                webviewService: widget.webviewService,
                connectivityService: widget.connectivityService,
              ),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('الملاحظات', style: AppTextStyles.heading2),
        ),
        backgroundColor: AppColors.background,
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.fabColor,
          child: const Icon(Icons.add, color: AppColors.textOnPrimary),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddEditNoteScreen(noteService: noteService),
            ),
          ),
        ),
        body: ValueListenableBuilder<List<NotesTableData>>(
          valueListenable: noteService.notes,
          builder: (context, notes, _) {
            if (notes.isEmpty) {
              return const Center(
                child: Text(
                  'لا توجد ملاحظات',
                  style: AppTextStyles.bodySecondary,
                ),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: notes.length,
              itemBuilder: (context, i) {
                return _NoteCard(
                  note: notes[i],
                  noteService: noteService,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => NoteDetailScreen(
                        noteId: notes[i].id,
                        noteService: noteService,
                        initialNote: notes[i],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _NoteCard extends StatelessWidget {
  final NotesTableData note;
  final NoteService noteService;
  final VoidCallback onTap;

  const _NoteCard({
    required this.note,
    required this.noteService,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final status = noteService.statusFromData(note);
    final statusColor = status == NoteStatus.newNote
        ? AppColors.statusNew
        : AppColors.statusUploaded;
    final statusText = status == NoteStatus.newNote ? 'جديد' : 'مرفوع';

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: AppColors.surface,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Status Circle
              Container(
                width: 12,
                height: 12,
                margin: const EdgeInsets.only(top: 6),
                decoration: BoxDecoration(
                  color: statusColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 16),
              // Main content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            note.merchant,
                            style: AppTextStyles.heading2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          note.products
                              .fold<double>(0, (sum, p) => sum + p.total)
                              .toStringAsFixed(2),
                          style: AppTextStyles.heading2.copyWith(
                            color: AppColors.odooPurple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'المزرعة: ${note.farms}',
                      style: AppTextStyles.caption,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'رقم المسار: ${note.trackNumber}',
                      style: AppTextStyles.caption,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'اسم المستخدم: ${note.userName}',
                      style: AppTextStyles.caption,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'المنتجات: ${note.products.length}',
                      style: AppTextStyles.caption,
                    ),
                    const SizedBox(height: 8),
                    // Status Chip & Date
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            statusText,
                            style: AppTextStyles.chipText,
                          ),
                        ),
                        Text(
                          DateFormat(
                            'yyyy-MM-dd HH:mm',
                          ).format(note.creationDate),
                          style: AppTextStyles.caption,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
