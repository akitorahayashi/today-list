import 'package:flutter_test/flutter_test.dart';
import 'package:today_list/model/todo/tl_todos_in_today_and_whenever.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/action/tl_workspace_action.dart';
import 'package:today_list/redux/reducer/property/tl_workspace_reducer.dart';

void main() {
  group('TLWorkspaceReducer', () {
    late List<TLWorkspace> initialWorkspaces;

    setUp(() {
      // Set up initial workspaces for testing
      initialWorkspaces = [
        TLWorkspace(
            id: 'workspace1', name: 'Workspace 1', workspaceIDToToDos: {}),
        TLWorkspace(
            id: 'workspace2', name: 'Workspace 2', workspaceIDToToDos: {}),
      ];
    });

    test('addWorkspace action should add a workspace to the list', () {
      // Arrange
      final newWorkspace = TLWorkspace(
          id: 'workspace3', name: 'Workspace 3', workspaceIDToToDos: {});
      final action = TLWorkspaceAction.addWorkspace(newWorkspace);

      // Act
      final updatedWorkspaces =
          TLWorkspaceReducer.reduce(initialWorkspaces, action);

      // Assert
      expect(updatedWorkspaces.length, equals(3));
      expect(updatedWorkspaces.last, equals(newWorkspace));
    });

    test('deleteWorkspace action should remove a workspace from the list', () {
      // Arrange
      final workspaceToDelete = initialWorkspaces.first;
      final action = TLWorkspaceAction.deleteWorkspace(workspaceToDelete);

      // Act
      final updatedWorkspaces =
          TLWorkspaceReducer.reduce(initialWorkspaces, action);

      // Assert
      expect(updatedWorkspaces.length, equals(1));
      expect(updatedWorkspaces.contains(workspaceToDelete), isFalse);
    });

    test('saveCorrWorkspace action should update an existing workspace', () {
      // Arrange
      final updatedWorkspace =
          initialWorkspaces.first.copyWith(name: 'Updated Workspace');
      final action = TLWorkspaceAction.saveCorrWorkspace(updatedWorkspace);

      // Act
      final updatedWorkspaces =
          TLWorkspaceReducer.reduce(initialWorkspaces, action);

      // Assert
      expect(updatedWorkspaces.length, equals(2));
      expect(updatedWorkspaces.first.name, equals('Updated Workspace'));
      expect(updatedWorkspaces.first.id, equals(initialWorkspaces.first.id));
    });

    test('reorderWorkspace action should reorder workspaces', () {
      // Arrange
      const action =
          TLWorkspaceAction.reorderWorkspace(oldIndex: 0, newIndex: 1);

      // Act
      final updatedWorkspaces =
          TLWorkspaceReducer.reduce(initialWorkspaces, action);

      // Assert
      expect(updatedWorkspaces.length, equals(2));
      expect(updatedWorkspaces[0].id, equals(initialWorkspaces[1].id));
      expect(updatedWorkspaces[1].id, equals(initialWorkspaces[0].id));
    });

    test('deleteAllCheckedToDosInWorkspace action should remove checked todos',
        () {
      // Arrange
      final workspaceWithTodos = TLWorkspace(
          id: 'workspace1',
          name: 'Workspace 1',
          workspaceIDToToDos: {
            'workspace1':
                const TLToDosInTodayAndWhenever(workspaceID: 'workspace1'),
          });

      final workspaces = [workspaceWithTodos];
      final action = TLWorkspaceAction.deleteAllCheckedToDosInWorkspace(
          workspaceWithTodos);

      // Act
      final updatedWorkspaces = TLWorkspaceReducer.reduce(workspaces, action);

      // Assert
      expect(updatedWorkspaces.length, equals(1));
      expect(updatedWorkspaces[0].workspaceIDToToDos, isNotNull);
    });
  });
}
