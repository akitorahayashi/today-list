import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/view/component/common_ui_part/tl_circular_action_button.dart';
import 'package:today_list/view/component/dialog/for_category/add_category_dialog.dart';
import 'package:today_list/view/component/common_ui_part/tl_appbar.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:today_list/model/tl_app_state.dart';
import 'package:today_list/model/todo/tl_todo_category.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/action/tl_todo_category_action.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'big_and_small_category_card/big_and_small_category_card.dart';

import 'package:reorderables/reorderables.dart';

class CategoryListPage extends ConsumerWidget {
  final TLWorkspace corrWorkspace;
  const CategoryListPage({
    super.key,
    required this.corrWorkspace,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeConfig tlThemeData = TLTheme.of(context);

    return Scaffold(
      appBar: TLAppBar(
        context: context,
        pageTitle: "Category List",
        leadingButtonOnPressed: () => Navigator.pop(context),
        leadingIcon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        trailingButtonOnPressed: null,
        trailingIcon: null,
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
                          onLongPress: bigCategory.id != noneID ? null : () {},
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
          _AddCategoryButton(
              currentWorkspace: corrWorkspace, tlThemeDataConfig: tlThemeData),
        ],
      ),
    );
  }
}

class _AddCategoryButton extends StatelessWidget {
  final TLWorkspace currentWorkspace;
  final TLThemeConfig tlThemeDataConfig;

  const _AddCategoryButton({
    required this.currentWorkspace,
    required this.tlThemeDataConfig,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 50,
      bottom: 70,
      child: TLCircularActionButton(
        icon: Icons.add,
        backgroundColor: tlThemeDataConfig.whiteBasedColor,
        borderColor: Colors.black26,
        iconColor: tlThemeDataConfig.accentColor,
        onPressed: () {
          AddCategoryDialog(currentWorkspace: currentWorkspace)
              .show(context: context);
        },
      ),
    );
  }
}
