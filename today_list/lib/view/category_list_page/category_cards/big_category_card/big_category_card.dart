import 'package:flutter/material.dart';
import '../../../../constants/theme.dart';
import '../../../../model/tl_category.dart';
import '../../../../model/user/setting_data.dart';
import '../../../../model/workspace/workspace.dart';
import '../../../../model/workspace/id_to_jsonworkspaceList.dart';
import './big_category_chip.dart';
import '../small_category_card.dart';

import 'package:reorderables/reorderables.dart';

class BigCategoryCard extends StatelessWidget {
  final int indexOfBigCategory;
  const BigCategoryCard({
    super.key,
    required this.indexOfBigCategory,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress:
          currentWorkspace.bigCategories[indexOfBigCategory].id != noneId
              ? null
              : () {},
      child: Card(
        color: theme[settingData.selectedTheme]!.panelColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Column(
            // bigCategoryのchipを左寄せにするため
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // bigCategoryのChip
              BigCategoryChip(indexOfBigCategory: indexOfBigCategory),

              // --- bigCategoryを並び替えるときはReorderableColumnを非表示にする
              ReorderableColumn(
                children: [
                  for (int indexOfSmallCategory = 0;
                      indexOfSmallCategory <
                          currentWorkspace
                              .smallCategories[currentWorkspace
                                  .bigCategories[indexOfBigCategory].id]!
                              .length;
                      indexOfSmallCategory++)
                    SmallCategoryCard(
                        key: Key(UniqueKey().toString()),
                        indexOfBigCategory: indexOfBigCategory,
                        indexOfSmallCategory: indexOfSmallCategory)
                ],
                // smallCategoryの並び替え
                onReorder: (oldIndex, newIndex) {
                  if (oldIndex != newIndex) {
                    // 抜き出して
                    TLCategory reOrderedSmallCategory = currentWorkspace
                        .smallCategories[currentWorkspace
                            .bigCategories[indexOfBigCategory].id]!
                        .removeAt(oldIndex);
                    // 入れる
                    currentWorkspace.smallCategories[currentWorkspace
                            .bigCategories[indexOfBigCategory].id]!
                        .insert(newIndex, reOrderedSmallCategory);
                    // categorisを保存する
                    TLCategory.saveSmallCategories();
                  }
                },
              )
            ]),
      ),
    );
  }
}
