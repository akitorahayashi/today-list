import 'package:flutter/material.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
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

    final bigCategories = corrWorkspace.bigCategories;

    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
      child: DropdownButton<TLToDoCategory>(
        iconEnabledColor: tlThemeData.accentColor,
        isExpanded: true,
        hint: Text(
          bigCategoryID == corrWorkspace.id
              ? "大カテゴリー"
              : (() {
                  final matchingCategories =
                      bigCategories.where((c) => c.id == bigCategoryID);
                  return matchingCategories.isNotEmpty
                      ? matchingCategories.first.name
                      : "不明なカテゴリー";
                })(),
          style: const TextStyle(
              color: Colors.black45, fontWeight: FontWeight.bold),
        ),
        style:
            const TextStyle(color: Colors.black45, fontWeight: FontWeight.bold),
        items: [
          TLToDoCategory(
              id: corrWorkspace.id, parentBigCategoryID: null, name: "なし"),
          ...bigCategories,
          const TLToDoCategory(
              id: "---createBigCategory",
              parentBigCategoryID: null,
              name: "新しく作る"),
        ].map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(
              item.name,
              style: item.id == bigCategoryID
                  ? TextStyle(
                      color: tlThemeData.accentColor,
                      fontWeight: FontWeight.bold)
                  : TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontWeight: FontWeight.bold),
            ),
          );
        }).toList(),
        onChanged: (TLToDoCategory? selected) {
          if (selected == null) return;
          if (selected.id == "---createBigCategory") {
            AddCategoryDialog(
              corrWorkspace: corrWorkspace,
              parentBigCategoryID: null,
            ).show(context: context);
            return;
          } else {
            onSelected(selected.id);
          }
        },
      ),
    );
  }
}
