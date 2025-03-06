import 'package:flutter_test/flutter_test.dart';
import 'package:today_list/redux/action/tl_theme_action.dart';
import 'package:today_list/redux/reducer/property/tl_theme_reducer.dart';
import 'package:today_list/resource/tl_theme_type.dart';

void main() {
  group('TLThemeReducer', () {
    test('changeTheme action should update the theme', () {
      // Arrange
      const currentTheme = TLThemeType.sunOrange;
      const newTheme = TLThemeType.marineBlue;
      const action = TLThemeAction.changeTheme(newThemeType: newTheme);

      // Act
      final updatedTheme = TLThemeReducer.reduce(currentTheme, action);

      // Assert
      expect(updatedTheme, equals(newTheme));
    });

    test('changeTheme action should work with all theme types', () {
      // Arrange
      const currentTheme = TLThemeType.sunOrange;

      // Test all theme types
      for (final themeType in TLThemeType.values) {
        final action = TLThemeAction.changeTheme(newThemeType: themeType);

        // Act
        final updatedTheme = TLThemeReducer.reduce(currentTheme, action);

        // Assert
        expect(updatedTheme, equals(themeType));
      }
    });
  });
}
