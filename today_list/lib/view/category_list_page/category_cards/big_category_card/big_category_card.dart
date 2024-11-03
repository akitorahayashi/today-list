import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../model/design/tl_theme.dart';
import '../../../../model/todo/tl_category.dart';
import '../../../../model/workspace/tl_workspace.dart';
import '../../../../model/workspace/tl_workspaces_provider.dart';
import './big_category_chip.dart';
import '../small_category_card.dart';

import 'package:reorderables/reorderables.dart';

class BigCategoryCard extends ConsumerWidget {
  final int indexOfBigCategory;
  const BigCategoryCard({
    super.key,
    required this.indexOfBigCategory,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeData _tlThemeData = TLTheme.of(context);
    return GestureDetector(
      onLongPress:
          TLWorkspace.currentWorkspace.bigCategories[indexOfBigCategory].id !=
                  defaultID
              ? null
              : () {},
      child: Card(
        color: _tlThemeData.panelColor,
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
