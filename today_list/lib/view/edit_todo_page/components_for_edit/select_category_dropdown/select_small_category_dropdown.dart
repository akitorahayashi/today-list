import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/provider/current_tl_workspace_provider.dart';
import 'package:today_list/model/provider/editting_todo_provider.dart';
import 'package:today_list/model/provider/tl_workspaces_provider.dart';
import 'package:today_list/model/tl_workspace.dart';
import '../../../../model/todo/tl_category.dart';
import '../../../../model/design/tl_theme.dart';

class SelectSmallCategoryDropDown extends ConsumerWidget {
  const SelectSmallCategoryDropDown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeData tlThemeData = TLTheme.of(context);
    // provider
    final currentWorkspace = ref.watch(currentTLWorkspaceProvider);
    // notifier
    final EditingToDoNotifier edittingToDoNotifier =
        ref.watch(edittingToDoProvider.notifier);
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
      child: DropdownButton(
          iconEnabledColor: tlThemeData.accentColor,
          isExpanded: true,
          hint: Text(
            edittingToDoNotifier.selectedSmallCategory == null
                ? "小カテゴリー"
                : currentWorkspace.smallCategories[
                        edittingToDoNotifier.selectedBigCategory.id]!
                    .where((oneOfSmallCategory) =>
                        oneOfSmallCategory.id ==
                        edittingToDoNotifier.selectedSmallCategory!.id)
                    .first
                    .title,
            style: const TextStyle(
              color: Colors.black45,
              fontWeight: FontWeight.bold,
            ),
          ),
          style: const TextStyle(
            color: Colors.black45,
            fontWeight: FontWeight.bold,
          ),
          items: [
            TLCategory(id: noneID, title: "なし"),
            ...currentWorkspace
                .smallCategories[edittingToDoNotifier.selectedBigCategory.id]!,
            if (edittingToDoNotifier.selectedBigCategory.id != noneID)
              TLCategory(id: "---createSmallCategory", title: "新しく作る"),
          ].map((TLCategory item) {
            return DropdownMenuItem(
              value: item,
              child: Text(
                item.title,
                style: item.id == edittingToDoNotifier.selectedBigCategory.id
                    ? TextStyle(
                        color: tlThemeData.accentColor,
                        fontWeight: FontWeight.bold)
                    : TextStyle(
                        color: Colors.black.withOpacity(0.5),
                        fontWeight: FontWeight.bold),
              ),
            );
          }).toList(),

          // カテゴリー変更
          onChanged: (TLCategory? newSmallCategory) async {
            if (newSmallCategory != null) {
              switch (newSmallCategory.id) {
                case noneID:
                  edittingToDoNotifier.selectedSmallCategory = null;
                  break;
                case "---createSmallCategory":
                  edittingToDoNotifier.selectedSmallCategory =
                      await addToDoCategoryAlert(
                          context: context,
                          categoryNameInputController:
                              _categoryNameInputController,
                          bigCategoryId: _selectedBigCategory.id);
                  break;
                default:
                  edittingToDoNotifier.selectedSmallCategory = newSmallCategory;
              }
            }
          }),
    );
  }
}
