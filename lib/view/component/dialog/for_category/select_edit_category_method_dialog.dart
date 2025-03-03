import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/view/component/dialog/design/tl_dialog.dart';
import 'package:today_list/view/component/dialog/for_category/delete_category_dialog.dart';
import 'package:today_list/view/component/dialog/for_category/rename_category_dialog.dart';
import 'package:today_list/view/component/dialog/tl_base_dialog_mixin.dart';
import 'package:today_list/model/design/tl_theme_config.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/model/todo/tl_todo_category.dart';

class SelectEditCategoryMethodDialog extends ConsumerWidget
    with TLBaseDialogMixin {
  final TLWorkspace corrWorkspace;
  final TLToDoCategory categoryOfThisPage;
  const SelectEditCategoryMethodDialog({
    super.key,
    required this.corrWorkspace,
    required this.categoryOfThisPage,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeConfig tlThemeData = TLTheme.of(context);
    // notifier
    return TLDialog(
      corrThemeConfig: tlThemeData,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 24, 24, 24),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    "Category Name",
                    style: TextStyle(
                        color: Color.fromRGBO(120, 120, 120, 1), fontSize: 13),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    categoryOfThisPage.name,
                    style: TextStyle(
                        color: tlThemeData.accentColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          // MARK: - Rename
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: SimpleDialogOption(
                  onPressed: () async {
                    Navigator.pop(context);
                    RenameCategoryDialog(
                      corrWorkspace: corrWorkspace,
                      categoryToRename: categoryOfThisPage,
                    ).show(context: context);
                  },
                  child: Text(
                    "Rename",
                    style: TextStyle(
                        color: tlThemeData.accentColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          // MARK: - Delete
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: SimpleDialogOption(
                  onPressed: () async {
                    Navigator.pop(context);
                    DeleteCategoryDialog(
                      corrWorkspace: corrWorkspace,
                      categoryToDelete: categoryOfThisPage,
                    ).show(context: context);
                  },
                  child: Text(
                    "Delete",
                    style: TextStyle(
                        color: tlThemeData.accentColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          // 閉じるボタン
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 20),
            child: Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                style: ButtonStyle(
                  overlayColor: WidgetStateProperty.resolveWith(
                      (states) => Colors.lightGreen.withValues(alpha: 0.1)),
                ),
                child: const Text(
                  "close",
                  style: TextStyle(color: Colors.lightGreen),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
