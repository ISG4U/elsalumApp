import 'package:flutter/foundation.dart';
import '../core/database/app_database.dart';

class NoteFilterOptions {
  final String? merchant;
  final String? farms;
  final String? trackNum;
  final String? userName;
  final double? minTotal;
  final double? maxTotal;

  NoteFilterOptions({
    this.merchant,
    this.farms,
    this.trackNum,
    this.userName,
    this.minTotal,
    this.maxTotal,
  });

  bool get isEmpty =>
      (merchant == null || merchant!.isEmpty) &&
      (farms == null || farms!.isEmpty) &&
      (trackNum == null || trackNum!.isEmpty) &&
      (userName == null || userName!.isEmpty) &&
      minTotal == null &&
      maxTotal == null;
}

class NoteFilterService {
  final ValueNotifier<NoteFilterOptions> filterOptions = ValueNotifier(
    NoteFilterOptions(),
  );

  void updateFilter(NoteFilterOptions options) {
    filterOptions.value = options;
  }

  void clearFilter() {
    filterOptions.value = NoteFilterOptions();
  }

  List<NotesTableData> applyFilter(List<NotesTableData> notes) {
    final options = filterOptions.value;
    if (options.isEmpty) return notes;

    return notes.where((note) {
      if (options.merchant != null && options.merchant!.isNotEmpty) {
        if (!note.merchant.toLowerCase().contains(
          options.merchant!.toLowerCase(),
        )) {
          return false;
        }
      }
      if (options.farms != null && options.farms!.isNotEmpty) {
        if (!note.farms.toLowerCase().contains(options.farms!.toLowerCase())) {
          return false;
        }
      }
      if (options.trackNum != null && options.trackNum!.isNotEmpty) {
        if (note.trackNumber.toString() != options.trackNum) {
          return false;
        }
      }
      if (options.userName != null && options.userName!.isNotEmpty) {
        if (!note.userName.toLowerCase().contains(
          options.userName!.toLowerCase(),
        )) {
          return false;
        }
      }
      if (options.minTotal != null || options.maxTotal != null) {
        final total = note.products.fold<double>(0, (sum, p) => sum + p.total);
        if (options.minTotal != null && total < options.minTotal!) {
          return false;
        }
        if (options.maxTotal != null && total > options.maxTotal!) return false;
      }
      return true;
    }).toList();
  }
}
