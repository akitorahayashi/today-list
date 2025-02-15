import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:today_list/model/tl_app_state.dart';
import 'package:today_list/model/todo/tl_todo_category.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/action/tl_workspace_action.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/view/component/common_ui_part/tl_appbar.dart';
import 'package:today_list/view/component/dialog/for_category/add_category_dialog.dart';
import 'big_and_small_category_card/big_and_small_category_card.dart';
import 'package:reorderables/reorderables.dart';

class CategoryListPage extends ConsumerWidget {
  const CategoryListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeConfig tlThemeData = TLTheme.of(context);
    final currentWorkspace = ref
        .watch(tlAppStateProvider.select((state) => state.getCurrentWorkspace));

    return Scaffold(
      appBar: _buildAppBar(context),
      body: Stack(
        children: [
          Container(color: tlThemeData.backgroundColor),
          CustomScrollView(
            slivers: [
              // カテゴリーのリスト
              SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: 5),
                  _buildReorderableCategories(ref, currentWorkspace),
                  const SizedBox(height: 200),
                ]),
              ),
            ],
          ),
          _buildAddCategoryButton(context, currentWorkspace, tlThemeData),
        ],
      ),
    );
  }

  // MARK - AppBar
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return TLAppBar(
      context: context,
      pageTitle: "Category List",
      leadingButtonOnPressed: () => Navigator.pop(context),
      leadingIcon: const Icon(Icons.arrow_back_ios, color: Colors.white),
      trailingButtonOnPressed: null,
      trailingIcon: null,
    );
  }

  // MARK - Reorderable Category List
  Widget _buildReorderableCategories(
      WidgetRef ref, TLWorkspace currentWorkspace) {
    return ReorderableColumn(
      children: [
        for (TLToDoCategory bigCategory in currentWorkspace.bigCategories)
          GestureDetector(
            key: ValueKey(bigCategory.id),
            onLongPress: bigCategory.id != noneID ? null : () {},
            child: BigAndSmallCategoryCard(corrBigCategory: bigCategory),
          ),
      ],
      onReorder: (oldIndex, newIndex) {
        _handleReorder(ref, currentWorkspace, oldIndex, newIndex);
      },
    );
  }

  // MARK - Handle Reorder Logic
  void _handleReorder(
      WidgetRef ref, TLWorkspace currentWorkspace, int oldIndex, int newIndex) {
    if (newIndex == 0) return;

    final tlAppStateReducer = ref.read(tlAppStateProvider.notifier);
    final copiedBigCategories =
        List<TLToDoCategory>.from(currentWorkspace.bigCategories);

    // 並び替え処理
    final TLToDoCategory reOrderedBigCategory =
        copiedBigCategories.removeAt(oldIndex);
    copiedBigCategories.insert(newIndex, reOrderedBigCategory);

    // 状態を更新
    tlAppStateReducer.dispatchWorkspaceAction(
      TLWorkspaceAction.updateCurrentWorkspace(
        currentWorkspace.copyWith(bigCategories: copiedBigCategories),
      ),
    );
  }

  // MARK - Add Category Button
  Widget _buildAddCategoryButton(BuildContext context,
      TLWorkspace currentWorkspace, TLThemeConfig tlThemeData) {
    return Positioned(
      right: 50,
      bottom: 70,
      child: GestureDetector(
        onTap: () => AddCategoryDialog(currentWorkspace: currentWorkspace).show(
          context: context,
        ),
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(color: Colors.black26, width: 2),
          ),
          child: ClipOval(
            child: Icon(
              Icons.add,
              color: tlThemeData.accentColor,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
}
