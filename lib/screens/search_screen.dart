import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notehax/constants/app_constants.dart';
import 'package:notehax/providers/notes_provider.dart';
import 'package:notehax/screens/note_editor_screen.dart';
import 'package:notehax/widgets/common/note_card.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchResults = ref.watch(searchResultsProvider);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autofocus: true,
          style: AppTextStyles.body,
          decoration: InputDecoration(
            hintText: 'Search notes...',
            border: InputBorder.none,
            filled: false,
            hintStyle: AppTextStyles.body.copyWith(
              color: AppColors.textTertiary,
            ),
          ),
          onChanged: (value) {
            ref.read(searchQueryProvider.notifier).state = value;
          },
        ),
      ),
      body: searchResults.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.search,
                    size: 64,
                    color: AppColors.textTertiary,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    _searchController.text.isEmpty
                        ? 'Start typing to search'
                        : 'No results found',
                    style: AppTextStyles.bodySecondary,
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(AppSpacing.md),
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final note = searchResults[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: NoteCard(
                    note: note,
                    isListView: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NoteEditorScreen(note: note),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
