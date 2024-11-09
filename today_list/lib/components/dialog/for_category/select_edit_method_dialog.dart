import 'package:flutter/material.dart';
import 'package:today_list/model/design/tl_theme.dart';

class SelectEditMethodDialog extends StatelessWidget {
  const SelectEditMethodDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final TLThemeData tlThemeData = TLTheme.of(context);
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
