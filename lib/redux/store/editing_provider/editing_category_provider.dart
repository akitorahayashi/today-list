import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/tl_app_state.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/model/todo/tl_category.dart';
import 'package:today_list/model/todo/tl_todos_in_today_and_whenever.dart';
import 'package:today_list/redux/action/tl_workspace_action.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';

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
    final appState = ref.read(tlAppStateProvider);
    final TLWorkspace currentWorkspaceReference =
        appState.getCurrentWorkspace.copyWith();
    final TLCategory corrBigCategory =
        currentWorkspaceReference.bigCategories[indexOfEditingBigCategory];
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
    // 現在のWorkspaceをコピー
    final appState = ref.read(tlAppStateProvider);
    final TLWorkspace currentWorkspaceReference =
        appState.getCurrentWorkspace.copyWith();

    // コピー用データを作成
    final List<TLCategory> copiedBigCategories =
        List<TLCategory>.from(currentWorkspaceReference.bigCategories);
    final Map<String, List<TLCategory>> copiedSmallCategories =
        Map<String, List<TLCategory>>.from(
      currentWorkspaceReference.smallCategories.map(
        (key, value) => MapEntry(key, List<TLCategory>.from(value)),
      ),
    );
    final Map<String, TLToDosInTodayAndWhenever> copiedCategoryIDToToDos =
        Map<String, TLToDosInTodayAndWhenever>.from(
            currentWorkspaceReference.categoryIDToToDos);

    // "なし"カテゴリーにはsmallCategoryを追加させない
    if (state.selecteBigCategoryID == noneID) {
      state = state.copyWith(selectedBigCatgoeyID: null);
    }

    // 追加、編集処理
    if (state.selecteBigCategoryID == null) {
      // bigCategory処理
      if (state.indexOfEditingBigCategory == null) {
        // 新規bigCategoryの作成
        final TLCategory createdBigCategory = TLCategory(
          id: UniqueKey().toString(),
          title: EditingCategory.categoryTitleInputController?.text ?? "Error",
        );

        // リストを更新
        copiedBigCategories.add(createdBigCategory);
        copiedSmallCategories[createdBigCategory.id] = [];
        copiedCategoryIDToToDos[createdBigCategory.id] =
            const TLToDosInTodayAndWhenever(
                toDosInToday: [], toDosInWhenever: []);
      } else {
        // bigCategoryの編集
        final TLCategory renamedBigCategory =
            copiedBigCategories[state.indexOfEditingBigCategory!].copyWith(
          title: EditingCategory.categoryTitleInputController?.text ?? "Error",
        );

        // 更新
        copiedBigCategories[state.indexOfEditingBigCategory!] =
            renamedBigCategory;
      }
    } else {
      // smallCategory処理
      if (state.indexOfEditingSmallCategory == null) {
        // 新規smallCategoryの作成
        final TLCategory createdSmallCategory = TLCategory(
          id: UniqueKey().toString(),
          title: EditingCategory.categoryTitleInputController?.text ?? "Error",
        );

        // リストを更新
        copiedSmallCategories[state.selecteBigCategoryID]!
            .add(createdSmallCategory);
        copiedCategoryIDToToDos[createdSmallCategory.id] =
            const TLToDosInTodayAndWhenever(
                toDosInToday: [], toDosInWhenever: []);
      } else {
        // smallCategoryの編集
        final TLCategory renamedSmallCategory = copiedSmallCategories[state
                .selecteBigCategoryID!]![state.indexOfEditingSmallCategory!]
            .copyWith(
          title: EditingCategory.categoryTitleInputController?.text ?? "Error",
        );

        // 更新
        copiedSmallCategories[state.selecteBigCategoryID!]![
            state.indexOfEditingSmallCategory!] = renamedSmallCategory;
      }
    }

    // 更新後のWorkspaceを作成
    final TLWorkspace updatedWorkspace = currentWorkspaceReference.copyWith(
      bigCategories: copiedBigCategories,
      smallCategories: copiedSmallCategories,
      categoryIDToToDos: copiedCategoryIDToToDos,
    );

    // Workspaceの保存
    ref
        .read(tlAppStateProvider.notifier)
        .dispatchWorkspaceAction(TLWorkspaceAction.updateCurrentWorkspace(
          updatedWorkspace,
        ));
  }
}
