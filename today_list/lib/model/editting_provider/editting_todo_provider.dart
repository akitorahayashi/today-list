import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/tl_workspace.dart';
import 'package:today_list/model/todo/tl_step.dart';
import 'package:today_list/model/todo/tl_todo.dart';
import '../todo/tl_todos.dart';
import '../provider/current_tl_workspace_provider.dart';
import '../provider/tl_workspaces_provider.dart';

class EdittingTodo {
  TextEditingController? toDoTitleInputController;
  TextEditingController? stepTitleInputController;
  List<TLStep> steps;
  String bigCatgoeyID;
  String? smallCategoryID;
  bool ifInToday;
  // 編集関係のメンバー
  int? indexOfEditingToDo;
  int? indexOfEditingStep;

  EdittingTodo(
    this.toDoTitleInputController,
    this.stepTitleInputController,
    this.steps,
    this.bigCatgoeyID,
    this.smallCategoryID,
    this.ifInToday,
    this.indexOfEditingToDo,
    this.indexOfEditingStep,
  );

  static EdittingTodo generateInitialEdittingToDo() {
    return EdittingTodo(
      TextEditingController(),
      TextEditingController(),
      [],
      noneID,
      null,
      true,
      null,
      null,
    );
  }

  EdittingTodo update({
    TextEditingController? toDoTitleInputController,
    TextEditingController? stepTitleInputController,
    List<TLStep>? steps,
    String? bigCatgoeyID,
    String? smallCategoryID,
    bool? ifInToday,
    int? indexOfEditingToDo,
    int? indexOfEditingStep,
  }) {
    return EdittingTodo(
      toDoTitleInputController ?? this.toDoTitleInputController,
      stepTitleInputController ?? this.stepTitleInputController,
      steps ?? this.steps,
      bigCatgoeyID ?? this.bigCatgoeyID,
      smallCategoryID ?? this.smallCategoryID,
      ifInToday ?? this.ifInToday,
      indexOfEditingToDo ?? indexOfEditingToDo,
      indexOfEditingStep ?? indexOfEditingStep,
    );
  }
}

final edittingToDoProvider =
    StateNotifierProvider<EditingToDoNotifier, EdittingTodo>((ref) {
  return EditingToDoNotifier(ref);
});

class EditingToDoNotifier extends StateNotifier<EdittingTodo> {
  final Ref ref;

  EditingToDoNotifier(this.ref)
      : super(EdittingTodo.generateInitialEdittingToDo());

  void setInitialValue() {
    state = EdittingTodo.generateInitialEdittingToDo();
  }

  void setEditedToDo({
    required bool ifInToday,
    required String selectedBigCategoryID,
    required String? selectedSmallCategoryID,
    required int indexOfEditingToDo,
  }) {
    final TLWorkspace currentWorkspace = ref.watch(currentTLWorkspaceProvider);
    final String corrCategoryID =
        selectedSmallCategoryID ?? selectedBigCategoryID;
    final TLToDo edittedToDo =
        currentWorkspace.toDos[corrCategoryID]![ifInToday][indexOfEditingToDo];
    // setValues
    state = state.update(
      toDoTitleInputController: TextEditingController()
        ..text = edittedToDo.title,
      stepTitleInputController: TextEditingController(),
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
      toDoTitleInputController: toDoTitleInputController,
      stepTitleInputController: stepTitleInputController,
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
    // provider
    final currentTLWorkspace = ref.read(currentTLWorkspaceProvider);
    // notifier
    final currentTLWorkspaceNotifier =
        ref.read(currentTLWorkspaceProvider.notifier);
    final TLWorkspacesNotifier tlWorkspacesNotifier =
        ref.read(tlWorkspacesProvider.notifier);

    final String corrCategoryID = state.smallCategoryID ?? state.bigCatgoeyID;
    final TLToDos corrToDos = currentTLWorkspace.toDos[corrCategoryID]!;

    final TLToDo createdToDo = TLToDo(
        id: state.smallCategoryID ?? state.bigCatgoeyID,
        title: state.toDoTitleInputController?.text ?? "Error",
        steps: state.steps);
    if (state.indexOfEditingToDo == null) {
      // add
      corrToDos[state.ifInToday].add(createdToDo);
    } else {
      // edit
      corrToDos[state.ifInToday][state.indexOfEditingToDo!] = createdToDo;
    }
    await tlWorkspacesNotifier.updateSpecificTLWorkspace(
      specificWorkspaceIndex:
          currentTLWorkspaceNotifier.currentTLWorkspaceIndex,
      updatedWorkspace: currentTLWorkspace..toDos[corrCategoryID] = corrToDos,
    );
    // 入力事項の初期化
    state.update(indexOfEditingToDo: null, indexOfEditingStep: null);
    state.toDoTitleInputController?.clear();
    state.stepTitleInputController?.clear();
  }

  // ページを離れた時の処理
  void disposeValue() {
    state.toDoTitleInputController?.dispose();
    state.stepTitleInputController?.dispose();
    state = state.update(
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
