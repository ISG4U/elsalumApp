import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart' show Value;
import '../core/database/app_database.dart';
import '../core/models/note_model.dart';

class NoteService {
  final AppDatabase _db;
  final _uuid = const Uuid();
  StreamSubscription<List<NotesTableData>>? _notesSubscription;

  // State notifiers
  final ValueNotifier<List<NotesTableData>> notes = ValueNotifier([]);
  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final ValueNotifier<String?> error = ValueNotifier(null);

  NoteService({AppDatabase? db}) : _db = db ?? AppDatabase.instance;

  /// Starts watching the notes stream from the database.
  void startWatching() {
    _notesSubscription?.cancel();
    _notesSubscription = _db.notesDao.watchAllNotes().listen((data) {
      notes.value = data;
    });
  }

  // ── Helpers ──────────────────────────────────────────────────────────────

  NoteStatus statusFromData(NotesTableData d) => NoteStatus.fromValue(d.status);

  // ── CRUD ────────────────────────────────────────────────────────────────

  Future<void> addNote({
    required String farms,
    required String merchant,
    required int trackNumber,
    required String userName,
    required String products,
  }) async {
    isLoading.value = true;
    try {
      await _db.notesDao.insertNote(
        NotesTableCompanion(
          id: Value(_uuid.v4()),
          status: const Value(1), // NoteStatus.newNote
          farms: Value(farms),
          merchant: Value(merchant),
          trackNumber: Value(trackNumber),
          creationDate: Value(DateTime.now()),
          userName: Value(userName),
          products: Value(products),
        ),
      );
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> editNote({
    required String id,
    required String farms,
    required String merchant,
    required int trackNumber,
    required String userName,
    required String products,
    int? status,
  }) async {
    isLoading.value = true;
    try {
      final existing = await _db.notesDao.getNoteById(id);
      if (existing == null) return;
      await _db.notesDao.updateNote(
        NotesTableCompanion(
          id: Value(id),
          status: Value(status ?? existing.status),
          farms: Value(farms),
          merchant: Value(merchant),
          trackNumber: Value(trackNumber),
          creationDate: Value(existing.creationDate),
          userName: Value(userName),
          products: Value(products),
        ),
      );
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteNote(String id) async {
    isLoading.value = true;
    try {
      await _db.notesDao.deleteNote(id);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void dispose() {
    _notesSubscription?.cancel();
    notes.dispose();
    isLoading.dispose();
    error.dispose();
  }
}
