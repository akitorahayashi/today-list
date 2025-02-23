import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:today_list/model/todo/tl_todo_category.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/action/tl_app_state_action.dart';
import 'package:today_list/redux/action/tl_todo_category_action.dart';
import 'package:today_list/redux/action/tl_workspace_action.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'category_card/big_category_chip.dart';
import 'category_card/small_category_chip.dart';
import 'package:reorderables/reorderables.dart';

class BigAndSmallCategoryCard extends ConsumerWidget {
  final TLWorkspace corrWorkspace;
  final TLToDoCategory corrBigCategory;

  const BigAndSmallCategoryCard({
    super.key,
    required this.corrWorkspace,
    required this.corrBigCategory,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeConfig tlThemeData = TLTheme.of(context);

    return Card(
      color: tlThemeData.canTapCardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BigCategoryCard(
                corrWorkspace: corrWorkspace, corrBigCategory: corrBigCategory),
            _SmallCategoryList(
              corrWorkspace: corrWorkspace,
              coorBigCategory: corrBigCategory,
            ),
          ],
        ),
      ),
    );
  }
}

class _SmallCategoryList extends ConsumerWidget {
  final TLWorkspace corrWorkspace;
  final TLToDoCategory coorBigCategory;

  const _SmallCategoryList({
    required this.corrWorkspace,
    required this.coorBigCategory,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final smallCategories =
        corrWorkspace.smallCategories[coorBigCategory.id] ?? [];

    return ReorderableColumn(
      children: [
        for (int i = 0; i < smallCategories.length; i++)
          SmallCategoryChip(
            key: ValueKey(smallCategories[i].id),
            corrWorkspace: corrWorkspace,
            corrSmallCategory: smallCategories[i],
          ),
      ],
      onReorder: (oldIndex, newIndex) {
        ref.read(tlAppStateProvider.notifier).updateState(
              TLToDoCategoryAction.reorderSmallCategory(
                corrWorkspace: corrWorkspace,
                bigCategory: coorBigCategory,
                oldIndex: oldIndex,
                newIndex: newIndex,
              ),
            );
      },
    );
  }
}
