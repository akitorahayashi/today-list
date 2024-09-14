import '../../constants/theme.dart';
import '../../constants/global_keys.dart';
import '../../model/tl_category.dart';
import '../../model/user/setting_data.dart';
import '../../model/workspace/workspace.dart';
import '../../model/workspace/id_to_jsonworkspaceList.dart';
import '../../crud/for_todo_category/delete_category_dialog.dart';
import '../../crud/for_todo_category/rename_category_dialog.dart';
import 'package:flutter/material.dart';

class EditCatedgoryCard extends StatefulWidget {
  final int indexOfBigCategory;
  final int? indexOfSmallCategory;
  const EditCatedgoryCard({
    super.key,
    required this.indexOfBigCategory,
    required this.indexOfSmallCategory,
  });

  @override
  State<EditCatedgoryCard> createState() => _EditCatedgoryCardState();
}

class _EditCatedgoryCardState extends State<EditCatedgoryCard> {
  TLCategory get _categoryOfThisPage => widget.indexOfSmallCategory == null
      ? currentWorkspace.bigCategories[widget.indexOfBigCategory]
      : currentWorkspace.smallCategories[currentWorkspace
          .bigCategories[widget.indexOfBigCategory]
          .id]![widget.indexOfSmallCategory!];

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: theme[settingData.selectedTheme]!.alertColor,
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
              _categoryOfThisPage.title,
              style: TextStyle(
                  color: theme[settingData.selectedTheme]!.accentColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
      children: [
        // このカテゴリーを削除するボタン
        if (_categoryOfThisPage.id != noneId)
          SimpleDialogOption(
            onPressed: () async {
              Navigator.pop(context);
              await confirmToDeleteThisCategory(
                context: context,
                indexOfWorkspaceCategory: null,
                indexOfBigCategory: widget.indexOfBigCategory,
                indexOfSmallCategory: widget.indexOfSmallCategory,
              );
              categoryListPageKey.currentState?.setState(() {});
            },
            child: Text(
              "Delete",
              style: TextStyle(
                  color: theme[settingData.selectedTheme]!.accentColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        // このカテゴリーを改名するボタン
        if (_categoryOfThisPage.id != noneId)
          SimpleDialogOption(
            onPressed: () async {
              Navigator.pop(context);
              await showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => renameCategoryDialog(
                  context: context,
                  indexOfWorkspaceCategory: null,
                  indexOfBigCategory: widget.indexOfBigCategory,
                  indexOfSmallCategory: widget.indexOfSmallCategory,
                ),
              );
              categoryListPageKey.currentState?.setState(() {});
            },
            child: Text(
              "Rename",
              style: TextStyle(
                  color: theme[settingData.selectedTheme]!.accentColor,
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
                overlayColor: MaterialStateProperty.resolveWith(
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
