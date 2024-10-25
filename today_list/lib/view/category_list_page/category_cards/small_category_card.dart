import 'package:flutter/material.dart';
import '../../../constants/theme.dart';
import '../../../constants/global_keys.dart';
import '../../../model/tl_category.dart';
import '../../../model/user/setting_data.dart';
import '../../../model/workspace/tl_workspace.dart';
import '../../../view/all_todos_in_this_category_page/all_todos_in_category_page.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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
    final int numberOfToDosInThisCategory =
        smallCategoryOfThisCard.getNumberOfToDosInThisCategory();
    return GestureDetector(
      onTap: () {
        showCupertinoModalBottomSheet(
            context: context,
            enableDrag: false,
            builder: (context) => AllToDosInThisCategoryPage(
                  key: allToDosInCategoryPageKey,
                  indexOfBigCategory: indexOfBigCategory,
                  indexOfSmallCategory: indexOfSmallCategory,
                ));
      },
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
                          color: tlThemeDataList[
                                  SettingData.shared.selectedThemeIndex]!
                              .accentColor),
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
                        color: tlThemeDataList[
                                SettingData.shared.selectedThemeIndex]!
                            .accentColor),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
