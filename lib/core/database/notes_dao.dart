import 'package:drift/drift.dart';
import 'app_database.dart';

part 'notes_dao.g.dart';

/// Data Access Object for all note-related database operations.
@DriftAccessor(tables: [NotesTable])
class NotesDao extends DatabaseAccessor<AppDatabase> with _$NotesDaoMixin {
  NotesDao(super.db);

  // ── Read ──────────────────────────────────────────────────────────────────

  /// Stream of all notes ordered by creation date descending (newest first).
  Stream<List<NotesTableData>> watchAllNotes() => (select(
    notesTable,
  )..orderBy([(t) => OrderingTerm.desc(t.creationDate)])).watch();

  /// Fetch a single note by its UUID id; returns null if not found.
  Future<NotesTableData?> getNoteById(String id) =>
      (select(notesTable)..where((t) => t.id.equals(id))).getSingleOrNull();

  // ── Write ─────────────────────────────────────────────────────────────────

  /// Insert a new note. Throws if the id already exists.
  Future<void> insertNote(NotesTableCompanion entry) =>
      into(notesTable).insert(entry);

  /// Replace an existing note with updated data.
  Future<bool> updateNote(NotesTableCompanion entry) =>
      update(notesTable).replace(entry);

  // ── Delete ────────────────────────────────────────────────────────────────

  /// Delete a note by UUID id. Returns the number of rows deleted.
  Future<int> deleteNote(String id) =>
      (delete(notesTable)..where((t) => t.id.equals(id))).go();
}
