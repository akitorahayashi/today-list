import 'package:flutter/material.dart';
import '../../../../constants/theme.dart';
import '../../../../constants/global_keys.dart';
import '../../../../model/user/setting_data.dart';
import '../../../../model/tl_category.dart';
import '../../../../model/workspace/workspace.dart';
import '../../../all_todos_in_this_category_page/all_todos_in_category_page.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BigCategoryChip extends StatelessWidget {
  final int indexOfBigCategory;
  const BigCategoryChip({super.key, required this.indexOfBigCategory});

  TLCategory get bigCategoryInThisChip =>
      currentWorkspace.bigCategories[indexOfBigCategory];

  @override
  Widget build(BuildContext context) {
    final int numberOfToDosInThisCategory =
        bigCategoryInThisChip.getNumberOfToDosInThisCategory();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        height: 80,
        child: InputChip(
          backgroundColor:
              theme[settingData.selectedTheme]!.bigCategoryChipColor,
          avatar: const Icon(FontAwesomeIcons.rectangleList),
          label: SizedBox(
            height: 35,
            child: Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      bigCategoryInThisChip.title,
                    ),
                  ),
                ),
                if (numberOfToDosInThisCategory != 0)
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text("$numberOfToDosInThisCategory"),
                  )
              ],
            ),
          ),
          labelStyle: const TextStyle(
              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.white),
          pressElevation: 3,
          elevation: 3,
          onPressed: () => showCupertinoModalBottomSheet(
              context: context,
              enableDrag: false,
              builder: (context) {
                return AllToDosInThisCategoryPage(
                  key: allToDosInCategoryPageKey,
                  indexOfBigCategory: indexOfBigCategory,
                );
              }),
        ),
      ),
    );
  }
}
