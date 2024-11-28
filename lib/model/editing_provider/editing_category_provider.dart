import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/workspace/tl_workspace.dart';
import 'package:today_list/model/todo/tl_category.dart';
import 'package:today_list/model/todo/tl_todos.dart';
import 'package:today_list/model/workspace/tl_workspaces_state.dart';

class EditingCategory {
  static TextEditingController? categoryTitleInputController;
  String? selecteBigCategoryID;
  // 編集関係のメンバー
  int? indexOfEditingBigCategory;
  int? indexOfEditingSmallCategory;

  EditingCategory(
    this.selecteBigCategoryID,
    this.indexOfEditingBigCategory,
    this.indexOfEditingSmallCategory,
  );

  static EditingCategory generateInitialEditingCategory() {
    return EditingCategory(
      noneID,
      null,
      null,
    );
  }

  static void updateTextEditingController(
      {required String? editedCategoryTitle}) {
    categoryTitleInputController = TextEditingController()
      ..text = editedCategoryTitle ?? "";
  }

  EditingCategory copyWith({
    String? selectedBigCatgoeyID,
    int? indexOfEditingBigCategory,
    int? indexOfEditingSmallCategory,
  }) {
    return EditingCategory(
      selectedBigCatgoeyID,
      indexOfEditingBigCategory,
      indexOfEditingSmallCategory,
    );
  }
}

final editingCategoryProvider =
    StateNotifierProvider<EditingCategoryNotifier, EditingCategory>((ref) {
  return EditingCategoryNotifier(ref);
});

class EditingCategoryNotifier extends StateNotifier<EditingCategory> {
  final Ref ref;

  EditingCategoryNotifier(this.ref)
      : super(EditingCategory.generateInitialEditingCategory());

  void setInitialValue() {
    state = EditingCategory.generateInitialEditingCategory();
  }

  void setEditedCategory({
    required int indexOfEditingBigCategory,
    required int? indexOfEditingSmallCategory,
  }) {
    final TLWorkspace currentWorkspace =
        ref.read(tlWorkspacesStateProvider).currentWorkspace;
    final TLCategory corrBigCategory =
        currentWorkspace.bigCategories[indexOfEditingBigCategory];
    // setValues
    state = state.copyWith(
      selectedBigCatgoeyID:
          indexOfEditingSmallCategory == null ? null : corrBigCategory.id,
      indexOfEditingBigCategory: indexOfEditingBigCategory,
      indexOfEditingSmallCategory: indexOfEditingSmallCategory,
    );
  }

  void updateEditingCategory({
    String? selectedBigCatgoeyID,
    int? indexOfEditingBigCategory,
    int? indexOfEditingSmallCategory,
  }) {
    state = state.copyWith(
      selectedBigCatgoeyID: selectedBigCatgoeyID,
      indexOfEditingBigCategory: indexOfEditingBigCategory,
      indexOfEditingSmallCategory: indexOfEditingSmallCategory,
    );
  }

  Future<void> completeEditing() async {
    // provider
    final copiedCurrentTLWorkspace =
        ref.read(tlWorkspacesStateProvider).currentWorkspace.copyWith();
    // TLWorkspaceのcopyWthで使用
    final List<TLCategory> copiedBigCategories =
        copiedCurrentTLWorkspace.bigCategories;
    final Map<String, List<TLCategory>> copiedSmallCategories =
        copiedCurrentTLWorkspace.smallCategories;
    final Map<String, TLToDos> copiedCategoryIDToToDos =
        copiedCurrentTLWorkspace.categoryIDToToDos;

    // "なし"カテゴリーにはsmallCategoryを追加させない
    if (state.selecteBigCategoryID == noneID) {
      state = state.copyWith(selectedBigCatgoeyID: null);
    }

    // 追加、編集処理
    if (state.selecteBigCategoryID == null) {
      // bigCategory
      if (state.indexOfEditingBigCategory == null) {
        // add bigCategory
        final TLCategory createdBigCategory = TLCategory(
            id: UniqueKey().toString(),
            title:
                EditingCategory.categoryTitleInputController?.text ?? "Error");
        copiedBigCategories.add(createdBigCategory);
        copiedSmallCategories[createdBigCategory.id] = [];
        copiedCategoryIDToToDos[createdBigCategory.id] =
            TLToDos(toDosInToday: [], toDosInWhenever: []);
      } else {
        // edit bigCategory
        final TLCategory renamedBigCategory = TLCategory(
            id: copiedBigCategories[state.indexOfEditingBigCategory!].id,
            title:
                EditingCategory.categoryTitleInputController?.text ?? "Error");
        copiedBigCategories[state.indexOfEditingBigCategory!] =
            renamedBigCategory;
      }
    } else {
      // smallCategory
      if (state.indexOfEditingSmallCategory == null) {
        // add smallCategory
        final TLCategory createdSmallCategory = TLCategory(
            id: UniqueKey().toString(),
            title:
                EditingCategory.categoryTitleInputController?.text ?? "Error");
        copiedSmallCategories[state.selecteBigCategoryID]!
            .add(createdSmallCategory);
        copiedCategoryIDToToDos[createdSmallCategory.id] =
            TLToDos(toDosInToday: [], toDosInWhenever: []);
      } else {
        // edit smallCategory
        final TLCategory renamedSmallCategory = TLCategory(
            id: copiedSmallCategories[state.selecteBigCategoryID!]![
                    state.indexOfEditingSmallCategory!]
                .id,
            title:
                EditingCategory.categoryTitleInputController?.text ?? "Error");
        copiedSmallCategories[state.selecteBigCategoryID]![
            state.indexOfEditingSmallCategory!] = renamedSmallCategory;
      }
    }
    // 保存
    ref.read(tlWorkspacesStateProvider.notifier).updateCurrentWorkspace(
          updatedCurrentWorkspace: copiedCurrentTLWorkspace.copyWith(
            categoryIDToToDos: copiedCategoryIDToToDos,
            bigCategories: copiedBigCategories,
            smallCategories: copiedSmallCategories,
          ),
        );
  }
}
