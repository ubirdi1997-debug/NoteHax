import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notehax/constants/app_constants.dart';
import 'package:notehax/models/note_model.dart';
import 'package:notehax/providers/notes_provider.dart';
import 'package:notehax/screens/note_editor_screen.dart';
import 'package:notehax/screens/search_screen.dart';
import 'package:notehax/screens/settings_screen.dart';
import 'package:notehax/widgets/common/note_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool _isGridView = true;

  @override
  Widget build(BuildContext context) {
    final notes = ref.watch(activeNotesProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            floating: true,
            snap: true,
            elevation: 0,
            backgroundColor: AppColors.primaryDark,
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.neonBlue,
                        AppColors.neonGreen,
                      ],
                    ),
                    borderRadius: AppBorderRadius.small,
                  ),
                  child: Text(
                    AppConstants.appName,
                    style: AppTextStyles.heading3.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              // Toggle View
              IconButton(
                icon: Icon(
                  _isGridView ? Icons.view_list : Icons.grid_view,
                ),
                onPressed: () {
                  setState(() {
                    _isGridView = !_isGridView;
                  });
                },
              ),
              // Search
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchScreen(),
                    ),
                  );
                },
              ),
              // Settings
              IconButton(
                icon: const Icon(Icons.settings_outlined),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsScreen(),
                    ),
                  );
                },
              ),
            ],
          ),

          // Notes List
          notes.isEmpty
              ? SliverFillRemaining(
                  child: _buildEmptyState(),
                )
              : _isGridView
                  ? SliverPadding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      sliver: SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.85,
                          crossAxisSpacing: AppSpacing.sm,
                          mainAxisSpacing: AppSpacing.sm,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final note = notes[index];
                            return NoteCard(
                              note: note,
                              onTap: () => _openNote(note),
                            );
                          },
                          childCount: notes.length,
                        ),
                      ),
                    )
                  : SliverPadding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final note = notes[index];
                            return Padding(
                              padding: const EdgeInsets.only(
                                bottom: AppSpacing.sm,
                              ),
                              child: NoteCard(
                                note: note,
                                onTap: () => _openNote(note),
                                isListView: true,
                              ),
                            );
                          },
                          childCount: notes.length,
                        ),
                      ),
                    ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewNote,
        child: const Icon(Icons.add),
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
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.note_add_outlined,
            size: 80,
            color: AppColors.neonBlue.withOpacity(0.5),
          ),
          const SizedBox(height: AppSpacing.lg),
          const Text(
            'No Notes Yet',
            style: AppTextStyles.heading2,
          ),
          const SizedBox(height: AppSpacing.sm),
          const Text(
            'Tap the + button to create your first note',
            style: AppTextStyles.bodySecondary,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _openNote(NoteModel note) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NoteEditorScreen(note: note),
      ),
    );
  }
}
