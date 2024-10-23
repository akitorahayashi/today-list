import 'package:flutter/material.dart';
import '../../../../constants/theme.dart';
import '../../../../model/tl_category.dart';
import '../../../../model/user/setting_data.dart';
import '../../../../model/workspace/tl_workspace.dart';
import '../../../../model/workspace/tl_workspaces.dart';
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
          TLWorkspace.currentWorkspace.bigCategories[indexOfBigCategory].id !=
                  noneId
              ? null
              : () {},
      child: Card(
        color: theme[SettingData.shared.selectedTheme]!.panelColor,
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
                          TLWorkspace
                              .currentWorkspace
                              .smallCategories[TLWorkspace.currentWorkspace
                                  .bigCategories[indexOfBigCategory].id]!
                              .length;
                      indexOfSmallCategory++)
                    SmallCategoryCard(
                        key: Key(TLWorkspace
                            .currentWorkspace
                            .smallCategories[TLWorkspace
                                .currentWorkspace
                                .bigCategories[indexOfBigCategory]
                                .id]![indexOfSmallCategory]
                            .id),
                        indexOfBigCategory: indexOfBigCategory,
                        indexOfSmallCategory: indexOfSmallCategory)
                ],
                // smallCategoryの並び替え
                onReorder: (oldIndex, newIndex) {
                  if (oldIndex != newIndex) {
                    // 抜き出して
                    TLCategory reOrderedSmallCategory = TLWorkspace
                        .currentWorkspace
                        .smallCategories[TLWorkspace.currentWorkspace
                            .bigCategories[indexOfBigCategory].id]!
                        .removeAt(oldIndex);
                    // 入れる
                    TLWorkspace
                        .currentWorkspace
                        .smallCategories[TLWorkspace.currentWorkspace
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
