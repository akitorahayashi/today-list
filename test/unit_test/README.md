# Unit Tests for Today List App

This directory contains unit tests for the business logic of the Today List app. The tests focus on the Redux implementation, which is the core of the app's state management.

## Test Structure

The tests are organized to match the structure of the Redux implementation:

- `tl_app_state_reducer_test.dart`: Tests for the main app state reducer
- `tl_app_state_provider_test.dart`: Tests for the app state provider/controller
- `tl_theme_reducer_test.dart`: Tests for the theme reducer
- `tl_workspace_reducer_test.dart`: Tests for the workspace reducer
- `tl_user_data_reducer_test.dart`: Tests for the user data reducer
- `tl_todo_reducer_test.dart`: Tests for the todo reducer

## Running Tests

To run all unit tests, use the following command:

```bash
flutter test test/unit_test/
```

To run a specific test file:

```bash
flutter test test/unit_test/tl_app_state_reducer_test.dart
```

## Test Coverage

The tests cover the following aspects of the Redux implementation:

1. **Reducers**: Tests that each reducer correctly transforms the state based on the given action
2. **Actions**: Tests that each action type is handled correctly
3. **State Provider**: Tests that the state provider correctly manages the app state and handles side effects

## Adding New Tests

When adding new tests, follow these guidelines:

1. Create a new test file for each major component
2. Use the AAA pattern (Arrange, Act, Assert) for test structure
3. Test both the happy path and edge cases
4. Mock external dependencies when necessary 