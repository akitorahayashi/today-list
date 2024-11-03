import 'package:flutter/material.dart';
import '../../../model/design/tl_theme.dart';
import '../../../model/todo/tl_category.dart';
import '../../../model/workspace/tl_workspace.dart';

class SmallCategoryCard extends StatelessWidget {
  final int indexOfBigCategory;
  final int indexOfSmallCategory;
  const SmallCategoryCard(
      {super.key,
      required this.indexOfBigCategory,
      required this.indexOfSmallCategory});

  TLCategory get smallCategoryOfThisCard =>
      TLWorkspace.currentWorkspace.smallCategories[TLWorkspace.currentWorkspace
          .bigCategories[indexOfBigCategory].id]![indexOfSmallCategory];

  @override
  Widget build(BuildContext context) {
    final TLThemeData _tlThemeData = TLTheme.of(context);
    final int numberOfToDosInThisCategory =
        smallCategoryOfThisCard.getNumberOfToDosInThisCategory();
    return GestureDetector(
      // TODO カテゴリーを編集するDialogを表示
      onTap: () {},
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: SizedBox(
          height: 50,
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      smallCategoryOfThisCard.title,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          overflow: TextOverflow.ellipsis,
                          fontSize: 15,
                          color: _tlThemeData.accentColor),
                    ),
                  ),
                ),
              ),
              if (numberOfToDosInThisCategory != 0)
                Padding(
                  padding: const EdgeInsets.only(right: 24.0),
                  child: Text(
                    "$numberOfToDosInThisCategory",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: _tlThemeData.accentColor),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
