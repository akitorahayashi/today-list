import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:today_list/model/todo/tl_category.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/action/todo/tl_workspace_action.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
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
    final TLThemeConfig tlThemeData = TLTheme.of(context);
    final currentWorkspace = ref.watch(
      tlAppStateProvider
          .select((state) => state.tlWorkspaces[state.currentWorkspaceIndex]),
    );

    final coorBigCategory = currentWorkspace.bigCategories[indexOfBigCategory];

    return Card(
      color: tlThemeData.panelColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigCategoryChip(indexOfBigCategory: indexOfBigCategory),
          _buildSmallCategoryList(ref, currentWorkspace, coorBigCategory),
        ],
      ),
    );
  }

  // MARK - Small Category List
  Widget _buildSmallCategoryList(
      WidgetRef ref, TLWorkspace currentWorkspace, TLCategory coorBigCategory) {
    final smallCategories =
        currentWorkspace.smallCategories[coorBigCategory.id] ?? [];

    return ReorderableColumn(
      children: [
        for (int i = 0; i < smallCategories.length; i++)
          SmallCategoryChip(
            key: ValueKey(smallCategories[i].id),
            corrBigCategory: coorBigCategory,
            corrIndexOfBigCategory: indexOfBigCategory,
            corrIndexOfSmallCategory: i,
          ),
      ],
      onReorder: (oldIndex, newIndex) {
        _handleSmallCategoryReorder(
            ref, currentWorkspace, coorBigCategory, oldIndex, newIndex);
      },
    );
  }

  // MARK - Handle Small Category Reorder Logic
  void _handleSmallCategoryReorder(WidgetRef ref, TLWorkspace currentWorkspace,
      TLCategory coorBigCategory, int oldIndex, int newIndex) {
    if (oldIndex == newIndex) return;

    final tlAppStateReducer = ref.read(tlAppStateProvider.notifier);

    final copiedSmallCategories = {
      for (var entry in currentWorkspace.smallCategories.entries)
        entry.key: List<TLCategory>.from(entry.value),
    };

    // 並び替え処理
    final TLCategory reOrderedSmallCategory =
        copiedSmallCategories[coorBigCategory.id]!.removeAt(oldIndex);
    copiedSmallCategories[coorBigCategory.id]!
        .insert(newIndex, reOrderedSmallCategory);

    // 状態を更新
    tlAppStateReducer.dispatchWorkspaceAction(
      TLWorkspaceAction.updateCurrentWorkspace(
        currentWorkspace.copyWith(smallCategories: copiedSmallCategories),
      ),
    );
  }
}
