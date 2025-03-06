import 'package:flutter_test/flutter_test.dart';
import 'package:today_list/model/tl_app_state.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/action/tl_app_state_action.dart';
import 'package:today_list/redux/reducer/tl_app_state_reducer.dart';
import 'package:today_list/resource/tl_theme_type.dart';

void main() {
  group('TLAppStateReducer', () {
    late TLAppState initialState;

    setUp(() {
      // Set up a basic initial state for testing
      initialState = const TLAppState(
        tlWorkspaces: [],
        currentWorkspaceID: null,
        selectedThemeType: TLThemeType.sunOrange,
      );
    });

    test('changeCurrentWorkspaceID action should update currentWorkspaceID',
        () async {
      // Arrange
      const String newWorkspaceID = 'test-workspace-id';
      const action = TLAppStateAction.changeCurrentWorkspaceID(newWorkspaceID);

      // Act
      final newState = await TLAppStateReducer.reduce(initialState, action);

      // Assert
      expect(newState.currentWorkspaceID, equals(newWorkspaceID));
      expect(newState.tlWorkspaces,
          equals(initialState.tlWorkspaces)); // Other properties unchanged
      expect(newState.selectedThemeType,
          equals(initialState.selectedThemeType)); // Other properties unchanged
    });

    test('saveWorkspaceList action should update workspace list', () async {
      // Arrange
      final List<TLWorkspace> updatedWorkspaces = [
        TLWorkspace(
            id: 'workspace1', name: 'Test Workspace 1', workspaceIDToToDos: {}),
        TLWorkspace(
            id: 'workspace2', name: 'Test Workspace 2', workspaceIDToToDos: {}),
      ];
      final action = TLAppStateAction.saveWorkspaceList(updatedWorkspaces);

      // Act
      final newState = await TLAppStateReducer.reduce(initialState, action);

      // Assert
      expect(newState.tlWorkspaces, equals(updatedWorkspaces));
      expect(
          newState.currentWorkspaceID,
          equals(
              initialState.currentWorkspaceID)); // Other properties unchanged
      expect(newState.selectedThemeType,
          equals(initialState.selectedThemeType)); // Other properties unchanged
    });

    // Add more tests for other actions as needed
  });
}
