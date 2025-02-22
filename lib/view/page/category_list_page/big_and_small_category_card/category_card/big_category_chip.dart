import 'package:flutter/material.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:today_list/model/todo/tl_todo_category.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/util/tl_category_utils.dart';
import 'package:today_list/view/component/dialog/for_category/select_edit_method_dialog.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BigCategoryCard extends StatelessWidget {
  final TLWorkspace corrWorkspace;
  final TLToDoCategory corrBigCategory;

  const BigCategoryCard({
    super.key,
    required this.corrWorkspace,
    required this.corrBigCategory,
  });

  @override
  Widget build(BuildContext context) {
    final TLThemeConfig tlThemeData = TLTheme.of(context);

    const double cardHeight = 64.0;

    const double paddingHorizontal = 18.0;
    const double textPaddingRight = 8.0;

    const double iconSize = 24.0;
    const double textSize = 16.0;

    const Color iconColor = Colors.white;
    const Color textColor = Colors.white;

    const textStyle = TextStyle(
      color: textColor,
      fontWeight: FontWeight.bold,
      fontSize: textSize,
    );

    final numberOfToDos = TLCategoryUtils.getNumberOfToDosInThisCategory(
      ifInToday: null,
      corrToDos: corrWorkspace.categoryIDToToDos[corrBigCategory.id]!,
    );

    return SizedBox(
      height: cardHeight,
      child: GestureDetector(
        onTap: () async {
          await SelectEditMethodDialog(
            corrWorkspaceID: corrWorkspace.id,
            categoryOfThisPage: corrBigCategory,
          ).show(context: context);
        },
        child: Card(
          color: tlThemeData.bigCategoryChipColor,
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: paddingHorizontal),
            child: SizedBox(
              height: 35,
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 12.0),
                    child: Icon(FontAwesomeIcons.rectangleList,
                        color: iconColor, size: iconSize),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(corrBigCategory.name, style: textStyle),
                    ),
                  ),
                  if (numberOfToDos != 0)
                    Padding(
                      padding: const EdgeInsets.only(right: textPaddingRight),
                      child: Text("$numberOfToDos", style: textStyle),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
