import 'package:elsalum_app/core/theme/app_text_styles.dart';
import 'package:elsalum_app/screens/note_detail_screen/note_status_info.dart';
import 'package:flutter/material.dart';

class StatusBadge extends StatelessWidget {
  final NoteStatusInfo statusInfo;

  const StatusBadge({super.key, required this.statusInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: statusInfo.color.withAlpha(26),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        statusInfo.label,
        style: AppTextStyles.chipText.copyWith(color: statusInfo.color),
      ),
    );
  }
}

class NoteDetailRow extends StatelessWidget {
  final String label;
  final String value;

  const NoteDetailRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 100, child: Text(label, style: AppTextStyles.label)),
        Expanded(child: Text(value, style: AppTextStyles.body)),
      ],
    );
  }
}
