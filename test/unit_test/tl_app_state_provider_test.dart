import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/redux/action/tl_app_state_action.dart';
import 'package:today_list/redux/action/tl_theme_action.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/resource/tl_theme_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('TLAppStateController', () {
    late ProviderContainer container;

    setUp(() async {
      // SharedPreferencesのモックを設定
      SharedPreferences.setMockInitialValues({});
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('initial state should have default values', () {
      // Act
      final state = container.read(tlAppStateProvider);

      // Assert
      expect(state.tlWorkspaces, isNotEmpty); // Should have initial workspaces
      expect(state.selectedThemeType, equals(TLThemeType.sunOrange));
    });

    test('updateState should update the state with TLThemeAction', () async {
      // Arrange
      final controller = container.read(tlAppStateProvider.notifier);
      final initialState = container.read(tlAppStateProvider);
      final newTheme = TLThemeType.limeGreen;
      final action = TLThemeAction.changeTheme(newThemeType: newTheme);

      // Act
      await controller.updateState(action);
      final updatedState = container.read(tlAppStateProvider);

      // Assert
      expect(updatedState.selectedThemeType, equals(newTheme));
      expect(updatedState.tlWorkspaces,
          equals(initialState.tlWorkspaces)); // Other properties unchanged
    });

    test('updateState should update the state with TLAppStateAction', () async {
      // Arrange
      final controller = container.read(tlAppStateProvider.notifier);
      final initialState = container.read(tlAppStateProvider);
      const newWorkspaceID = 'test-workspace-id';
      final action = TLAppStateAction.changeCurrentWorkspaceID(newWorkspaceID);

      // Act
      await controller.updateState(action);
      final updatedState = container.read(tlAppStateProvider);

      // Assert
      expect(updatedState.currentWorkspaceID, equals(newWorkspaceID));
      expect(updatedState.tlWorkspaces,
          equals(initialState.tlWorkspaces)); // Other properties unchanged
      expect(updatedState.selectedThemeType,
          equals(initialState.selectedThemeType)); // Other properties unchanged
    });
  });
}
