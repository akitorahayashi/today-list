import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/provider/tl_workspaces_provider.dart';
import '../../model/provider/current_tl_workspace_provider.dart';
import '../../components/common_ui_part/tl_sliver_appbar.dart';
import '../../model/tl_workspace.dart';
import '../../model/todo/tl_category.dart';
import '../../model/design/tl_theme.dart';
import 'category_cards/big_category_card/big_category_card.dart';
import 'add_category_component/add_category_button.dart';
import 'add_category_component/add_category_sheet.dart';

import 'package:reorderables/reorderables.dart';

class CategoryListPage extends ConsumerWidget {
  const CategoryListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeData tlThemeData = TLTheme.of(context);
    // provider
    final TLWorkspace currentTLWorkspace = ref.watch(currentWorkspaceProvider);
    // notifier
    final CurrentTLWorkspaceNotifier currentWorkspaceNotifier =
        ref.read(currentWorkspaceProvider.notifier);
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
                        child: BigCategoryCard(indexOfBigCategory: i),
                      ),
                  ],
                  onReorder: (oldIndex, newIndex) {
                    if (newIndex == 0) return;
                    // 抜き出して
                    TLCategory reOrderedBigCategory =
                        currentTLWorkspace.bigCategories.removeAt(oldIndex);
                    currentTLWorkspace.bigCategories
                        .insert(newIndex, reOrderedBigCategory);
                    // categoriesを保存する
                    tlWorkspacesNotifier.updateSpecificTLWorkspace(
                        specificWorkspaceIndex:
                            currentWorkspaceNotifier.currentTLWorkspaceIndex,
                        updatedWorkspace: currentTLWorkspace);
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
            onTap: () => showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return const AddCategorySheet();
                }),
          ),
        ),
      ]),
    );
  }
}
