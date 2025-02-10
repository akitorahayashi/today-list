import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:today_list/model/tl_app_state.dart';
import 'package:today_list/model/todo/tl_category.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';

class SelectBigCategoryDropdown extends ConsumerWidget {
  final String bigCategoryID;
  final Function(String) onSelected;

  const SelectBigCategoryDropdown({
    super.key,
    required this.bigCategoryID,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeConfig tlThemeData = TLTheme.of(context);
    final tlAppState = ref.watch(tlAppStateProvider);
    final TLWorkspace currentWorkspace = tlAppState.getCurrentWorkspace;

    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
      child: DropdownButton<TLCategory>(
        iconEnabledColor: tlThemeData.accentColor,
        isExpanded: true,
        hint: Text(
          bigCategoryID == noneID
              ? "大カテゴリー"
              : currentWorkspace.bigCategories
                  .firstWhere((c) => c.id == bigCategoryID)
                  .title,
          style: const TextStyle(
              color: Colors.black45, fontWeight: FontWeight.bold),
        ),
        style:
            const TextStyle(color: Colors.black45, fontWeight: FontWeight.bold),
        items: [
          ...currentWorkspace.bigCategories,
          const TLCategory(id: "---createBigCategory", title: "新しく作る"),
        ].map((oneOfBigCategory) {
          return DropdownMenuItem(
            value: oneOfBigCategory,
            child: Text(
              oneOfBigCategory.title,
              style: oneOfBigCategory.id == bigCategoryID
                  ? TextStyle(
                      color: tlThemeData.accentColor,
                      fontWeight: FontWeight.bold)
                  : TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontWeight: FontWeight.bold),
            ),
          );
        }).toList(),
        onChanged: (TLCategory? selected) {
          if (selected == null) return;
          onSelected(selected.id);
        },
      ),
    );
  }
}
