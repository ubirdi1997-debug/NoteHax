import 'package:flutter_test/flutter_test.dart';
import 'package:notehax/models/note.dart';

void main() {
  group('Note Model', () {
    test('should create a note with all fields', () {
      final now = DateTime.now();
      final note = Note(
        id: 1,
        title: 'Test Note',
        content: 'Test Content',
        createdAt: now,
        updatedAt: now,
      );

      expect(note.id, 1);
      expect(note.title, 'Test Note');
      expect(note.content, 'Test Content');
      expect(note.createdAt, now);
      expect(note.updatedAt, now);
    });

    test('should convert note to map', () {
      final now = DateTime.now();
      final note = Note(
        id: 1,
        title: 'Test Note',
        content: 'Test Content',
        createdAt: now,
        updatedAt: now,
      );

      final map = note.toMap();

      expect(map['id'], 1);
      expect(map['title'], 'Test Note');
      expect(map['content'], 'Test Content');
      expect(map['createdAt'], now.toIso8601String());
      expect(map['updatedAt'], now.toIso8601String());
    });

    test('should create note from map', () {
      final now = DateTime.now();
      final map = {
        'id': 1,
        'title': 'Test Note',
        'content': 'Test Content',
        'createdAt': now.toIso8601String(),
        'updatedAt': now.toIso8601String(),
      };

      final note = Note.fromMap(map);

      expect(note.id, 1);
      expect(note.title, 'Test Note');
      expect(note.content, 'Test Content');
      expect(note.createdAt.toIso8601String(), now.toIso8601String());
      expect(note.updatedAt.toIso8601String(), now.toIso8601String());
    });

    test('should create a copy of note with updated fields', () {
      final now = DateTime.now();
      final note = Note(
        id: 1,
        title: 'Test Note',
        content: 'Test Content',
        createdAt: now,
        updatedAt: now,
      );

      final updatedNote = note.copyWith(title: 'Updated Title');

      expect(updatedNote.id, 1);
      expect(updatedNote.title, 'Updated Title');
      expect(updatedNote.content, 'Test Content');
      expect(updatedNote.createdAt, now);
      expect(updatedNote.updatedAt, now);
    });
  });
}
