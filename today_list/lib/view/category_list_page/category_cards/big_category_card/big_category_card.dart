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

class BigCategoryCard extends ConsumerWidget {
  final int indexOfBigCategory;
  const BigCategoryCard({
    super.key,
    required this.indexOfBigCategory,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeData _tlThemeData = TLTheme.of(context);
    // provider
    final TLWorkspace _currentTLWorkspace =
        ref.watch(currentTLWorkspaceProvider);
    final TLWorkspacesNotifier _tlWorkspacesNotifier =
        ref.read(tlWorkspacesProvider.notifier);
    // notifier
    final CurrentTLWorkspaceNotifier _currentWorkspaceNotifier =
        ref.read(currentTLWorkspaceProvider.notifier);
    // others
    final TLCategory _coorBigCategory =
        _currentTLWorkspace.bigCategories[indexOfBigCategory];
    return Card(
      color: _tlThemeData.panelColor,
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
                        _currentTLWorkspace
                            .smallCategories[_coorBigCategory.id]!.length;
                    i++)
                  SmallCategoryCard(
                      key: ValueKey(_currentTLWorkspace
                          .smallCategories[_coorBigCategory.id]![i].id),
                      corrBigCategoryID: _coorBigCategory.id,
                      corrIndexOfSmallCategory: i)
              ],
              // smallCategoryの並び替え
              onReorder: (oldIndex, newIndex) {
                if (oldIndex == newIndex) return;
                // 抜き出して
                TLCategory reOrderedSmallCategory = _currentTLWorkspace
                    .smallCategories[_coorBigCategory.id]!
                    .removeAt(oldIndex);
                if (oldIndex < newIndex) newIndex--;
                // 入れる
                _currentTLWorkspace.smallCategories[_coorBigCategory.id]!
                    .insert(newIndex, reOrderedSmallCategory);
                // categorisを保存する
                _tlWorkspacesNotifier.updateSpecificTLWorkspace(
                  specificWorkspaceIndex:
                      _currentWorkspaceNotifier.currentTLWorkspaceIndex,
                  updatedWorkspace: _currentTLWorkspace,
                );
              },
            )
          ]),
    );
  }
}
