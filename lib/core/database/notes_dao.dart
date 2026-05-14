import 'package:drift/drift.dart';
import 'app_database.dart';

part 'notes_dao.g.dart';

/// Data Access Object for all note-related database operations.
@DriftAccessor(tables: [NotesTable])
class NotesDao extends DatabaseAccessor<AppDatabase> with _$NotesDaoMixin {
  NotesDao(super.db);

  // ── Read ──────────────────────────────────────────────────────────────────

  /// Stream of all notes ordered by status (new first) and creation date descending.
  Stream<List<NotesTableData>> watchAllNotes() =>
      (select(notesTable)..orderBy([
            (t) => OrderingTerm.asc(t.status),
            (t) => OrderingTerm.desc(t.creationDate),
          ]))
          .watch();

  /// Fetch a single note by its UUID id; returns null if not found.
  Future<NotesTableData?> getNoteById(String id) =>
      (select(notesTable)..where((t) => t.id.equals(id))).getSingleOrNull();

  /// Watch a single note by its UUID id (reactive).
  Stream<NotesTableData?> watchNoteById(String id) =>
      (select(notesTable)..where((t) => t.id.equals(id))).watchSingleOrNull();

  // ── Write ─────────────────────────────────────────────────────────────────

  /// Insert a new note. Throws if the id already exists.
  Future<void> insertNote(NotesTableCompanion entry) =>
      into(notesTable).insert(entry);

  /// Replace an existing note with updated data (requires full entity).
  Future<bool> updateNote(NotesTableCompanion entry) =>
      update(notesTable).replace(entry);

  /// Update only the provided fields in the note companion.
  Future<int> partialUpdateNote(NotesTableCompanion entry) => (update(
    notesTable,
  )..where((t) => t.id.equals(entry.id.value))).write(entry);

  // ── Delete ────────────────────────────────────────────────────────────────

  /// Delete a note by UUID id. Returns the number of rows deleted.
  Future<int> deleteNote(String id) =>
      (delete(notesTable)..where((t) => t.id.equals(id))).go();
}
