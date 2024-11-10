import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/tl_workspace.dart';
import 'package:today_list/model/todo/tl_category.dart';
import '../provider/current_tl_workspace_provider.dart';
import '../provider/tl_workspaces_provider.dart';

class EditingCategory {
  static TextEditingController? categoryTitleInputController;
  String? bigCatgoeyID;
  // 編集関係のメンバー
  int? indexOfEditingBigCategory;
  int? indexOfEditingSmallCategory;

  EditingCategory(
    this.bigCatgoeyID,
    this.indexOfEditingBigCategory,
    this.indexOfEditingSmallCategory,
  );

  static EditingCategory generateInitialEdittingCategory() {
    return EditingCategory(
      noneID,
      null,
      null,
    );
  }

  static void updateTextEdittingController(
      {required String? editedCategoryTitle}) {
    categoryTitleInputController = TextEditingController()
      ..text = editedCategoryTitle ?? "";
  }

  EditingCategory copyWith({
    String? bigCatgoeyIDForSmallCategory,
    int? indexOfEditingBigCategory,
    int? indexOfEditingSmallCategory,
  }) {
    return EditingCategory(
      bigCatgoeyIDForSmallCategory ?? bigCatgoeyID,
      indexOfEditingBigCategory ?? this.indexOfEditingBigCategory,
      indexOfEditingSmallCategory ?? this.indexOfEditingSmallCategory,
    );
  }
}

final edittingCategoryProvider =
    StateNotifierProvider<EdittingCategoryNotifier, EditingCategory>((ref) {
  return EdittingCategoryNotifier(ref);
});

class EdittingCategoryNotifier extends StateNotifier<EditingCategory> {
  final Ref ref;

  EdittingCategoryNotifier(this.ref)
      : super(EditingCategory.generateInitialEdittingCategory());

  void setInitialValue() {
    state = EditingCategory.generateInitialEdittingCategory();
  }

  void setEditedCategory({
    required int indexOfEditingBigCategory,
    required int? indexOfEditingSmallCategory,
  }) {
    final TLWorkspace currentWorkspace = ref.watch(currentWorkspaceProvider);
    final TLCategory corrBigCategory =
        currentWorkspace.bigCategories[indexOfEditingBigCategory];
    // setValues
    state = state.copyWith(
      bigCatgoeyIDForSmallCategory:
          indexOfEditingSmallCategory == null ? null : corrBigCategory.id,
      indexOfEditingBigCategory: indexOfEditingBigCategory,
      indexOfEditingSmallCategory: indexOfEditingSmallCategory,
    );
  }

  void updateEdittingCategory({
    TextEditingController? categoryTitleInputController,
    String? bigCatgoeyID,
    int? indexOfEditingBigCategory,
    int? indexOfEditingSmallCategory,
  }) {
    state = state.copyWith(
      bigCatgoeyIDForSmallCategory: bigCatgoeyID,
      indexOfEditingBigCategory: indexOfEditingBigCategory,
      indexOfEditingSmallCategory: indexOfEditingSmallCategory,
    );
  }

  Future<void> completeEditting() async {
    // provider
    final currentTLWorkspace = ref.watch(currentWorkspaceProvider);

    // 追加、編集処理
    if (state.bigCatgoeyID == null) {
      // bigCategory
      final List<TLCategory> corrBigCategories =
          List<TLCategory>.from(currentTLWorkspace.bigCategories);
      if (state.indexOfEditingBigCategory == null) {
        // add bigCategory
        final TLCategory createdBigCategory = TLCategory(
            id: UniqueKey().toString(),
            title:
                EditingCategory.categoryTitleInputController?.text ?? "Error");
        corrBigCategories.add(createdBigCategory);
      } else {
        // edit bigCategory
        final TLCategory renamedBigCategory = TLCategory(
            id: corrBigCategories[state.indexOfEditingBigCategory!].id,
            title:
                EditingCategory.categoryTitleInputController?.text ?? "Error");
        corrBigCategories[state.indexOfEditingBigCategory!] =
            renamedBigCategory;
      }
      // 保存
      await ref.read(tlWorkspacesProvider.notifier).updateCurrentWorkspace(
            updatedWorkspace: currentTLWorkspace
              ..bigCategories = corrBigCategories,
          );
    } else {
      // smallCategory
      final Map<String, List<TLCategory>> corrSmallCategories = {
        for (var entry in currentTLWorkspace.smallCategories.entries)
          entry.key: List<TLCategory>.from(entry.value)
      };
      if (state.indexOfEditingSmallCategory == null) {
        // add smallCategory
        final TLCategory createdSmallCategory = TLCategory(
            id: UniqueKey().toString(),
            title:
                EditingCategory.categoryTitleInputController?.text ?? "Error");
        corrSmallCategories[state.bigCatgoeyID!]!.add(createdSmallCategory);
      } else {
        // edit smallCategory
        final TLCategory renamedSmallCategory = TLCategory(
            id: corrSmallCategories[state.bigCatgoeyID!]![
                    state.indexOfEditingSmallCategory!]
                .id,
            title:
                EditingCategory.categoryTitleInputController?.text ?? "Error");
        corrSmallCategories[state.bigCatgoeyID!]![
            state.indexOfEditingSmallCategory!] = renamedSmallCategory;
      }
      // 保存
      await ref.read(tlWorkspacesProvider.notifier).updateCurrentWorkspace(
            updatedWorkspace: currentTLWorkspace
              ..smallCategories = corrSmallCategories,
          );
    }
    // 入力事項の初期化
    state.copyWith(
        bigCatgoeyIDForSmallCategory: null,
        indexOfEditingBigCategory: null,
        indexOfEditingSmallCategory: null);
    EditingCategory.categoryTitleInputController?.clear();
  }

  // ページを離れた時の処理
  void disposeValue() {
    EditingCategory.categoryTitleInputController?.dispose();
    state = state.copyWith(
      bigCatgoeyIDForSmallCategory: null,
      indexOfEditingBigCategory: null,
      indexOfEditingSmallCategory: null,
    );
  }
}
