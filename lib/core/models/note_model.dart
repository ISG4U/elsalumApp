/// Note status enum with explicit int values stored in the DB.
enum NoteStatus {
  newNote(1),
  uploaded(2);

  const NoteStatus(this.value);
  final int value;

  static NoteStatus fromValue(int v) =>
      NoteStatus.values.firstWhere((e) => e.value == v);
}

/// Lightweight domain model that mirrors the Drift-generated data class
/// but keeps business logic separate from generated code.
class NoteModel {
  final String id;
  final NoteStatus status;
  final String farms;
  final String merchant;
  final int trackNumber;
  final DateTime creationDate;
  final String userName;
  final String products;

  const NoteModel({
    required this.id,
    required this.status,
    required this.farms,
    required this.merchant,
    required this.trackNumber,
    required this.creationDate,
    required this.userName,
    required this.products,
  });
}
