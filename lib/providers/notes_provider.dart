import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notehax/models/note_model.dart';
import 'package:notehax/services/hive_service.dart';
import 'package:uuid/uuid.dart';

// Notes List Provider
final notesProvider = StateNotifierProvider<NotesNotifier, List<NoteModel>>((ref) {
  return NotesNotifier();
});

class NotesNotifier extends StateNotifier<List<NoteModel>> {
  NotesNotifier() : super([]) {
    loadNotes();
  }

  final _hiveService = HiveService.instance;
  final _uuid = const Uuid();

  void loadNotes() {
    final notesBox = _hiveService.notesBox;
    state = notesBox.values.toList();
  }

  Future<void> createNote(NoteModel note) async {
    final notesBox = _hiveService.notesBox;
    await notesBox.put(note.id, note);
    loadNotes();
  }

  Future<void> updateNote(NoteModel note) async {
    final updatedNote = note.copyWith(updatedAt: DateTime.now());
    final notesBox = _hiveService.notesBox;
    await notesBox.put(updatedNote.id, updatedNote);
    loadNotes();
  }

  Future<void> deleteNote(String noteId) async {
    final notesBox = _hiveService.notesBox;
    await notesBox.delete(noteId);
    loadNotes();
  }

  Future<void> togglePin(String noteId) async {
    final note = _hiveService.notesBox.get(noteId);
    if (note != null) {
      await updateNote(note.copyWith(isPinned: !note.isPinned));
    }
  }

  Future<void> toggleLock(String noteId) async {
    final note = _hiveService.notesBox.get(noteId);
    if (note != null) {
      await updateNote(note.copyWith(isLocked: !note.isLocked));
    }
  }

  Future<void> toggleArchive(String noteId) async {
    final note = _hiveService.notesBox.get(noteId);
    if (note != null) {
      await updateNote(note.copyWith(isArchived: !note.isArchived));
    }
  }

  Future<void> toggleFavorite(String noteId) async {
    final note = _hiveService.notesBox.get(noteId);
    if (note != null) {
      await updateNote(note.copyWith(isFavorite: !note.isFavorite));
    }
  }

  String generateId() => _uuid.v4();
}

// Filtered Notes Providers
final activeNotesProvider = Provider<List<NoteModel>>((ref) {
  final notes = ref.watch(notesProvider);
  return notes.where((note) => 
    !note.isArchived && 
    !note.isTimeCapsule
  ).toList()
    ..sort((a, b) {
      if (a.isPinned && !b.isPinned) return -1;
      if (!a.isPinned && b.isPinned) return 1;
      return b.updatedAt.compareTo(a.updatedAt);
    });
});

final lockedNotesProvider = Provider<List<NoteModel>>((ref) {
  final notes = ref.watch(notesProvider);
  return notes.where((note) => note.isLocked).toList()
    ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
});

final archivedNotesProvider = Provider<List<NoteModel>>((ref) {
  final notes = ref.watch(notesProvider);
  return notes.where((note) => note.isArchived).toList()
    ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
});

final timeCapsuleNotesProvider = Provider<List<NoteModel>>((ref) {
  final notes = ref.watch(notesProvider);
  return notes.where((note) => note.isTimeCapsule).toList()
    ..sort((a, b) => a.unlockDate!.compareTo(b.unlockDate!));
});

final favoriteNotesProvider = Provider<List<NoteModel>>((ref) {
  final notes = ref.watch(notesProvider);
  return notes.where((note) => note.isFavorite).toList()
    ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
});

// Search Provider
final searchQueryProvider = StateProvider<String>((ref) => '');

final searchResultsProvider = Provider<List<NoteModel>>((ref) {
  final notes = ref.watch(notesProvider);
  final query = ref.watch(searchQueryProvider).toLowerCase();
  
  if (query.isEmpty) return notes;
  
  return notes.where((note) {
    return note.title.toLowerCase().contains(query) ||
           note.content.toLowerCase().contains(query) ||
           note.tags.any((tag) => tag.toLowerCase().contains(query));
  }).toList()
    ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
});

// Tags Provider
final allTagsProvider = Provider<Set<String>>((ref) {
  final notes = ref.watch(notesProvider);
  final tags = <String>{};
  for (final note in notes) {
    tags.addAll(note.tags);
  }
  return tags;
});
