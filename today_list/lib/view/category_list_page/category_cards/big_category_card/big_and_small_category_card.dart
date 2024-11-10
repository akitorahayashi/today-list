import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/provider/current_tl_workspace_provider.dart';
import '../../../../model/design/tl_theme.dart';
import '../../../../model/todo/tl_category.dart';
import '../../../../model/tl_workspace.dart';
import '../../../../model/provider/tl_workspaces_provider.dart';
import './big_category_chip.dart';
import '../small_category_card.dart';

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
    final TLWorkspace currentTLWorkspace = ref.watch(currentWorkspaceProvider);
    final TLWorkspacesNotifier tlWorkspacesNotifier =
        ref.read(tlWorkspacesProvider.notifier);
    // notifier
    ref.read(currentWorkspaceProvider.notifier);
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
                  SmallCategoryCard(
                      key: ValueKey(currentTLWorkspace
                          .smallCategories[coorBigCategory.id]![i].id),
                      corrBigCategory: coorBigCategory,
                      corrIndexOfBigCategory: i,
                      corrIndexOfSmallCategory: i)
              ],
              // smallCategoryの並び替え
              onReorder: (oldIndex, newIndex) {
                if (oldIndex == newIndex) return;
                // 抜き出して
                TLCategory reOrderedSmallCategory = currentTLWorkspace
                    .smallCategories[coorBigCategory.id]!
                    .removeAt(oldIndex);
                if (oldIndex < newIndex) newIndex--;
                // 入れる
                currentTLWorkspace.smallCategories[coorBigCategory.id]!
                    .insert(newIndex, reOrderedSmallCategory);
                // categorisを保存する
                tlWorkspacesNotifier.updateCurrentWorkspace(
                  updatedWorkspace: currentTLWorkspace,
                );
              },
            )
          ]),
    );
  }
}
