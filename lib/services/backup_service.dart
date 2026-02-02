import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:notehax/models/note_model.dart';
import 'package:notehax/services/hive_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class BackupService {
  static final BackupService instance = BackupService._internal();
  BackupService._internal();

  final _hiveService = HiveService.instance;

  Future<String> exportNotesToJson() async {
    final notesBox = _hiveService.notesBox;
    final notes = notesBox.values.toList();

    final exportData = {
      'version': '1.0.0',
      'exportDate': DateTime.now().toIso8601String(),
      'notesCount': notes.length,
      'notes': notes.map((note) => {
        'id': note.id,
        'title': note.title,
        'content': note.content,
        'createdAt': note.createdAt.toIso8601String(),
        'updatedAt': note.updatedAt.toIso8601String(),
        'tags': note.tags,
        'backgroundColor': note.backgroundColor,
        'fontStyle': note.fontStyle,
        'isLocked': note.isLocked,
        'isPinned': note.isPinned,
        'unlockDate': note.unlockDate?.toIso8601String(),
        'imagePaths': note.imagePaths,
        'isChecklist': note.isChecklist,
        'checklistItems': note.checklistItems.map((item) => {
          'text': item.text,
          'isCompleted': item.isCompleted,
        }).toList(),
        'reminderDate': note.reminderDate?.toIso8601String(),
        'isArchived': note.isArchived,
        'isFavorite': note.isFavorite,
      }).toList(),
    };

    return jsonEncode(exportData);
  }

  Future<File> createBackupFile() async {
    final jsonData = await exportNotesToJson();
    final directory = await getApplicationDocumentsDirectory();
    final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
    final fileName = 'notehax_backup_$timestamp.json';
    final file = File('${directory.path}/$fileName');
    
    await file.writeAsString(jsonData);
    return file;
  }

  Future<void> shareBackup() async {
    final file = await createBackupFile();
    await Share.shareXFiles(
      [XFile(file.path)],
      subject: 'NoteHax Backup',
      text: 'My NoteHax notes backup',
    );
  }

  Future<int> importNotesFromJson(String jsonString) async {
    try {
      final data = jsonDecode(jsonString) as Map<String, dynamic>;
      final notesList = data['notes'] as List;
      final notesBox = _hiveService.notesBox;
      
      int importedCount = 0;
      
      for (final noteData in notesList) {
        final note = NoteModel(
          id: noteData['id'] as String,
          title: noteData['title'] as String,
          content: noteData['content'] as String,
          createdAt: DateTime.parse(noteData['createdAt'] as String),
          updatedAt: DateTime.parse(noteData['updatedAt'] as String),
          tags: List<String>.from(noteData['tags'] ?? []),
          backgroundColor: noteData['backgroundColor'] as String? ?? '#1E1E1E',
          fontStyle: noteData['fontStyle'] as String? ?? 'default',
          isLocked: noteData['isLocked'] as bool? ?? false,
          isPinned: noteData['isPinned'] as bool? ?? false,
          unlockDate: noteData['unlockDate'] != null
              ? DateTime.parse(noteData['unlockDate'] as String)
              : null,
          imagePaths: List<String>.from(noteData['imagePaths'] ?? []),
          isChecklist: noteData['isChecklist'] as bool? ?? false,
          checklistItems: (noteData['checklistItems'] as List?)
                  ?.map((item) => ChecklistItem(
                        text: item['text'] as String,
                        isCompleted: item['isCompleted'] as bool,
                      ))
                  .toList() ??
              [],
          reminderDate: noteData['reminderDate'] != null
              ? DateTime.parse(noteData['reminderDate'] as String)
              : null,
          isArchived: noteData['isArchived'] as bool? ?? false,
          isFavorite: noteData['isFavorite'] as bool? ?? false,
        );
        
        await notesBox.put(note.id, note);
        importedCount++;
      }
      
      return importedCount;
    } catch (e) {
      throw Exception('Failed to import notes: $e');
    }
  }

  Future<int> importFromFile(File file) async {
    final jsonString = await file.readAsString();
    return await importNotesFromJson(jsonString);
  }
}
