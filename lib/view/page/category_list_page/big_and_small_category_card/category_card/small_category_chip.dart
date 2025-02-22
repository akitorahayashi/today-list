import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:today_list/model/todo/tl_todo_category.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/util/tl_category_utils.dart';
import 'package:today_list/view/component/dialog/for_category/select_edit_method_dialog.dart';

class SmallCategoryChip extends ConsumerWidget {
  final TLWorkspace corrWorkspace;
  final TLToDoCategory corrSmallCategory;

  const SmallCategoryChip({
    super.key,
    required this.corrWorkspace,
    required this.corrSmallCategory,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeConfig tlThemeData = TLTheme.of(context);

    final numberOfToDos = _getNumberOfToDos(corrWorkspace, corrSmallCategory);

    return GestureDetector(
      onTap: () =>
          _showEditDialog(context, corrWorkspace.id, corrSmallCategory),
      child: Card(
        color: tlThemeData.whiteBasedColor,
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
                      corrSmallCategory.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                        fontSize: 15,
                        color: tlThemeData.accentColor,
                      ),
                    ),
                  ),
                ),
              ),
              if (numberOfToDos != 0)
                Padding(
                  padding: const EdgeInsets.only(right: 24.0),
                  child: Text(
                    "$numberOfToDos",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: tlThemeData.accentColor,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // MARK - Get Number of ToDos
  int _getNumberOfToDos(
      TLWorkspace corrWorkspace, TLToDoCategory smallCategory) {
    return TLCategoryUtils.getNumberOfToDosInThisCategory(
      ifInToday: null,
      corrToDos: corrWorkspace.categoryIDToToDos[smallCategory.id]!,
    );
  }

  // MARK - Show Edit Dialog
  Future<void> _showEditDialog(BuildContext context, String corrWorkspaceID,
      TLToDoCategory smallCategory) async {
    await showDialog(
      context: context,
      builder: (context) {
        return SelectEditMethodDialog(
          corrWorkspaceID: corrWorkspaceID,
          categoryOfThisPage: smallCategory,
        );
      },
    );
  }
}
