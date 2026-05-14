import 'package:elsalum_app/core/models/note_model.dart';
import 'package:elsalum_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class NoteStatusInfo {
  final Color color;
  final String label;

  const NoteStatusInfo({required this.color, required this.label});

  factory NoteStatusInfo.from(NoteStatus status) {
    return status == NoteStatus.newNote
        ? NoteStatusInfo(color: AppColors.statusNew, label: 'جديد')
        : NoteStatusInfo(color: AppColors.statusUploaded, label: 'مرفوع');
  }
}
