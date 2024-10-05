import 'package:flutter/material.dart';
import '../../components/for_ui/tl_sliver_appbar.dart';
import '../../model/workspace/tl_workspace.dart';
import '../../model/tl_category.dart';
import '../../model/user/setting_data.dart';
import '../../constants/theme.dart';
import 'category_cards/big_category_card/big_category_card.dart';
import './add_category_parts/add_category_button.dart';
import './add_category_parts/add_category_sheet.dart';

import 'package:reorderables/reorderables.dart';

class CategoryListPage extends StatefulWidget {
  const CategoryListPage({super.key});

  @override
  CategoryListPageState createState() => CategoryListPageState();
}

class CategoryListPageState extends State<CategoryListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        // 背景色
        Container(
            decoration: BoxDecoration(
                color:
                    theme[SettingData.shared.selectedTheme]!.backgroundColor),
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
              ReorderableColumn(
                  children: [
                    // bigCategoryがなしではない場合、bigCategoryの並び替え可能カードを表示する
                    for (int indexOfBigCategory = 0;
                        indexOfBigCategory <
                            TLWorkspace.currentWorkspace.bigCategories.length;
                        indexOfBigCategory++)
                      BigCategoryCard(
                          key: Key(UniqueKey().toString()),
                          indexOfBigCategory: indexOfBigCategory),
                  ],
                  onReorder: (oldIndex, newIndex) {
                    if (newIndex != 0) {
                      if (newIndex != oldIndex) {
                        // 抜き出して
                        TLCategory reOrderedBigCategory = TLWorkspace
                            .currentWorkspace.bigCategories
                            .removeAt(oldIndex);
                        TLWorkspace.currentWorkspace.bigCategories
                            .insert(newIndex, reOrderedBigCategory);
                        setState(() {});
                        // categorisを保存する
                        TLCategory.saveBigCategories();
                      }
                    }
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
