import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notehax/constants/app_constants.dart';
import 'package:notehax/models/note_model.dart';

class NoteCard extends StatelessWidget {
  final NoteModel note;
  final VoidCallback onTap;
  final bool isListView;

  const NoteCard({
    super.key,
    required this.note,
    required this.onTap,
    this.isListView = false,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = _parseColor(note.backgroundColor);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: AppBorderRadius.medium,
          border: Border.all(
            color: AppColors.borderColor,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: bgColor.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: AppBorderRadius.medium,
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header with title and badges
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        note.title.isEmpty ? 'Untitled' : note.title,
                        style: AppTextStyles.heading3.copyWith(
                          fontSize: 18,
                        ),
                        maxLines: isListView ? 1 : 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (note.isPinned)
                      Icon(
                        Icons.push_pin,
                        size: 16,
                        color: AppColors.neonBlue,
                      ),
                    if (note.isLocked)
                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Icon(
                          Icons.lock,
                          size: 16,
                          color: AppColors.warning,
                        ),
                      ),
                  ],
                ),
                
                const SizedBox(height: AppSpacing.sm),
                
                // Content preview
                if (note.content.isNotEmpty)
                  Text(
                    note.content,
                    style: AppTextStyles.bodySecondary,
                    maxLines: isListView ? 2 : 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                
                const SizedBox(height: AppSpacing.sm),
                
                // Tags
                if (note.hasTags)
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: note.tags.take(3).map((tag) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.neonBlue.withOpacity(0.2),
                          borderRadius: AppBorderRadius.small,
                        ),
                        child: Text(
                          tag,
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.neonBlue,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                
                const Spacer(),
                
                // Footer with date
                Text(
                  DateFormat('MMM d, yyyy').format(note.updatedAt),
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _parseColor(String colorString) {
    try {
      return Color(int.parse(colorString.replaceAll('#', '0xFF')));
    } catch (e) {
      return AppColors.cardDark;
    }
  }
}
