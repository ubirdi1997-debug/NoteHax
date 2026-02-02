import 'package:flutter/material.dart';
import 'package:notehax/models/note.dart';
import 'package:notehax/services/database_service.dart';

class NoteEditorScreen extends StatefulWidget {
  final Note? note;

  const NoteEditorScreen({super.key, this.note});

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final DatabaseService _databaseService = DatabaseService.instance;
  bool _isModified = false;

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
    }
    _titleController.addListener(_onTextChanged);
    _contentController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    if (!_isModified) {
      setState(() => _isModified = true);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _saveNote() async {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (title.isEmpty && content.isEmpty) {
      Navigator.pop(context);
      return;
    }

    final now = DateTime.now();

    if (widget.note == null) {
      // Create new note
      final note = Note(
        title: title.isEmpty ? 'Untitled' : title,
        content: content,
        createdAt: now,
        updatedAt: now,
      );
      await _databaseService.createNote(note);
    } else {
      // Update existing note
      final note = widget.note!.copyWith(
        title: title.isEmpty ? 'Untitled' : title,
        content: content,
        updatedAt: now,
      );
      await _databaseService.updateNote(note);
    }

    if (mounted) {
      Navigator.pop(context);
    }
  }

  Future<void> _handlePopInvoked(bool didPop) async {
    if (didPop) return;
    
    if (_isModified) {
      final shouldSave = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Save Changes?'),
          content: const Text('Do you want to save your changes?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Discard'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Save'),
            ),
          ],
        ),
      );

      if (shouldSave == true) {
        await _saveNote();
      }
      
      if (shouldSave != null && mounted) {
        Navigator.pop(context);
      }
    } else {
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_isModified,
      onPopInvoked: _handlePopInvoked,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.note == null ? 'New Note' : 'Edit Note'),
          actions: [
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: _saveNote,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: 'Title',
                  border: InputBorder.none,
                ),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
              ),
              const Divider(),
              Expanded(
                child: TextField(
                  controller: _contentController,
                  decoration: const InputDecoration(
                    hintText: 'Start typing...',
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(fontSize: 16),
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
