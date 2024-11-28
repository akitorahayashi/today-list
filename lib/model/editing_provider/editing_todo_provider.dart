import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/workspace/tl_workspaces_state.dart';
import '../workspace/tl_workspace.dart';
import '../todo/tl_step.dart';
import '../todo/tl_todo.dart';
import '../todo/tl_todos.dart';

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
    final TLWorkspace currentWorkspace =
        ref.watch(tlWorkspacesStateProvider).currentWorkspace;
    final String corrCategoryID =
        selectedSmallCategoryID ?? selectedBigCategoryID;
    final TLToDo edittedToDo = currentWorkspace
        .categoryIDToToDos[corrCategoryID]![ifInToday][indexOfEditingToDo];
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
    final newStep = TLStep(id: UniqueKey().toString(), title: stepTitle);
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
    final currentTLWorkspace =
        ref.read(tlWorkspacesStateProvider).currentWorkspace;
    // notifier
    final EditingToDoNotifier editingToDoNotifier =
        ref.read(editingToDoProvider.notifier);
    final TLWorkspacesNotifier tlWorkspacesNotifier =
        ref.read(tlWorkspacesStateProvider.notifier);

    final String corrCategoryID = state.smallCategoryID ?? state.bigCatgoeyID;
    final copiedCategoryToToDos =
        Map<String, TLToDos>.from(currentTLWorkspace.categoryIDToToDos);
    final TLToDos corrToDos = copiedCategoryToToDos[corrCategoryID]!;

    final TLToDo createdToDo = TLToDo(
        id: state.smallCategoryID ?? state.bigCatgoeyID,
        title: EditingTodo.toDoTitleInputController?.text ?? "Error",
        steps: state.steps);
    if (state.indexOfEditingToDo == null) {
      final newIdx = corrToDos[state.ifInToday].indexWhere((t) => t.isChecked);
      // add
      // `isChecked`が`true`の要素が見つかった場合、その直前に挿入
      if (newIdx != -1) {
        corrToDos[state.ifInToday].insert(newIdx, createdToDo);
      } else {
        // 見つからなかった場合は最後尾に追加
        corrToDos[state.ifInToday].add(createdToDo);
      }
    } else {
      // edit
      corrToDos[state.ifInToday][state.indexOfEditingToDo!] = createdToDo;
    }
    // 入力事項の初期化
    editingToDoNotifier.updateEditingTodo(
      smallCategoryID: state.smallCategoryID,
      steps: [],
      indexOfEditingToDo: null,
      indexOfEditingStep: null,
    );
    await tlWorkspacesNotifier.updateCurrentWorkspace(
      updatedWorkspace:
          currentTLWorkspace.copyWith(categoryIDToToDos: copiedCategoryToToDos),
    );
    EditingTodo.toDoTitleInputController?.clear();
    EditingTodo.stepTitleInputController?.clear();
  }
}
