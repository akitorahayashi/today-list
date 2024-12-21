import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../model/design/tl_theme.dart';
import '../../../../../model/todo/tl_category.dart';
import '../../../../component/dialog/for_category/add_category_dialog.dart';
import '../../../../../view_model/todo/editing_provider/editing_todo_provider.dart';
import '../../../../../view_model/todo/tl_workspaces_state.dart';

class SelectSmallCategoryDropDown extends ConsumerWidget {
  const SelectSmallCategoryDropDown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeData tlThemeData = TLTheme.of(context);
    // provider
    final EditingTodo editingTodo = ref.watch(editingToDoProvider);
    final tlWorksacesState = ref.watch(tlWorkspacesStateProvider);
    final currentWorkspace = tlWorksacesState.currentWorkspace;
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
              : (currentWorkspace.smallCategories[editingTodo.bigCatgoeyID] ??
                      [])
                  .firstWhere(
                    (oneOfSmallCategory) =>
                        oneOfSmallCategory.id == editingTodo.smallCategoryID,
                    orElse: () => TLCategory(
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
          if (currentWorkspace
              .smallCategories[editingTodo.bigCatgoeyID]!.isEmpty)
            TLCategory(id: noneID, title: "なし"),
          ...currentWorkspace.smallCategories[editingTodo.bigCatgoeyID]!,
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
