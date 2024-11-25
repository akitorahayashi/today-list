import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../workspace/tl_workspace.dart';
import '../todo/tl_step.dart';
import '../todo/tl_todo.dart';
import '../todo/tl_todos.dart';
import '../workspace/provider/current_tl_workspace_provider.dart';
import '../workspace/provider/tl_workspaces_provider.dart';

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

  EditingTodo update({
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
      smallCategoryID ?? this.smallCategoryID,
      ifInToday ?? this.ifInToday,
      indexOfEditingToDo ?? indexOfEditingToDo,
      indexOfEditingStep ?? indexOfEditingStep,
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
    final TLWorkspace currentWorkspace = ref.watch(currentWorkspaceProvider);
    final String corrCategoryID =
        selectedSmallCategoryID ?? selectedBigCategoryID;
    final TLToDo edittedToDo = currentWorkspace
        .categoryIDToToDos[corrCategoryID]![ifInToday][indexOfEditingToDo];
    // setValues
    state = state.update(
      steps: edittedToDo.steps,
      bigCatgoeyID: selectedBigCategoryID,
      smallCategoryID: selectedSmallCategoryID,
      ifInToday: ifInToday,
      indexOfEditingToDo: indexOfEditingToDo,
      indexOfEditingStep: null,
    );
  }

  void updateEdittingTodo({
    TextEditingController? toDoTitleInputController,
    TextEditingController? stepTitleInputController,
    List<TLStep>? steps,
    String? bigCatgoeyID,
    String? smallCategoryID,
    bool? ifInToday,
    int? indexOfEditingToDo,
    int? indexOfEditingStep,
  }) {
    state = state.update(
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
      state = state.update(steps: updatedSteps);
    } else {
      final updatedSteps = List<TLStep>.from(state.steps);
      updatedSteps[state.indexOfEditingStep!] = newStep;
      state = state.update(steps: updatedSteps, indexOfEditingStep: null);
    }
  }

  Future<void> completeEditting() async {
    if (EditingTodo.toDoTitleInputController?.text == null ||
        EditingTodo.toDoTitleInputController!.text.trim().isEmpty) return;

    // provider
    final currentTLWorkspace = ref.read(currentWorkspaceProvider);
    // notifier
    final TLWorkspacesNotifier tlWorkspacesNotifier =
        ref.read(tlWorkspacesProvider.notifier);

    final String corrCategoryID = state.smallCategoryID ?? state.bigCatgoeyID;
    final TLToDos corrToDos =
        currentTLWorkspace.categoryIDToToDos[corrCategoryID]!;

    final TLToDo createdToDo = TLToDo(
        id: state.smallCategoryID ?? state.bigCatgoeyID,
        title: EditingTodo.toDoTitleInputController?.text ?? "Error",
        steps: state.steps);
    if (state.indexOfEditingToDo == null) {
      // add
      corrToDos[state.ifInToday].add(createdToDo);
    } else {
      // edit
      corrToDos[state.ifInToday][state.indexOfEditingToDo!] = createdToDo;
    }
    await tlWorkspacesNotifier.updateCurrentWorkspace(
      updatedWorkspace: currentTLWorkspace.copyWith(),
    );
    // 入力事項の初期化
    state.update(indexOfEditingToDo: null, indexOfEditingStep: null);
    EditingTodo.toDoTitleInputController?.clear();
    EditingTodo.stepTitleInputController?.clear();
  }
}
