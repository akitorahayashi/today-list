import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/provider/current_tl_workspace_provider.dart';
import 'package:today_list/model/provider/editting_todo_provider.dart';
import 'package:today_list/model/provider/tl_workspaces_provider.dart';
import 'package:today_list/model/tl_workspace.dart';
import 'package:today_list/model/todo/tl_category.dart';
import '../../../../../model/design/tl_theme.dart';

class SelectBigCategoryDropDown extends ConsumerWidget {
  const SelectBigCategoryDropDown({super.key});

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
          // hint text
          hint: Text(
            edittingToDoNotifier.selectedBigCategory.id == noneID
                ? "大カテゴリー"
                : currentWorkspace.bigCategories
                    .where((oneOfBigCategory) =>
                        oneOfBigCategory.id ==
                        edittingToDoNotifier.selectedBigCategory.id)
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
          // list of big categories
          items: [
            ...currentWorkspace.bigCategories,
            TLCategory(id: "---createBigCategory", title: "新しく作る"),
          ].map((TLCategory oneOfBigCategory) {
            return DropdownMenuItem(
              value: oneOfBigCategory,
              child: Text(
                oneOfBigCategory.title,
                style: oneOfBigCategory.id ==
                        edittingToDoNotifier.selectedBigCategory.id
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
          onChanged: (TLCategory? newBigCategory) async {
            if (newBigCategory != null) {
              edittingToDoNotifier.selectedSmallCategory = null;
              switch (newBigCategory.id) {
                case noneID:
                  edittingToDoNotifier.selectedBigCategory =
                      currentWorkspace.bigCategories[0];
                  break;
                case "---createBigCategory":
                  edittingToDoNotifier.selectedBigCategory =
                      await addToDoCategoryAlert(
                              context: context,
                              categoryNameInputController:
                                  _categoryNameInputController,
                              bigCategoryId: null) ??
                          currentWorkspace.bigCategories[0];
                  break;
                default:
                  edittingToDoNotifier.selectedBigCategory = newBigCategory;
              }
            }
          }),
    );
  }
}
