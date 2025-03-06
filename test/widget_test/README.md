# Widget Test

This directory contains widget tests for the UI components of the Today List application. Tests are organized according to the application's structure.

## Directory Structure

```
widget_test/
├── component/                  # Tests for common components
│   ├── common_ui_part/         # Tests for basic UI elements
│   │   ├── tl_double_card_test.dart
│   │   ├── tl_animated_icon_button_test.dart
│   │   ├── tl_appbar_test.dart
│   │   └── tl_circular_action_button_test.dart
│   └── todo_card/              # Tests for ToDo card related components
│       ├── tl_checkbox_test.dart
│       ├── tl_todo_card_test.dart
│       ├── tl_step_card_test.dart
│       └── slidable_for_todo_card_test.dart
├── home_page/                  # Tests for home page
│   └── home_page_test.dart
├── page/                       # Tests for various page components
│   ├── add_todo_page/          # Tests for ToDo addition page
│   │   ├── already_exist_test.dart
│   │   └── model_of_todo_card_test.dart
│   └── home_page/              # Tests for home page components
│       └── num_todos_card_test.dart
└── settings_page/              # Tests for settings pages
    └── set_features_page_test.dart
```

## Test Overview

### Component Tests

#### Common UI Elements
- **TLDoubleCard**: Tests for the double card component display
- **TLAnimatedIconButton**: Tests for the animated icon button's display and behavior
- **TLAppBar**: Tests for the custom app bar component
- **TLCircularActionButton**: Tests for the circular action button's display and behavior

#### ToDo Card Related
- **TLCheckbox**: Tests for checkbox display and state changes
- **TLToDoCard**: Tests for ToDo card display (with/without steps) and state changes
- **TLStepCard**: Tests for step card display and state changes
- **SlidableForToDoCard**: Tests for slidable ToDo card display and functionality

### Page Tests

#### Home Page
- **HomePage**: Tests for the basic structure and component display of the home page
- **NumToDosCard**: Tests for the ToDo count display card

#### ToDo Addition Page
- **AlreadyExist**: Tests for the existing ToDo list display component
- **ModelOfToDoCard**: Tests for the ToDo card model in the ToDo addition page

#### Settings Page
- **SetFeaturesPage**: Tests for the feature settings page display and its panels

## How to Run Tests

To run a specific test file:

```bash
flutter test test/widget_test/[directory]/[test_file]
```

Example:
```bash
flutter test test/widget_test/component/todo_card/tl_todo_card_test.dart
```

To run all widget tests:

```bash
flutter test test/widget_test/
```

## Guidelines for Creating Tests

1. **Test Structure**: Each test file should have a name corresponding to the widget being tested and end with `_test.dart`.
2. **Mock Data**: Define any necessary mock data within each test file.
3. **ProviderScope**: For components using Riverpod, use `ProviderScope` and `UncontrolledProviderScope` to mock providers.
4. **TLTheme**: For components dependent on themes, wrap them with the `TLTheme` widget.
5. **Use of const**: Use the `const` keyword whenever possible to improve performance and code quality.

## Important Notes

- Tests should verify not only the visual display of components but also their functional behavior.
- For tests involving complex animations or asynchronous processes, use `tester.pumpAndSettle()` to wait for all animations to complete.
- In the test environment, do not use actual databases or network connections; mock everything instead. 