import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:today_list/model/tl_app_state.dart';
import 'package:today_list/view/component/dialog/for_category/delete_category_dialog.dart';
import 'package:today_list/view/component/dialog/for_category/rename_category_dialog.dart';
import 'package:today_list/view/component/dialog/tl_base_dialog_mixin.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/todo/tl_todo_category.dart';

class SelectEditMethodDialog extends ConsumerWidget with TLBaseDialogMixin {
  final String corrWorkspaceID;
  final TLToDoCategory categoryOfThisPage;
  const SelectEditMethodDialog({
    super.key,
    required this.corrWorkspaceID,
    required this.categoryOfThisPage,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeConfig tlThemeData = TLTheme.of(context);
    // notifier
    return SimpleDialog(
      backgroundColor: tlThemeData.alertBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      titlePadding: const EdgeInsets.fromLTRB(18, 24, 24, 24),
      title: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 5.0),
            child: Text(
              "カテゴリー名",
              style: TextStyle(
                  color: Color.fromRGBO(120, 120, 120, 1), fontSize: 10),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              categoryOfThisPage.title,
              style: TextStyle(
                  color: tlThemeData.accentColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
      children: [
        // このカテゴリーを改名するボタン
        if (categoryOfThisPage.id != noneID)
          SimpleDialogOption(
            onPressed: () async {
              Navigator.pop(context);
              await showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => RenameCategoryDialog(
                  corrWorkspaceID: corrWorkspaceID,
                  categoryToRename: categoryOfThisPage,
                ),
              );
            },
            child: Text(
              "Rename",
              style: TextStyle(
                  color: tlThemeData.accentColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        // このカテゴリーを削除するボタン
        if (categoryOfThisPage.id != noneID)
          SimpleDialogOption(
            onPressed: () async {
              Navigator.pop(context);
              await showDialog(
                  context: context,
                  builder: (context) {
                    return DeleteCategoryDialog(
                      corrWorkspaceID: corrWorkspaceID,
                      categoryToDelete: categoryOfThisPage,
                    );
                  });
            },
            child: Text(
              "Delete",
              style: TextStyle(
                  color: tlThemeData.accentColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
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
                    (states) => Colors.lightGreen.withOpacity(0.1)),
              ),
              child: const Text(
                "close",
                style: TextStyle(color: Colors.lightGreen),
              ),
            ),
          ),
        )
      ],
    );
  }
}
