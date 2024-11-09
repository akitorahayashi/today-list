import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/tl_workspace.dart';
import 'package:today_list/model/todo/tl_category.dart';
import '../provider/current_tl_workspace_provider.dart';
import '../provider/tl_workspaces_provider.dart';

class EdittingCategory {
  TextEditingController? categoryTitleInputController;
  String? bigCatgoeyID;
  // 編集関係のメンバー
  int? indexOfEditingBigCategory;
  int? indexOfEditingSmallCategory;

  EdittingCategory(
    this.categoryTitleInputController,
    this.bigCatgoeyID,
    this.indexOfEditingBigCategory,
    this.indexOfEditingSmallCategory,
  );

  static EdittingCategory generateInitialEdittingCategory() {
    return EdittingCategory(
      TextEditingController(),
      noneID,
      null,
      null,
    );
  }

  EdittingCategory copyWith({
    TextEditingController? categoryTitleInputController,
    String? bigCatgoeyID,
    bool? ifInToday,
    int? indexOfEditingBigCategory,
    int? indexOfEditingSmallCategory,
  }) {
    return EdittingCategory(
      categoryTitleInputController ?? this.categoryTitleInputController,
      bigCatgoeyID ?? this.bigCatgoeyID,
      indexOfEditingBigCategory ?? this.indexOfEditingBigCategory,
      indexOfEditingSmallCategory ?? this.indexOfEditingSmallCategory,
    );
  }
}

final edittingCategoryProvider =
    StateNotifierProvider<EditingCategoryNotifier, EdittingCategory>((ref) {
  return EditingCategoryNotifier(ref);
});

class EditingCategoryNotifier extends StateNotifier<EdittingCategory> {
  final Ref ref;

  EditingCategoryNotifier(this.ref)
      : super(EdittingCategory.generateInitialEdittingCategory());

  void setInitialValue() {
    state = EdittingCategory.generateInitialEdittingCategory();
  }

  void setEditedCategory({
    required int indexOfEditingBigCategory,
    required int? indexOfEditingSmallCategory,
  }) {
    final TLWorkspace currentWorkspace = ref.watch(currentTLWorkspaceProvider);
    final TLCategory corrBigCategory =
        currentWorkspace.bigCategories[indexOfEditingBigCategory];
    final TLCategory corrCategory = indexOfEditingSmallCategory == null
        ? corrBigCategory
        : currentWorkspace
            .smallCategories[corrBigCategory.id]![indexOfEditingSmallCategory];
    // setValues
    state = state.copyWith(
      categoryTitleInputController:
          TextEditingController(text: corrCategory.title),
      bigCatgoeyID: corrBigCategory.id,
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
      categoryTitleInputController: categoryTitleInputController,
      bigCatgoeyID: bigCatgoeyID,
      indexOfEditingBigCategory: indexOfEditingBigCategory,
      indexOfEditingSmallCategory: indexOfEditingSmallCategory,
    );
  }

  Future<void> completeEditting() async {
    // provider
    final currentTLWorkspace = ref.watch(currentTLWorkspaceProvider);
    // notifier
    final currentTLWorkspaceNotifier =
        ref.read(currentTLWorkspaceProvider.notifier);

    final TLCategory createdCategory = TLCategory(
        id: UniqueKey().toString(),
        title: state.categoryTitleInputController?.text ?? "Error");
    if (state.indexOfEditingBigCategory == null) {
      // add
      currentTLWorkspaceNotifier.corrToDos[state.ifInToday]
          .add(createdCategory);
    } else if (state.indexOfEditingSmallCategory == null) {
      // edit bigCategory
      corrToDos[state.ifInToday][state.indexOfEditingToDo!] = createdCategory;
    } else {
      // edit smallCategory
      corrToDos[state.ifInToday][state.indexOfEditingToDo!]
          .add(createdCategory);
    }
    // 保存
    await ref.read(tlWorkspacesProvider.notifier).updateSpecificTLWorkspace(
          specificWorkspaceIndex:
              currentTLWorkspaceNotifier.currentTLWorkspaceIndex,
          updatedWorkspace: currentTLWorkspace,
        );
    // 入力事項の初期化
    state.copyWith(indexOfEditingToDo: null, indexOfEditingStep: null);
    state.toDoTitleInputController?.clear();
    state.stepTitleInputController?.clear();
  }

  // ページを離れた時の処理
  void disposeValue() {
    state.toDoTitleInputController?.dispose();
    state.stepTitleInputController?.dispose();
    state = state.copyWith(
      toDoTitleInputController: null,
      stepTitleInputController: null,
      ifInToday: true,
      bigCatgoeyID: noneID,
      smallCategoryID: null,
      indexOfEditingToDo: null,
      indexOfEditingStep: null,
    );
  }
}
