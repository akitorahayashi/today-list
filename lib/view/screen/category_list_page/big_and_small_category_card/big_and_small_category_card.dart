import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:today_list/model/todo/tl_todo_category.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/action/tl_workspace_action.dart';
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
      tlAppStateProvider.select((state) => state.getCurrentWorkspace),
    );

    final coorBigCategory = currentWorkspace.bigCategories[indexOfBigCategory];

    return Card(
      color: tlThemeData.canTapCardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigCategoryChip(indexOfBigCategory: indexOfBigCategory),
          _SmallCategoryList(
            ref: ref,
            currentWorkspace: currentWorkspace,
            coorBigCategory: coorBigCategory,
          ),
        ],
      ),
    );
  }
}

class _SmallCategoryList extends StatelessWidget {
  final WidgetRef ref;
  final TLWorkspace currentWorkspace;
  final TLToDoCategory coorBigCategory;

  const _SmallCategoryList({
    required this.ref,
    required this.currentWorkspace,
    required this.coorBigCategory,
  });

  @override
  Widget build(BuildContext context) {
    final smallCategories =
        currentWorkspace.smallCategories[coorBigCategory.id] ?? [];

    return ReorderableColumn(
      children: [
        for (int i = 0; i < smallCategories.length; i++)
          SmallCategoryChip(
            key: ValueKey(smallCategories[i].id),
            corrSmallCategory: smallCategories[i],
          ),
      ],
      onReorder: (oldIndex, newIndex) {
        _handleSmallCategoryReorder(
            ref, currentWorkspace, coorBigCategory, oldIndex, newIndex);
      },
    );
  }

  void _handleSmallCategoryReorder(WidgetRef ref, TLWorkspace currentWorkspace,
      TLToDoCategory coorBigCategory, int oldIndex, int newIndex) {
    if (oldIndex == newIndex) return;

    final tlAppStateReducer = ref.read(tlAppStateProvider.notifier);

    final copiedSmallCategories = {
      for (var entry in currentWorkspace.smallCategories.entries)
        entry.key: List<TLToDoCategory>.from(entry.value),
    };

    // 並び替え処理
    final TLToDoCategory reOrderedSmallCategory =
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
