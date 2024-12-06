import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/view/component/dialog/for_category/delete_category_dialog.dart';
import 'package:today_list/view/component/dialog/for_category/rename_category_dialog.dart';
import 'package:today_list/view/component/dialog/tl_base_dialog.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/model/todo/tl_category.dart';
import 'package:today_list/view_model/todo/tl_workspaces_state.dart';

class SelectEditMethodDialog extends TLBaseConsumerDialog {
  final TLCategory categoryOfThisPage;
  final int indexOfBigCategory;
  final int? indexOfSmallCategory;
  const SelectEditMethodDialog({
    super.key,
    required this.categoryOfThisPage,
    required this.indexOfBigCategory,
    this.indexOfSmallCategory,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeData tlThemeData = TLTheme.of(context);
    // notifier
    return SimpleDialog(
      backgroundColor: tlThemeData.alertColor,
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
                  indexOfBigCategory: indexOfBigCategory,
                  indexOfSmallCategory: indexOfSmallCategory,
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
                      indexOfBigCategory: indexOfBigCategory,
                      indexOfSmallCategory: indexOfSmallCategory,
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
