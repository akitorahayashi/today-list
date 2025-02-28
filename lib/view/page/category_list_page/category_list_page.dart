import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/view/component/common_ui_part/tl_circular_action_button.dart';
import 'package:today_list/view/component/common_ui_part/tl_appbar.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/model/design/tl_theme_config.dart';
import 'package:today_list/model/todo/tl_todo_category.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/action/tl_todo_category_action.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/view/component/sheet/show_add_category_sheet.dart';
import 'big_and_small_category_card/big_and_small_category_card.dart';

import 'package:reorderables/reorderables.dart';

class CategoryListPage extends ConsumerWidget {
  final String corrWorkspaceID;
  const CategoryListPage({
    super.key,
    required this.corrWorkspaceID,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeConfig tlThemeData = TLTheme.of(context);
    final corrWorkspace = ref.watch(tlAppStateProvider.select((state) =>
        state.tlWorkspaces.firstWhere((w) => w.id == corrWorkspaceID)));

    return Scaffold(
      appBar: TLAppBar(
        context: context,
        pageTitle: "Category List",
        leadingButtonOnPressed: () => Navigator.pop(context),
        leadingIconData: Icons.arrow_back_ios,
        trailingButtonOnPressed: null,
        trailingIconData: null,
      ),
      body: Stack(
        children: [
          Container(color: tlThemeData.backgroundColor),
          CustomScrollView(
            slivers: [
              // カテゴリーのリスト
              SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: 5),
                  ReorderableColumn(
                    children: [
                      for (TLToDoCategory bigCategory
                          in corrWorkspace.bigCategories)
                        GestureDetector(
                          key: ValueKey(bigCategory.id),
                          onLongPress:
                              bigCategory.id != corrWorkspace.id ? null : () {},
                          child: BigAndSmallCategoryCard(
                              corrWorkspace: corrWorkspace,
                              corrBigCategory: bigCategory),
                        ),
                    ],
                    onReorder: (oldIndex, newIndex) =>
                        ref.read(tlAppStateProvider.notifier).updateState(
                              TLToDoCategoryAction.reorderBigCategory(
                                corrWorkspace: corrWorkspace,
                                oldIndex: oldIndex,
                                newIndex: newIndex,
                              ),
                            ),
                  ),
                  const SizedBox(height: 200),
                ]),
              ),
            ],
          ),
          _AddToDoCategoryButton(
              corrWorkspace: corrWorkspace, tlThemeDataConfig: tlThemeData),
        ],
      ),
    );
  }
}

class _AddToDoCategoryButton extends ConsumerWidget {
  final TLWorkspace corrWorkspace;
  final TLThemeConfig tlThemeDataConfig;

  const _AddToDoCategoryButton({
    required this.corrWorkspace,
    required this.tlThemeDataConfig,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Positioned(
      right: 50,
      bottom: 70,
      child: TLCircularActionButton(
        icon: Icons.add,
        backgroundColor: tlThemeDataConfig.whiteBasedColor,
        borderColor: Colors.black26,
        iconColor: tlThemeDataConfig.accentColor,
        onPressed: () {
          showAddCategoryBottomSheet(
            context: context,
            corrWorkspace: corrWorkspace,
            parentBigCategoryID: null,
          );
        },
      ),
    );
  }
}
