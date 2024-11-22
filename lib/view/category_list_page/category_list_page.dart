import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/component/dialog/for_category/add_category_dialog.dart';
import 'package:today_list/model/workspace/provider/tl_workspaces_provider.dart';
import '../../model/workspace/provider/current_tl_workspace_provider.dart';
import '../../component/common_ui_part/tl_sliver_appbar.dart';
import '../../model/workspace/tl_workspace.dart';
import '../../model/todo/tl_category.dart';
import '../../model/tl_theme.dart';
import 'big_and_small_category_card/big_and_small_category_card.dart';
import 'add_category_button.dart';

import 'package:reorderables/reorderables.dart';

class CategoryListPage extends ConsumerWidget {
  const CategoryListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeData tlThemeData = TLTheme.of(context);
    // provider
    final TLWorkspace currentTLWorkspace = ref.watch(currentWorkspaceProvider);
    // notifier
    final TLWorkspacesNotifier tlWorkspacesNotifier =
        ref.read(tlWorkspacesProvider.notifier);
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
                        i < currentTLWorkspace.bigCategories.length;
                        i++)
                      GestureDetector(
                        key: ValueKey(currentTLWorkspace.bigCategories[i].id),
                        onLongPress:
                            currentTLWorkspace.bigCategories[i].id != noneID
                                ? null
                                : () {},
                        child: BigAndSmallCategoryCard(indexOfBigCategory: i),
                      ),
                  ],
                  onReorder: (oldIndex, newIndex) {
                    if (newIndex == 0) return;
                    final corrBigCategories =
                        List<TLCategory>.from(currentTLWorkspace.bigCategories);
                    // 抜き出して
                    TLCategory reOrderedBigCategory =
                        corrBigCategories.removeAt(oldIndex);
                    corrBigCategories.insert(newIndex, reOrderedBigCategory);
                    // categoriesを保存する
                    tlWorkspacesNotifier.updateCurrentWorkspace(
                        updatedWorkspace: currentTLWorkspace.copyWith(
                            bigCategories: corrBigCategories));
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
