import 'package:hive/hive.dart';

part 'note_model.g.dart';

@HiveType(typeId: 0)
class NoteModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String content;

  @HiveField(3)
  DateTime createdAt;

  @HiveField(4)
  DateTime updatedAt;

  @HiveField(5)
  List<String> tags;

  @HiveField(6)
  String backgroundColor;

  @HiveField(7)
  String fontStyle;

  @HiveField(8)
  bool isLocked;

  @HiveField(9)
  bool isPinned;

  @HiveField(10)
  DateTime? unlockDate;

  @HiveField(11)
  List<String> imagePaths;

  @HiveField(12)
  bool isChecklist;

  @HiveField(13)
  List<ChecklistItem> checklistItems;

  @HiveField(14)
  DateTime? reminderDate;

  @HiveField(15)
  bool isArchived;

  @HiveField(16)
  bool isFavorite;

  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    this.tags = const [],
    this.backgroundColor = '#1E1E1E',
    this.fontStyle = 'default',
    this.isLocked = false,
    this.isPinned = false,
    this.unlockDate,
    this.imagePaths = const [],
    this.isChecklist = false,
    this.checklistItems = const [],
    this.reminderDate,
    this.isArchived = false,
    this.isFavorite = false,
  });

  // Helper methods
  bool get isTimeCapsule => unlockDate != null && unlockDate!.isAfter(DateTime.now());
  bool get hasImages => imagePaths.isNotEmpty;
  bool get hasReminder => reminderDate != null;
  bool get hasTags => tags.isNotEmpty;

  NoteModel copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? tags,
    String? backgroundColor,
    String? fontStyle,
    bool? isLocked,
    bool? isPinned,
    DateTime? unlockDate,
    List<String>? imagePaths,
    bool? isChecklist,
    List<ChecklistItem>? checklistItems,
    DateTime? reminderDate,
    bool? isArchived,
    bool? isFavorite,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      tags: tags ?? this.tags,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      fontStyle: fontStyle ?? this.fontStyle,
      isLocked: isLocked ?? this.isLocked,
      isPinned: isPinned ?? this.isPinned,
      unlockDate: unlockDate ?? this.unlockDate,
      imagePaths: imagePaths ?? this.imagePaths,
      isChecklist: isChecklist ?? this.isChecklist,
      checklistItems: checklistItems ?? this.checklistItems,
      reminderDate: reminderDate ?? this.reminderDate,
      isArchived: isArchived ?? this.isArchived,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

@HiveType(typeId: 1)
class ChecklistItem {
  @HiveField(0)
  String text;

  @HiveField(1)
  bool isCompleted;

  ChecklistItem({
    required this.text,
    this.isCompleted = false,
  });
}
