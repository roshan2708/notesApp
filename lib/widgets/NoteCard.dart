import 'package:flutter/material.dart';
import 'package:notes_app/constants/Colors.dart';
import 'package:notes_app/models/NotesModel.dart';
import 'package:intl/intl.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const NoteCard({
    super.key,
    required this.note,
    this.onEdit,
    this.onDelete,
  });

  String _getPreviewContent(String content) {
    final lines = content.split('\n');
    return lines.take(3).join('\n');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: VintageColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: VintageColors.shadowColor,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: VintageColors.borderColor,
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        note.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: VintageColors.primaryText,
                        ),
                      ),
                    ),
                    PopupMenuButton<String>(
                      icon: const Icon(
                        Icons.more_vert,
                        color: VintageColors.secondaryText,
                      ),
                      color: VintageColors.surfaceColor,
                      onSelected: (String result) {
                        switch (result) {
                          case 'edit':
                            onEdit?.call();
                            break;
                          case 'delete':
                            onDelete?.call();
                            break;
                        }
                      },
                      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(Icons.edit, color: VintageColors.buttonEdit),
                              SizedBox(width: 8),
                              Text(
                                'Edit',
                                style: TextStyle(color: VintageColors.primaryText),
                              ),
                            ],
                          ),
                        ),
                        const PopupMenuItem<String>(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete, color: VintageColors.buttonDelete),
                              SizedBox(width: 8),
                              Text(
                                'Delete',
                                style: TextStyle(color: VintageColors.primaryText),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: VintageColors.oldPaper,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: VintageColors.borderColor,
                      width: 0.5,
                    ),
                  ),
                  child: Text(
                    _getPreviewContent(note.content),
                    style: const TextStyle(
                      fontSize: 14,
                      color: VintageColors.secondaryText,
                      height: 1.4,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: VintageColors.lightBrown.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            size: 12,
                            color: VintageColors.lightText,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            DateFormat('MMM dd, yyyy').format(note.createdAt),
                            style: const TextStyle(
                              fontSize: 11,
                              color: VintageColors.lightText,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}