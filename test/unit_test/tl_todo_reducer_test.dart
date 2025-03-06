import 'package:flutter_test/flutter_test.dart';
import 'package:today_list/model/todo/tl_step.dart';
import 'package:today_list/model/todo/tl_todo.dart';
import 'package:today_list/model/todo/tl_todos_in_today_and_whenever.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/action/tl_todo_action.dart';
import 'package:today_list/redux/reducer/property/tl_todo_reducer.dart';

void main() {
  group('TLToDoReducer', () {
    late List<TLWorkspace> workspaces;
    late TLWorkspace testWorkspace;
    late TLToDo testToDo;

    setUp(() {
      // テスト用のToDoを作成
      testToDo = const TLToDo(
        id: 'todo1',
        workspaceID: 'workspace1',
        isInToday: true,
        content: 'Test ToDo',
        steps: [
          TLStep(id: 'step1', content: 'Step 1', isChecked: false),
          TLStep(id: 'step2', content: 'Step 2', isChecked: false),
        ],
      );

      // テスト用のワークスペースを作成
      testWorkspace = TLWorkspace(
        id: 'workspace1',
        name: 'Test Workspace',
        workspaceIDToToDos: {
          'workspace1': TLToDosInTodayAndWhenever(
            workspaceID: 'workspace1',
            toDosInToday: [testToDo],
            toDosInWhenever: [],
          ),
        },
      );

      // テスト用のワークスペースリストを作成
      workspaces = [testWorkspace];
    });

    test('addToDo action should add a todo to the workspace', () {
      // Arrange
      const newToDo = TLToDo(
        id: 'todo2',
        workspaceID: 'workspace1',
        isInToday: true,
        content: 'New ToDo',
      );
      final action = TLToDoAction.addToDo(
        corrWorkspace: testWorkspace,
        newToDo: newToDo,
      );

      // Act
      final updatedWorkspaces = TLToDoReducer.reduce(workspaces, action);

      // Assert
      final updatedWorkspace = updatedWorkspaces.first;
      final todosInToday =
          updatedWorkspace.workspaceIDToToDos['workspace1']!.toDosInToday;
      expect(todosInToday.length, equals(2));
      expect(todosInToday.any((todo) => todo.id == 'todo2'), isTrue);
      expect(todosInToday.any((todo) => todo.content == 'New ToDo'), isTrue);
    });

    test('updateToDo action should update an existing todo', () {
      // Arrange
      final updatedToDo = testToDo.copyWith(
        content: 'Updated ToDo',
        isChecked: true,
      );
      final action = TLToDoAction.updateToDo(
        corrWorkspace: testWorkspace,
        newToDo: updatedToDo,
      );

      // Act
      final updatedWorkspaces = TLToDoReducer.reduce(workspaces, action);

      // Assert
      final updatedWorkspace = updatedWorkspaces.first;
      final todosInToday =
          updatedWorkspace.workspaceIDToToDos['workspace1']!.toDosInToday;
      expect(todosInToday.length, equals(1));
      expect(todosInToday.first.content, equals('Updated ToDo'));
      expect(todosInToday.first.isChecked, isTrue);
    });

    test('deleteToDo action should remove a todo from the workspace', () {
      // Arrange
      final action = TLToDoAction.deleteToDo(
        corrWorkspace: testWorkspace,
        corrToDo: testToDo,
      );

      // Act
      final updatedWorkspaces = TLToDoReducer.reduce(workspaces, action);

      // Assert
      final updatedWorkspace = updatedWorkspaces.first;
      final todosInToday =
          updatedWorkspace.workspaceIDToToDos['workspace1']!.toDosInToday;
      expect(todosInToday.length, equals(0));
      expect(todosInToday.any((todo) => todo.id == 'todo1'), isFalse);
    });

    test(
        'toggleToDoCheckStatus action should toggle the check status of a todo',
        () {
      // Arrange
      final action = TLToDoAction.toggleToDoCheckStatus(
        corrWorkspace: testWorkspace,
        corrToDo: testToDo,
      );

      // Act
      final updatedWorkspaces = TLToDoReducer.reduce(workspaces, action);

      // Assert
      final updatedWorkspace = updatedWorkspaces.first;
      final todosInToday =
          updatedWorkspace.workspaceIDToToDos['workspace1']!.toDosInToday;
      expect(todosInToday.first.isChecked, isTrue); // 元々はfalseなので、toggleするとtrue
    });

    test(
        'toggleToDoTodayWhenever action should move a todo between Today and Whenever',
        () {
      // Arrange
      final action = TLToDoAction.toggleToDoTodayWhenever(
        corrWorkspace: testWorkspace,
        corrToDo: testToDo,
      );

      // Act
      final updatedWorkspaces = TLToDoReducer.reduce(workspaces, action);

      // Assert
      final updatedWorkspace = updatedWorkspaces.first;
      final todosInToday =
          updatedWorkspace.workspaceIDToToDos['workspace1']!.toDosInToday;
      final todosInWhenever =
          updatedWorkspace.workspaceIDToToDos['workspace1']!.toDosInWhenever;

      expect(todosInToday.length, equals(0)); // Todayから移動したので0
      expect(todosInWhenever.length, equals(1)); // Wheneverに移動したので1
      expect(
          todosInWhenever.first.isInToday, isFalse); // isInTodayがfalseに変更されている
    });

    test(
        'toggleStepCheckStatus action should toggle the check status of a step',
        () {
      // Arrange
      final step = testToDo.steps.first;
      final action = TLToDoAction.toggleStepCheckStatus(
        corrWorkspace: testWorkspace,
        corrToDo: testToDo,
        corrStep: step,
      );

      // Act
      final updatedWorkspaces = TLToDoReducer.reduce(workspaces, action);

      // Assert
      final updatedWorkspace = updatedWorkspaces.first;
      final todosInToday =
          updatedWorkspace.workspaceIDToToDos['workspace1']!.toDosInToday;
      final updatedSteps = todosInToday.first.steps;

      expect(updatedSteps.first.isChecked, isTrue); // 元々はfalseなので、toggleするとtrue
      expect(updatedSteps.last.isChecked, isFalse); // 変更していないステップはそのまま
    });
  });
}
