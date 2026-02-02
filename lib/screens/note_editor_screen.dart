import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notehax/constants/app_constants.dart';
import 'package:notehax/models/note_model.dart';
import 'package:notehax/providers/notes_provider.dart';
import 'package:notehax/utils/smart_detection.dart';

class NoteEditorScreen extends ConsumerStatefulWidget {
  final NoteModel note;
  final bool isNew;

  const NoteEditorScreen({
    super.key,
    required this.note,
    this.isNew = false,
  });

  @override
  ConsumerState<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends ConsumerState<NoteEditorScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  bool _hasChanges = false;
  List<String> _detectedTags = [];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _contentController = TextEditingController(text: widget.note.content);
    
    _titleController.addListener(_onTextChanged);
    _contentController.addListener(_onTextChanged);
    _extractTags();
  }

  void _onTextChanged() {
    if (!_hasChanges) {
      setState(() => _hasChanges = true);
    }
    _extractTags();
  }

  void _extractTags() {
    final content = _contentController.text;
    final hashtags = SmartDetection.detectHashtags(content);
    setState(() {
      _detectedTags = hashtags;
    });
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

    if (title.isEmpty && content.isEmpty && widget.isNew) {
      Navigator.pop(context);
      return;
    }

    final updatedNote = widget.note.copyWith(
      title: title.isEmpty ? 'Untitled' : title,
      content: content,
      updatedAt: DateTime.now(),
      tags: _detectedTags,
    );

    if (widget.isNew) {
      await ref.read(notesProvider.notifier).createNote(updatedNote);
    } else {
      await ref.read(notesProvider.notifier).updateNote(updatedNote);
    }

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_hasChanges,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        
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
        
        if (mounted && shouldSave != null) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.isNew ? 'New Note' : 'Edit Note'),
          actions: [
            // Pin
            IconButton(
              icon: Icon(
                widget.note.isPinned ? Icons.push_pin : Icons.push_pin_outlined,
              ),
              onPressed: () {
                setState(() {
                  // Note: This will be properly handled through the provider
                });
              },
            ),
            // Save
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: _saveNote,
            ),
            // More options
            PopupMenuButton(
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'lock',
                  child: Row(
                    children: [
                      Icon(Icons.lock_outline),
                      SizedBox(width: 8),
                      Text('Lock Note'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'color',
                  child: Row(
                    children: [
                      Icon(Icons.palette_outlined),
                      SizedBox(width: 8),
                      Text('Change Color'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'reminder',
                  child: Row(
                    children: [
                      Icon(Icons.alarm),
                      SizedBox(width: 8),
                      Text('Set Reminder'),
                    ],
                  ),
                ),
                if (!widget.isNew)
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete_outline, color: AppColors.error),
                        SizedBox(width: 8),
                        Text('Delete', style: TextStyle(color: AppColors.error)),
                      ],
                    ),
                  ),
              ],
              onSelected: (value) => _handleMenuAction(value as String),
            ),
          ],
        ),
        body: Column(
          children: [
            // Tags display
            if (_detectedTags.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _detectedTags.map((tag) {
                    return Chip(
                      label: Text(tag),
                      backgroundColor: AppColors.neonBlue.withOpacity(0.2),
                      labelStyle: TextStyle(color: AppColors.neonBlue),
                      deleteIcon: const Icon(
                        Icons.close,
                        size: 16,
                        color: AppColors.neonBlue,
                      ),
                      onDeleted: () {
                        // Remove tag from content
                        final content = _contentController.text.replaceAll(tag, '');
                        _contentController.text = content;
                      },
                    );
                  }).toList(),
                ),
              ),
            
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    TextField(
                      controller: _titleController,
                      style: AppTextStyles.heading2,
                      decoration: InputDecoration(
                        hintText: 'Title',
                        border: InputBorder.none,
                        filled: false,
                        hintStyle: AppTextStyles.heading2.copyWith(
                          color: AppColors.textTertiary,
                        ),
                      ),
                      maxLines: null,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    // Content
                    TextField(
                      controller: _contentController,
                      style: AppTextStyles.body,
                      decoration: InputDecoration(
                        hintText: 'Start typing...',
                        border: InputBorder.none,
                        filled: false,
                        hintStyle: AppTextStyles.body.copyWith(
                          color: AppColors.textTertiary,
                        ),
                      ),
                      maxLines: null,
                      minLines: 10,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleMenuAction(String action) {
    switch (action) {
      case 'lock':
        // TODO: Implement lock functionality with biometric/PIN authentication
        // This will require user to set up security first, then lock/unlock notes
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Lock feature coming soon! Set up security in Settings first.'),
          ),
        );
        break;
      case 'color':
        _showColorPicker();
        break;
      case 'reminder':
        // TODO: Implement reminder with flutter_local_notifications
        // This will allow setting date/time and schedule notifications
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Reminder feature coming soon!'),
          ),
        );
        break;
      case 'delete':
        _confirmDelete();
        break;
    }
  }

  void _showColorPicker() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Color'),
        content: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: AppColors.noteColors.map((color) {
            return GestureDetector(
              onTap: () {
                // Update note color
                Navigator.pop(context);
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: AppBorderRadius.small,
                  border: Border.all(color: AppColors.borderColor),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Note?'),
        content: const Text('This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await ref.read(notesProvider.notifier).deleteNote(widget.note.id);
              if (mounted) {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Close editor
              }
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}
