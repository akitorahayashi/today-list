import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/model/design/tl_theme_config.dart';
import 'package:today_list/model/todo/tl_todo_category.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/view/component/dialog/for_category/add_category_dialog.dart';

class SelectSmallCategoryDropdown extends ConsumerWidget {
  final TLWorkspace corrWorkspace;
  final String bigCategoryID;
  final String? smallCategoryID;
  final Function(String?) onSelected;

  const SelectSmallCategoryDropdown({
    super.key,
    required this.corrWorkspace,
    required this.bigCategoryID,
    required this.smallCategoryID,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeConfig tlThemeData = TLTheme.of(context);
    final smallCategories = corrWorkspace.smallCategories[bigCategoryID] ?? [];

    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
      child: DropdownButton<TLToDoCategory>(
        dropdownColor: tlThemeData.whiteBasedColor,
        isExpanded: true,
        iconEnabledColor: tlThemeData.accentColor,
        hint: Text(
          getSelectedCategoryName(smallCategories),
          style: const TextStyle(
            color: Colors.black45,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: const TextStyle(
          color: Colors.black45,
          fontWeight: FontWeight.bold,
        ),
        items: buildDropdownItems(smallCategories, tlThemeData),
        onChanged: (selected) async {
          if (selected == null) return;
          if (selected.id == corrWorkspace.id) {
            onSelected(null);
          } else if (selected.id == "---createSmallCategory") {
            await AddCategoryDialog(
              corrWorkspace: corrWorkspace,
              parentBigCategoryID: bigCategoryID,
            ).show(context: context);
          } else {
            onSelected(selected.id);
          }
        },
      ),
    );
  }

  // MARK: - 選択中の小カテゴリー名を取得
  String getSelectedCategoryName(List<TLToDoCategory> smallCategories) {
    if (smallCategoryID == null) return "小カテゴリー";

    return smallCategories
        .firstWhere(
          (cat) => cat.id == smallCategoryID,
          orElse: () =>
              TLToDoCategory(id: '', parentBigCategoryID: null, name: '小カテゴリー'),
        )
        .name;
  }

  // MARK: - ドロップダウンリストを生成
  List<DropdownMenuItem<TLToDoCategory>> buildDropdownItems(
      List<TLToDoCategory> smallCategories, TLThemeConfig theme) {
    final items = [
      TLToDoCategory(
          id: corrWorkspace.id, parentBigCategoryID: null, name: "なし"),
      ...smallCategories,
      if (bigCategoryID != corrWorkspace.id)
        TLToDoCategory(
            id: "---createSmallCategory",
            parentBigCategoryID: null,
            name: "新しく作る"),
    ];

    return items.map((item) {
      final isSelected = item.id == smallCategoryID;
      return DropdownMenuItem(
        value: item,
        child: Text(
          item.name,
          style: TextStyle(
            color:
                isSelected ? theme.accentColor : Colors.black.withOpacity(0.5),
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }).toList();
  }
}
