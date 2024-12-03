import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/view_model/todo/tl_workspaces_state.dart';
import '../../../model/tl_theme.dart';
import '../../../model/todo/tl_category.dart';
import '../../../model/workspace/tl_workspace.dart';
import 'category_chip/big_category_chip.dart';
import 'category_chip/small_category_chip.dart';

import 'package:reorderables/reorderables.dart';

class BigAndSmallCategoryCard extends ConsumerWidget {
  final int indexOfBigCategory;
  const BigAndSmallCategoryCard({
    super.key,
    required this.indexOfBigCategory,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeData tlThemeData = TLTheme.of(context);
    // provider
    final TLWorkspacesState tlWorkspacesState =
        ref.watch(tlWorkspacesStateProvider);
    final TLWorkspace currentTLWorkspace = tlWorkspacesState.currentWorkspace;

    final tlWorkspacesStateNotifier =
        ref.read(tlWorkspacesStateProvider.notifier);
    // others
    final TLCategory coorBigCategory =
        currentTLWorkspace.bigCategories[indexOfBigCategory];
    return Card(
      color: tlThemeData.panelColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
          // bigCategoryのchipを左寄せにするため
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // bigCategoryのChip
            BigCategoryChip(indexOfBigCategory: indexOfBigCategory),

            // --- bigCategoryを並び替えるときはReorderableColumnを非表示にする
            ReorderableColumn(
              children: [
                for (int i = 0;
                    i <
                        currentTLWorkspace
                            .smallCategories[coorBigCategory.id]!.length;
                    i++)
                  SmallCategoryChip(
                      key: ValueKey(currentTLWorkspace
                          .smallCategories[coorBigCategory.id]![i].id),
                      corrBigCategory: coorBigCategory,
                      corrIndexOfBigCategory: indexOfBigCategory,
                      corrIndexOfSmallCategory: i)
              ],
              // smallCategoryの並び替え
              onReorder: (oldIndex, newIndex) {
                if (oldIndex == newIndex) return;
                final Map<String, List<TLCategory>> corrSmallCategories = {
                  for (var entry in currentTLWorkspace.smallCategories.entries)
                    entry.key: List<TLCategory>.from(entry.value)
                };
                // 抜き出して
                TLCategory reOrderedSmallCategory =
                    corrSmallCategories[coorBigCategory.id]!.removeAt(oldIndex);
                // 入れる
                corrSmallCategories[coorBigCategory.id]!
                    .insert(newIndex, reOrderedSmallCategory);
                // categorisを保存する
                tlWorkspacesStateNotifier.updateCurrentWorkspace(
                  updatedCurrentWorkspace: currentTLWorkspace.copyWith(
                    smallCategories: corrSmallCategories,
                  ),
                );
              },
            )
          ]),
    );
  }
}
