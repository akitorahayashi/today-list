import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/model/todo/tl_category.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/action/todo/tl_workspace_action.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/resource/initial_tl_workspaces.dart';
import 'package:today_list/view/component/common_ui_part/tl_sliver_appbar.dart';
import 'package:today_list/view/component/dialog/for_category/add_category_dialog.dart';
import 'big_and_small_category_card/big_and_small_category_card.dart';
import 'add_category_button.dart';

import 'package:reorderables/reorderables.dart';

class CategoryListPage extends ConsumerWidget {
  const CategoryListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeData tlThemeData = TLTheme.of(context);
    // provider
    final tlAppState = ref.watch(tlAppStateProvider);
    // notifier
    final tlAppStateReducer = ref.read(tlAppStateProvider.notifier);
    // others
    final TLWorkspace currentWorkspaceReference =
        tlAppState.tlWorkspaces[tlAppState.currentWorkspaceIndex].copyWith();
    return Scaffold(
      body: Stack(children: [
        // 背景色
        Container(
            decoration: BoxDecoration(color: tlThemeData.backgroundColor),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height),
        CustomScrollView(
          slivers: [
            // AppBar
            TLSliverAppBar(
                pageTitle: "Category List",
                // ホームに戻るボタン
                leadingButtonOnPressed: () {
                  Navigator.pop(context);
                },
                leadingIcon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                trailingButtonOnPressed: null,
                trailingIcon: null),
            SliverList(
                delegate: SliverChildListDelegate([
              const SizedBox(
                height: 5,
              ),
              // BigCategoryのリスト
              ReorderableColumn(
                  children: [
                    // bigCategoryがなしではない場合、bigCategoryの並び替え可能カードを表示する
                    for (int i = 0;
                        i < currentWorkspaceReference.bigCategories.length;
                        i++)
                      GestureDetector(
                        key: ValueKey(
                            currentWorkspaceReference.bigCategories[i].id),
                        onLongPress:
                            currentWorkspaceReference.bigCategories[i].id !=
                                    noneID
                                ? null
                                : () {},
                        child: BigAndSmallCategoryCard(indexOfBigCategory: i),
                      ),
                  ],
                  onReorder: (oldIndex, newIndex) {
                    if (newIndex == 0) return;
                    final copiedBigCategories = List<TLCategory>.from(
                        currentWorkspaceReference.bigCategories);
                    // operation
                    TLCategory reOrderedBigCategory =
                        copiedBigCategories.removeAt(oldIndex);
                    copiedBigCategories.insert(newIndex, reOrderedBigCategory);
                    // categoriesを保存する
                    tlAppStateReducer.dispatchWorkspaceAction(
                        TLWorkspaceAction.updateCurrentWorkspace(
                            currentWorkspaceReference.copyWith(
                                bigCategories: copiedBigCategories)));
                  }),
              const SizedBox(
                height: 300,
              )
            ])),
          ],
        ),
        // カテゴリー追加ボタンとカード
        Positioned(
            right: 50,
            bottom: 70,
            child: AddCategoryButton(
                onTap: () => const AddCategoryDialog().show(context: context))),
      ]),
    );
  }
}
