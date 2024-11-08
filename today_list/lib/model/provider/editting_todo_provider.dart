import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/tl_workspace.dart';
import 'package:today_list/model/todo/tl_category.dart';
import 'package:today_list/model/todo/tl_step.dart';
import '../todo/tl_todos.dart';
import '../todo/tl_todo.dart';
import './current_tl_workspace_provider.dart';
import './tl_workspaces_provider.dart';

class EdittingTodo {
  TextEditingController toDoTitleInputController;
  TextEditingController stepTitleInputController;
  List<TLStep> tlSteps;
  String bigCatgoeyID;
  String? smallCategoryID;
  bool ifInToday;
  // 編集関係のメンバー
  int? indexOfEditingToDo;
  int? indexOfEditingStep;

  EdittingTodo(
    this.toDoTitleInputController,
    this.stepTitleInputController,
    this.tlSteps,
    this.bigCatgoeyID,
    this.smallCategoryID,
    this.ifInToday,
    this.indexOfEditingToDo,
    this.indexOfEditingStep,
  );

  EdittingTodo copyWith({
    required TextEditingController? toDoTitleInputController,
    required TextEditingController? stepTitleInputController,
    required List<TLStep>? tlSteps,
    required String? bigCatgoeyID,
    required String? smallCategoryID,
    required bool? ifInToday,
    required int? indexOfEditingToDo,
    required int? indexOfEditingStep,
  }) {
    return EdittingTodo(
      toDoTitleInputController ?? this.toDoTitleInputController,
      stepTitleInputController ?? this.stepTitleInputController,
      tlSteps ?? this.tlSteps,
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

  EditingToDoNotifier(this.ref) : super(EdittingTodo());

  void setInitialValue() {
    ifInToday = true;
    toDoTitleInputController = TextEditingController();
    stepTitleInputController = TextEditingController();
    selectedBigCategory =
        ref.watch(currentTLWorkspaceProvider).bigCategories[0];
    state = TLToDo.getDefaultToDo();
    indexOfEditingToDo = null;
    indexOfEditingStep = null;
  }

  void setEditedToDo({
    required bool ifInToday,
    required TLCategory selectedBigCategory,
    required TLCategory? selectedSmallCategory,
    required int indexOfEditingToDo,
  }) {
    final TLWorkspace currentWorkspace = ref.watch(currentTLWorkspaceProvider);
    final String corrCategoryID =
        selectedSmallCategory?.id ?? selectedBigCategory.id;
    final TLToDo edittedToDo =
        currentWorkspace.toDos[corrCategoryID]![ifInToday][indexOfEditingToDo];
    // setValues
    this.ifInToday = ifInToday;
    toDoTitleInputController = TextEditingController()
      ..text = edittedToDo.title;
    stepTitleInputController = TextEditingController();
    this.selectedBigCategory = selectedBigCategory;
    this.selectedSmallCategory = selectedSmallCategory;
    this.indexOfEditingToDo = indexOfEditingToDo;
    indexOfEditingStep = null;
    state = edittedToDo;
  }

  void onChangedToDoTitle(String newTitle) {
    state = state.copyWith(title: newTitle);
  }

  void addToStepList(String stepTitle, int? indexOfEditingStep) {
    final newStep = TLStep(id: UniqueKey().toString(), title: stepTitle);
    if (indexOfEditingStep == null) {
      final updatedSteps = List<TLStep>.from(state.steps)..add(newStep);
      state = state.copyWith(steps: updatedSteps);
    } else {
      final updatedSteps = List<TLStep>.from(state.steps);
      updatedSteps[indexOfEditingStep] = newStep;
      state = state.copyWith(steps: updatedSteps);
      this.indexOfEditingStep = null;
    }
  }

  Future<void> completeEditting() async {
    // provider
    final currentTLWorkspace = ref.read(currentTLWorkspaceProvider);
    // notifier
    final currentTLWorkspaceNotifier =
        ref.read(currentTLWorkspaceProvider.notifier);

    final String corrCategoryID =
        selectedSmallCategory?.id ?? selectedBigCategory.id;
    final TLToDos corrToDos = currentTLWorkspace.toDos[corrCategoryID]!;
    if (indexOfEditingToDo == null) {
      // add
      corrToDos[ifInToday].add(state.copyWith());
    } else {
      // edit
      corrToDos[ifInToday][indexOfEditingToDo!] = state.copyWith();
      indexOfEditingToDo = null;
    }
    await ref.read(tlWorkspacesProvider.notifier).updateSpecificTLWorkspace(
          specificWorkspaceIndex:
              currentTLWorkspaceNotifier.currentTLWorkspaceIndex,
          updatedWorkspace: currentTLWorkspace,
        );
    // 入力事項の初期化
    state = TLToDo.getDefaultToDo();
    toDoTitleInputController.clear();
    stepTitleInputController.clear();
  }

  void disposeValue() {
    ifInToday = true;
    toDoTitleInputController.dispose();
    stepTitleInputController.dispose();
    selectedBigCategory;
    selectedSmallCategory = null;
    indexOfEditingToDo = null;
    indexOfEditingStep = null;
    state = TLToDo.getDefaultToDo();
  }
}
