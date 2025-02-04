import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/resource/initial_tl_workspaces.dart';
import '../../../../../model/design/tl_theme.dart';
import '../../../../../model/todo/tl_category.dart';
import '../../../../component/dialog/for_category/add_category_dialog.dart';
import '../../../../../redux/store/editing_provider/editing_todo_provider.dart';

class SelectBigCategoryDropDown extends ConsumerWidget {
  const SelectBigCategoryDropDown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeData tlThemeData = TLTheme.of(context);
    // provider
    final EditingTodo editingTodo = ref.watch(editingToDoProvider);
    final tlAppState = ref.watch(tlAppStateProvider);
    // notifier
    final tlAppStateReducer = ref.read(tlAppStateProvider.notifier);
    // others
    final TLWorkspace currentWorkspaceReference =
        tlAppState.tlWorkspaces[tlAppState.currentWorkspaceIndex];
    // notifier
    final EditingToDoNotifier editingToDoNotifier =
        ref.watch(editingToDoProvider.notifier);
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
      child: DropdownButton(
          iconEnabledColor: tlThemeData.accentColor,
          isExpanded: true,
          // hint text
          hint: Text(
            editingTodo.bigCatgoeyID == noneID
                ? "大カテゴリー"
                : currentWorkspaceReference.bigCategories
                    .where((oneOfBigCategory) =>
                        oneOfBigCategory.id == editingTodo.bigCatgoeyID)
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
            ...currentWorkspaceReference.bigCategories,
            TLCategory(id: "---createBigCategory", title: "新しく作る"),
          ].map((TLCategory oneOfBigCategory) {
            return DropdownMenuItem(
              value: oneOfBigCategory,
              child: Text(
                oneOfBigCategory.title,
                style: oneOfBigCategory.id == editingTodo.bigCatgoeyID
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
          onChanged: (TLCategory? selectedBigCategory) async {
            if (selectedBigCategory == null) return;
            editingToDoNotifier.updateEditingTodo(
              smallCategoryID: null,
              indexOfEditingToDo: editingTodo.indexOfEditingToDo,
              indexOfEditingStep: editingTodo.indexOfEditingStep,
            );
            if (selectedBigCategory.id == "---createBigCategory") {
              await const AddCategoryDialog().show(context: context);
            } else {
              editingToDoNotifier.updateEditingTodo(
                bigCatgoeyID: selectedBigCategory.id,
                indexOfEditingToDo: editingTodo.indexOfEditingToDo,
                indexOfEditingStep: editingTodo.indexOfEditingStep,
              );
            }
          }),
    );
  }
}
