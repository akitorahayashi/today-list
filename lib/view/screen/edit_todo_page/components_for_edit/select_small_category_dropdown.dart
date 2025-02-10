import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:today_list/model/todo/tl_category.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';

const String noneID = '---none---';

class SelectSmallCategoryDropdown extends ConsumerWidget {
  final String bigCategoryID;
  final String? smallCategoryID;
  final Function(String) onSelected;

  const SelectSmallCategoryDropdown({
    super.key,
    required this.bigCategoryID,
    required this.smallCategoryID,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeConfig tlThemeData = TLTheme.of(context);
    final tlAppState = ref.watch(tlAppStateProvider);
    final TLWorkspace currentWorkspace = tlAppState.getCurrentWorkspace;

    final smallCats = currentWorkspace.smallCategories[bigCategoryID] ?? [];

    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
      child: DropdownButton<TLCategory>(
        iconEnabledColor: tlThemeData.accentColor,
        isExpanded: true,
        hint: Text(
          smallCategoryID == null
              ? "小カテゴリー"
              : smallCats
                  .firstWhere(
                    (cat) => cat.id == smallCategoryID,
                    orElse: () => const TLCategory(id: '', title: '小カテゴリー'),
                  )
                  .title,
          style: const TextStyle(
              color: Colors.black45, fontWeight: FontWeight.bold),
        ),
        style:
            const TextStyle(color: Colors.black45, fontWeight: FontWeight.bold),
        items: [
          if (smallCats.isEmpty) const TLCategory(id: noneID, title: "なし"),
          ...smallCats,
          if (bigCategoryID != noneID)
            const TLCategory(id: "---createSmallCategory", title: "新しく作る"),
        ].map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(
              item.title,
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
        onChanged: (TLCategory? selected) {
          if (selected == null) return;
          onSelected(selected.id);
        },
      ),
    );
  }
}
