import 'package:flutter_test/flutter_test.dart';
import 'package:today_list/model/settings_data/selected_check_box_icon_data.dart';
import 'package:today_list/model/settings_data/tl_user_data.dart';
import 'package:today_list/redux/action/tl_user_data_action.dart';
import 'package:today_list/redux/reducer/property/tl_user_data_reducer.dart';
import 'package:today_list/resource/icon_resource_of_checkbox.dart';

void main() {
  group('TLUserDataReducer', () {
    late TLUserData initialUserData;

    setUp(() {
      // Set up initial user data for testing
      initialUserData = const TLUserData(
        currentAppIconName: "Sun Orange",
        selectedCheckBoxIconData: SelectedCheckBoxIconData(
          iconCategory: "Default",
          iconName: "Box",
        ),
        earnedCheckBoxIcons: {
          "Default": ["Box", "Circle"]
        },
      );
    });

    test(
        'updateSelectedCheckBoxIcon action should update the selected checkbox icon',
        () async {
      // Arrange
      const newCheckBox = SelectedCheckBoxIconData(
        iconCategory: "Default",
        iconName: "Circle",
      );
      const action =
          TLUserDataAction.updateSelectedCheckBoxIcon(newCheckBox: newCheckBox);

      // Act
      final updatedUserData =
          await TLUserDataReducer.reduce(initialUserData, action);

      // Assert
      expect(updatedUserData.selectedCheckBoxIconData, equals(newCheckBox));
      expect(
          updatedUserData.currentAppIconName,
          equals(initialUserData
              .currentAppIconName)); // Other properties unchanged
      expect(
          updatedUserData.earnedCheckBoxIcons,
          equals(initialUserData
              .earnedCheckBoxIcons)); // Other properties unchanged
    });

    test('updateEarnedIcons action should add a new icon to existing category',
        () async {
      // Arrange
      const action = TLUserDataAction.updateEarnedIcons(
        iconCategory: TLIconCategory.defaultCategory,
        iconName: TLIconName.circle,
      );

      // Act
      final updatedUserData =
          await TLUserDataReducer.reduce(initialUserData, action);

      // Assert
      expect(
          updatedUserData.earnedCheckBoxIcons["Default"], contains("Circle"));
      expect(updatedUserData.earnedCheckBoxIcons["Default"]!.length,
          equals(2)); // Already contains Circle
      expect(
          updatedUserData.currentAppIconName,
          equals(initialUserData
              .currentAppIconName)); // Other properties unchanged
    });

    test(
        'updateEarnedIcons action should create a new category if it does not exist',
        () async {
      // Arrange
      const action = TLUserDataAction.updateEarnedIcons(
        iconCategory: TLIconCategory.unit1,
        iconName: TLIconName.water,
      );

      // Act
      final updatedUserData =
          await TLUserDataReducer.reduce(initialUserData, action);

      // Assert
      expect(updatedUserData.earnedCheckBoxIcons.containsKey("Unit 1"), isTrue);
      expect(updatedUserData.earnedCheckBoxIcons["Unit 1"], contains("Water"));
      expect(
          updatedUserData.currentAppIconName,
          equals(initialUserData
              .currentAppIconName)); // Other properties unchanged
    });
  });
}
