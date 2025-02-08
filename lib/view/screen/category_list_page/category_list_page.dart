import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:today_list/model/todo/tl_category.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/action/todo/tl_workspace_action.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/resource/initial_tl_workspaces.dart';
import 'package:today_list/view/component/common_ui_part/tl_sliver_appbar.dart';
import 'package:today_list/view/component/dialog/for_category/add_category_dialog.dart';
import 'big_and_small_category_card/big_and_small_category_card.dart';
import 'package:reorderables/reorderables.dart';

class CategoryListPage extends ConsumerWidget {
  const CategoryListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeConfig tlThemeData = TLTheme.of(context);
    final currentWorkspace = ref.watch(tlAppStateProvider
        .select((state) => state.tlWorkspaces[state.currentWorkspaceIndex]));

    return Scaffold(
      body: Stack(
        children: [
          Container(color: tlThemeData.backgroundColor),
          CustomScrollView(
            slivers: [
              _buildAppBar(context),
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
          _buildAddCategoryButton(context, tlThemeData),
        ],
      ),
    );
  }

  // MARK - AppBar
  Widget _buildAppBar(BuildContext context) {
    return TLSliverAppBar(
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
        for (int i = 0; i < currentWorkspace.bigCategories.length; i++)
          GestureDetector(
            key: ValueKey(currentWorkspace.bigCategories[i].id),
            onLongPress:
                currentWorkspace.bigCategories[i].id != noneID ? null : () {},
            child: BigAndSmallCategoryCard(indexOfBigCategory: i),
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
        List<TLCategory>.from(currentWorkspace.bigCategories);

    // 並び替え処理
    final TLCategory reOrderedBigCategory =
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
  Widget _buildAddCategoryButton(
      BuildContext context, TLThemeConfig tlThemeData) {
    return Positioned(
      right: 50,
      bottom: 70,
      child: GestureDetector(
        onTap: () => const AddCategoryDialog().show(context: context),
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
