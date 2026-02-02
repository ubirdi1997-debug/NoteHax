import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notehax/constants/app_constants.dart';
import 'package:notehax/models/note_model.dart';
import 'package:notehax/providers/notes_provider.dart';
import 'package:notehax/screens/note_editor_screen.dart';

class QuickHaxPanel extends ConsumerStatefulWidget {
  const QuickHaxPanel({super.key});

  @override
  ConsumerState<QuickHaxPanel> createState() => _QuickHaxPanelState();
}

class _QuickHaxPanelState extends ConsumerState<QuickHaxPanel>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: AnimationDurations.normal,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Options
        if (_isExpanded) ...[
          _buildOptionButton(
            icon: Icons.mic,
            label: 'Voice Note',
            color: AppColors.neonPurple,
            onTap: () => _createVoiceNote(),
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildOptionButton(
            icon: Icons.camera_alt,
            label: 'Scan Text',
            color: AppColors.neonGreen,
            onTap: () => _scanText(),
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildOptionButton(
            icon: Icons.content_paste,
            label: 'Paste',
            color: AppColors.neonBlue,
            onTap: () => _pasteFromClipboard(),
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildOptionButton(
            icon: Icons.checklist,
            label: 'Checklist',
            color: AppColors.warning,
            onTap: () => _createChecklist(),
          ),
          const SizedBox(height: AppSpacing.md),
        ],

        // Main FAB
        FloatingActionButton(
          onPressed: _isExpanded ? _toggle : _createNewNote,
          child: AnimatedRotation(
            turns: _isExpanded ? 0.125 : 0,
            duration: AnimationDurations.normal,
            child: Icon(_isExpanded ? Icons.close : Icons.add),
          ),
        ),

        // Quick menu button (appears when not expanded)
        if (!_isExpanded)
          Padding(
            padding: const EdgeInsets.only(top: AppSpacing.sm),
            child: FloatingActionButton.small(
              onPressed: _toggle,
              backgroundColor: AppColors.tertiaryDark,
              child: const Icon(Icons.apps, color: AppColors.neonBlue),
            ),
          ),
      ],
    );
  }

  Widget _buildOptionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: AppColors.tertiaryDark,
              borderRadius: AppBorderRadius.medium,
              border: Border.all(color: color),
            ),
            child: Text(
              label,
              style: AppTextStyles.bodySecondary.copyWith(color: color),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: color,
              borderRadius: AppBorderRadius.medium,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.5),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Icon(icon, color: Colors.black),
          ),
        ],
      ),
    );
  }

  void _createNewNote() {
    final notesNotifier = ref.read(notesProvider.notifier);
    final note = NoteModel(
      id: notesNotifier.generateId(),
      title: '',
      content: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NoteEditorScreen(note: note, isNew: true),
      ),
    );
    _toggle();
  }

  void _createVoiceNote() {
    // TODO: Implement voice to text feature
    // This will use speech_to_text package to convert voice to text
    // For now, opens a new note editor
    _createNewNote();
    _toggle();
  }

  void _scanText() {
    // TODO: Implement OCR scanning feature
    // This will use google_mlkit_text_recognition to scan text from camera
    // For now, opens a new note editor
    _createNewNote();
    _toggle();
  }

  void _pasteFromClipboard() {
    // TODO: Implement clipboard paste feature
    // This will read from system clipboard and create a note with that content
    // For now, opens a new note editor
    _createNewNote();
    _toggle();
  }

  void _createChecklist() {
    final notesNotifier = ref.read(notesProvider.notifier);
    final note = NoteModel(
      id: notesNotifier.generateId(),
      title: 'New Checklist',
      content: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      isChecklist: true,
      checklistItems: [],
    );
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NoteEditorScreen(note: note, isNew: true),
      ),
    );
    _toggle();
  }
}
