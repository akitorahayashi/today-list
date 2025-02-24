import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:today_list/model/todo/tl_todo_category.dart';
import 'package:today_list/model/todo/tl_workspace.dart';

class SelectSmallCategoryDropdown extends ConsumerWidget {
  final TLWorkspace corrWorkspace;
  final String bigCategoryID;
  final String? smallCategoryID;
  final Function(String) onSelected;

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

    final smallCats = corrWorkspace.smallCategories[bigCategoryID] ?? [];

    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
      child: DropdownButton<TLToDoCategory>(
        iconEnabledColor: tlThemeData.accentColor,
        isExpanded: true,
        hint: Text(
          smallCategoryID == null
              ? "小カテゴリー"
              : smallCats
                  .firstWhere(
                    (cat) => cat.id == smallCategoryID,
                    orElse: () => const TLToDoCategory(
                        id: '', parentBigCategoryID: null, name: '小カテゴリー'),
                  )
                  .name,
          style: const TextStyle(
              color: Colors.black45, fontWeight: FontWeight.bold),
        ),
        style:
            const TextStyle(color: Colors.black45, fontWeight: FontWeight.bold),
        items: [
          if (smallCats.isEmpty)
            TLToDoCategory(
                id: corrWorkspace.id, parentBigCategoryID: null, name: "なし"),
          ...smallCats,
          if (bigCategoryID != corrWorkspace.id)
            const TLToDoCategory(
                id: "---createSmallCategory",
                parentBigCategoryID: null,
                name: "新しく作る"),
        ].map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(
              item.name,
              style: item.id == smallCategoryID
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
          onSelected(selected.id);
        },
      ),
    );
  }
}
