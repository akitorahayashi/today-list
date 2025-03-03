import 'package:flutter/material.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/model/design/tl_theme_config.dart';
import 'package:today_list/model/todo/tl_todo_category.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/view/component/dialog/for_category/add_category_dialog.dart';

class SelectBigCategoryDropdown extends StatelessWidget {
  final TLWorkspace corrWorkspace;
  final String bigCategoryID;
  final Function(String) onSelected;

  const SelectBigCategoryDropdown({
    super.key,
    required this.corrWorkspace,
    required this.bigCategoryID,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final TLThemeConfig tlThemeData = TLTheme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
      child: DropdownButton<TLToDoCategory>(
        dropdownColor: tlThemeData.whiteBasedColor,
        isExpanded: true,
        iconEnabledColor: tlThemeData.accentColor,
        hint: Text(
          getSelectedCategoryName(),
          style: const TextStyle(
            color: Colors.black45,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: const TextStyle(
          color: Colors.black45,
          fontWeight: FontWeight.bold,
        ),
        items: buildDropdownItems(tlThemeData),
        onChanged: (selected) {
          if (selected == null) return;
          if (selected.id == "---createBigCategory") {
            AddCategoryDialog(
              corrWorkspace: corrWorkspace,
              parentBigCategoryID: null,
            ).show(context: context);
          } else {
            onSelected(selected.id);
          }
        },
      ),
    );
  }

  // MARK: - 選択中のカテゴリ名を取得
  String getSelectedCategoryName() {
    if (bigCategoryID == corrWorkspace.id) return "大カテゴリー";

    final matchingCategory = corrWorkspace.bigCategories.firstWhere(
      (c) => c.id == bigCategoryID,
      orElse: () => const TLToDoCategory(
          id: "", parentBigCategoryID: null, name: "不明なカテゴリー"),
    );

    return matchingCategory.name;
  }

  // MARK: - ドロップダウンリストを生成
  List<DropdownMenuItem<TLToDoCategory>> buildDropdownItems(
      TLThemeConfig theme) {
    final items = [
      TLToDoCategory(
          id: corrWorkspace.id, parentBigCategoryID: null, name: "なし"),
      ...corrWorkspace.bigCategories,
      const TLToDoCategory(
          id: "---createBigCategory", parentBigCategoryID: null, name: "新しく作る"),
    ];

    return items.map((item) {
      final isSelected = item.id == bigCategoryID;
      return DropdownMenuItem(
        value: item,
        child: Text(
          item.name,
          style: TextStyle(
            color: isSelected ? theme.accentColor : Colors.black.withAlpha(128),
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }).toList();
  }
}
