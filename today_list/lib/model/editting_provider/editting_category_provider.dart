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
    String? bigCatgoeyIDForSmallCategory,
    int? indexOfEditingBigCategory,
    int? indexOfEditingSmallCategory,
  }) {
    return EdittingCategory(
      categoryTitleInputController ?? this.categoryTitleInputController,
      bigCatgoeyIDForSmallCategory ?? bigCatgoeyID,
      indexOfEditingBigCategory ?? this.indexOfEditingBigCategory,
      indexOfEditingSmallCategory ?? this.indexOfEditingSmallCategory,
    );
  }
}

final edittingCategoryProvider =
    StateNotifierProvider<EdittingCategoryNotifier, EdittingCategory>((ref) {
  return EdittingCategoryNotifier(ref);
});

class EdittingCategoryNotifier extends StateNotifier<EdittingCategory> {
  final Ref ref;

  EdittingCategoryNotifier(this.ref)
      : super(EdittingCategory.generateInitialEdittingCategory());

  void setInitialValue() {
    state = EdittingCategory.generateInitialEdittingCategory();
  }

  void setEditedCategory({
    required int indexOfEditingBigCategory,
    required int? indexOfEditingSmallCategory,
  }) {
    final TLWorkspace currentWorkspace = ref.watch(currentWorkspaceProvider);
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
      categoryTitleInputController: categoryTitleInputController,
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
            title: state.categoryTitleInputController?.text ?? "Error");
        corrBigCategories.add(createdBigCategory);
      } else {
        // edit bigCategory
        final TLCategory renamedBigCategory = TLCategory(
            id: corrBigCategories[state.indexOfEditingBigCategory!].id,
            title: state.categoryTitleInputController?.text ?? "Error");
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
            title: state.categoryTitleInputController?.text ?? "Error");
        corrSmallCategories[state.bigCatgoeyID!]!.add(createdSmallCategory);
      } else {
        // edit smallCategory
        final TLCategory renamedSmallCategory = TLCategory(
            id: corrSmallCategories[state.bigCatgoeyID!]![
                    state.indexOfEditingSmallCategory!]
                .id,
            title: state.categoryTitleInputController?.text ?? "Error");
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
    state.categoryTitleInputController?.clear();
  }

  // ページを離れた時の処理
  void disposeValue() {
    state.categoryTitleInputController?.dispose();
    state = state.copyWith(
      categoryTitleInputController: null,
      bigCatgoeyIDForSmallCategory: null,
      indexOfEditingBigCategory: null,
      indexOfEditingSmallCategory: null,
    );
  }
}
