import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/util/tl_utils.dart';
import 'package:today_list/view_model/todo/tl_workspaces_state.dart';
import '../../../model/todo/tl_workspace.dart';
import '../../../model/todo/tl_step.dart';
import '../../../model/todo/tl_todo.dart';
import '../../../model/todo/tl_todos.dart';

class EditingTodo {
  static TextEditingController? toDoTitleInputController;
  static TextEditingController? stepTitleInputController;
  List<TLStep> steps;
  String bigCatgoeyID;
  String? smallCategoryID;
  bool ifInToday;
  // 編集関係のメンバー
  int? indexOfEditingToDo;
  int? indexOfEditingStep;

  EditingTodo(
    this.steps,
    this.bigCatgoeyID,
    this.smallCategoryID,
    this.ifInToday,
    this.indexOfEditingToDo,
    this.indexOfEditingStep,
  );

  static EditingTodo generateInitialEdittingToDo() {
    return EditingTodo(
      [],
      noneID,
      null,
      true,
      null,
      null,
    );
  }

  static void updateTextEdittingController({required String? editedToDoTitle}) {
    EditingTodo.toDoTitleInputController = TextEditingController()
      ..text = editedToDoTitle ?? "";
    EditingTodo.stepTitleInputController = TextEditingController();
  }

  copyWith({
    List<TLStep>? steps,
    String? bigCatgoeyID,
    String? smallCategoryID,
    bool? ifInToday,
    int? indexOfEditingToDo,
    int? indexOfEditingStep,
  }) {
    return EditingTodo(
      steps ?? this.steps,
      bigCatgoeyID ?? this.bigCatgoeyID,
      smallCategoryID,
      ifInToday ?? this.ifInToday,
      indexOfEditingToDo,
      indexOfEditingStep,
    );
  }
}

final editingToDoProvider =
    StateNotifierProvider<EditingToDoNotifier, EditingTodo>((ref) {
  return EditingToDoNotifier(ref);
});

class EditingToDoNotifier extends StateNotifier<EditingTodo> {
  final Ref ref;

  EditingToDoNotifier(this.ref)
      : super(EditingTodo.generateInitialEdittingToDo());

  void setInitialValue() {
    state = EditingTodo.generateInitialEdittingToDo();
  }

  void setEditedToDo({
    required bool ifInToday,
    required String selectedBigCategoryID,
    required String? selectedSmallCategoryID,
    required int indexOfEditingToDo,
  }) {
    final TLWorkspace copiedWorkspace =
        ref.read(tlWorkspacesStateProvider).currentWorkspace.copyWith();
    final String corrCategoryID =
        selectedSmallCategoryID ?? selectedBigCategoryID;
    final TLToDo edittedToDo = copiedWorkspace
        .categoryIDToToDos[corrCategoryID]!
        .getToDos(ifInToday)[indexOfEditingToDo];
    // setValues
    state = state.copyWith(
      steps: edittedToDo.steps,
      bigCatgoeyID: selectedBigCategoryID,
      smallCategoryID: selectedSmallCategoryID,
      ifInToday: ifInToday,
      indexOfEditingToDo: indexOfEditingToDo,
      indexOfEditingStep: null,
    );
  }

  void updateEditingTodo({
    TextEditingController? toDoTitleInputController,
    TextEditingController? stepTitleInputController,
    List<TLStep>? steps,
    String? bigCatgoeyID,
    String? smallCategoryID,
    bool? ifInToday,
    int? indexOfEditingToDo,
    int? indexOfEditingStep,
  }) {
    state = state.copyWith(
      steps: steps,
      bigCatgoeyID: bigCatgoeyID,
      smallCategoryID: smallCategoryID,
      ifInToday: ifInToday,
      indexOfEditingToDo: indexOfEditingToDo,
      indexOfEditingStep: indexOfEditingStep,
    );
  }

  void addToStepList(String stepTitle, int? indexOfEditingStep) {
    final newStep = TLStep(id: TLUtils.generateUniqueId(), title: stepTitle);
    if (state.indexOfEditingStep == null) {
      final updatedSteps = List<TLStep>.from(state.steps)..add(newStep);
      state = state.copyWith(steps: updatedSteps);
    } else {
      final updatedSteps = List<TLStep>.from(state.steps);
      updatedSteps[state.indexOfEditingStep!] = newStep;
      state = state.copyWith(steps: updatedSteps, indexOfEditingStep: null);
    }
  }

  Future<void> completeEditing() async {
    if (EditingTodo.toDoTitleInputController?.text == null ||
        EditingTodo.toDoTitleInputController!.text.trim().isEmpty) return;

    // provider
    final TLWorkspace currentWorkspace =
        ref.read(tlWorkspacesStateProvider).currentWorkspace;
    final EditingToDoNotifier editingToDoNotifier =
        ref.read(editingToDoProvider.notifier);
    final TLWorkspacesStateNotifier tlWorkspacesStateNotifier =
        ref.read(tlWorkspacesStateProvider.notifier);

    // 対象のカテゴリIDを取得
    final String corrCategoryID = state.smallCategoryID ?? state.bigCatgoeyID;

    // TLToDoの新規作成または編集
    final TLToDo createdToDo = TLToDo(
      id: TLUtils.generateUniqueId(),
      title: EditingTodo.toDoTitleInputController?.text ?? "Error",
      steps: state.steps,
    );

    // コピーしたデータを更新
    final updatedCategoryIDToToDos = Map<String, TLToDos>.from(
      currentWorkspace.categoryIDToToDos,
    );

    // 対応するToDosリストを取得
    final TLToDos corrToDos = updatedCategoryIDToToDos[corrCategoryID]!;
    final List<TLToDo> updatedToDos = List<TLToDo>.from(
      corrToDos.getToDos(state.ifInToday),
    );

    if (state.indexOfEditingToDo == null) {
      // 新規追加処理
      final newIdx = updatedToDos.indexWhere((t) => t.isChecked);
      if (newIdx != -1) {
        // チェック済みの前に挿入
        updatedToDos.insert(newIdx, createdToDo);
      } else {
        // 最後尾に追加
        updatedToDos.add(createdToDo);
      }
    } else {
      // 編集処理
      updatedToDos[state.indexOfEditingToDo!] = createdToDo;
    }

    // 更新したToDosを反映
    updatedCategoryIDToToDos[corrCategoryID] = corrToDos.copyWith(
      toDosInToday: state.ifInToday ? updatedToDos : corrToDos.toDosInToday,
      toDosInWhenever:
          state.ifInToday ? corrToDos.toDosInWhenever : updatedToDos,
    );

    // 更新後のWorkspaceを作成
    final TLWorkspace updatedWorkspace = currentWorkspace.copyWith(
      categoryIDToToDos: updatedCategoryIDToToDos,
    );

    // 状態の更新
    editingToDoNotifier.updateEditingTodo(
      smallCategoryID: state.smallCategoryID,
      steps: [],
      indexOfEditingToDo: null,
      indexOfEditingStep: null,
    );
    tlWorkspacesStateNotifier.updateCurrentWorkspace(
      updatedCurrentWorkspace: updatedWorkspace,
    );

    // 入力フィールドのクリア
    EditingTodo.toDoTitleInputController?.clear();
    EditingTodo.stepTitleInputController?.clear();
  }
}
