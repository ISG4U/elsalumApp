import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'notes_dao.dart';

part 'app_database.g.dart';

// ─── Table Definition ─────────────────────────────────────────────────────────

/// Drift table for offline notes.
///
/// Column specs:
///   id           – UUID string primary key
///   status       – int (1 = new, 2 = uploaded) from [NoteStatus] enum
///   farms        – string
///   merchant     – string
///   trackNumber  – int
///   creationDate – DateTime (stored as Unix ms by Drift)
///   userName     – string
///   products     – string (comma-separated or JSON)
class NotesTable extends Table {
  /// UUID v4 primary key – safe for offline-first sync.
  TextColumn get id => text()();

  /// Status int: 1 = new, 2 = uploaded.
  IntColumn get status => integer().withDefault(const Constant(1))();

  /// Farm name(s).
  TextColumn get farms => text()();

  /// Merchant name.
  TextColumn get merchant => text()();

  /// Shipment / track number.
  IntColumn get trackNumber => integer()();

  /// Date the note was created.
  DateTimeColumn get creationDate => dateTime()();

  /// Name of the user who created the note.
  TextColumn get userName => text()();

  /// Products string (serialised list).
  TextColumn get products => text()();

  @override
  Set<Column> get primaryKey => {id};
}

// ─── Database Class ───────────────────────────────────────────────────────────

@DriftDatabase(tables: [NotesTable], daos: [NotesDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase._internal() : super(_openConnection());

  // ── Singleton ──────────────────────────────────────────────────────────────
  static AppDatabase? _instance;
  static AppDatabase get instance => _instance ??= AppDatabase._internal();

  @override
  int get schemaVersion => 1;
}

// ─── Connection Factory ───────────────────────────────────────────────────────

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'elsalum_notes.db'));
    return NativeDatabase.createInBackground(file);
  });
}
