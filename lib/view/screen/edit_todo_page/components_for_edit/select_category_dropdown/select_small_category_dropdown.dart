import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/resource/initial_tl_workspaces.dart';
import '../../../../../model/design/tl_theme/tl_theme.dart';
import '../../../../../model/todo/tl_category.dart';
import '../../../../component/dialog/for_category/add_category_dialog.dart';
import '../../../../../redux/store/editing_provider/editing_todo_provider.dart';

class SelectSmallCategoryDropDown extends ConsumerWidget {
  const SelectSmallCategoryDropDown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeConfig tlThemeData = TLTheme.of(context);
    // provider
    final EditingTodo editingTodo = ref.watch(editingToDoProvider);
    final tlAppState = ref.watch(tlAppStateProvider);
    // others
    final TLWorkspace currentWorkspaceReference =
        tlAppState.tlWorkspaces[tlAppState.currentWorkspaceIndex];
    // notifier
    final EditingToDoNotifier editingToDoNotifier =
        ref.read(editingToDoProvider.notifier);
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
      child: DropdownButton(
        iconEnabledColor: tlThemeData.accentColor,
        isExpanded: true,
        hint: Text(
          editingTodo.smallCategoryID == null
              ? "小カテゴリー"
              : (currentWorkspaceReference
                          .smallCategories[editingTodo.bigCatgoeyID] ??
                      [])
                  .firstWhere(
                    (oneOfSmallCategory) =>
                        oneOfSmallCategory.id == editingTodo.smallCategoryID,
                    orElse: () => const TLCategory(
                        id: '', title: '小カテゴリー'), // デフォルトのTLCategoryオブジェクトを返す
                  )
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
          if (currentWorkspaceReference
              .smallCategories[editingTodo.bigCatgoeyID]!.isEmpty)
            TLCategory(id: noneID, title: "なし"),
          ...currentWorkspaceReference
              .smallCategories[editingTodo.bigCatgoeyID]!,
          if (editingTodo.bigCatgoeyID != noneID)
            TLCategory(id: "---createSmallCategory", title: "新しく作る"),
        ].map((TLCategory item) {
          return DropdownMenuItem(
            value: item,
            child: Text(
              item.title,
              style: item.id == editingTodo.smallCategoryID
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
        onChanged: (TLCategory? selectedSmallCategory) async {
          if (selectedSmallCategory == null) return;

          if (selectedSmallCategory.id == "---createSmallCategory") {
            await const AddCategoryDialog().show(context: context);
          } else {
            editingToDoNotifier.updateEditingTodo(
              smallCategoryID: selectedSmallCategory.id == noneID
                  ? null
                  : selectedSmallCategory.id,
              indexOfEditingToDo: editingTodo.indexOfEditingToDo,
              indexOfEditingStep: editingTodo.indexOfEditingStep,
            );
          }
        },
      ),
    );
  }
}
