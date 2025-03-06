import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/model/tl_app_state.dart';
import 'package:today_list/model/todo/tl_todo.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/model/todo/tl_todos_in_today_and_whenever.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/resource/tl_theme_type.dart';
import 'package:today_list/view/component/common_ui_part/tl_circular_action_button.dart';
import 'package:today_list/view/page/home_page/home_page.dart';
import 'package:today_list/view/page/home_page/tl_home_bottom_navbar/tl_home_bottom_navbar.dart';
import 'package:today_list/view/page/home_page/tl_home_bottom_navbar/center_button_of_home_bottom_navbar.dart';
import 'package:today_list/view/page/home_page/tab_content/todo_list_in_workspace_in_today_and_whenever.dart';
import 'package:today_list/view/page/home_page/tab_content/todo_list_of_all_workspaces_in_today.dart';

void main() {
  group('HomePage Tests', () {
    late ProviderContainer container;
    final mockToDo1 = TLToDo(
      id: 'todo-1',
      workspaceID: 'workspace-1',
      isInToday: true,
      content: 'Test Todo 1',
    );

    final mockToDo2 = TLToDo(
      id: 'todo-2',
      workspaceID: 'workspace-1',
      isInToday: false,
      isChecked: true,
      content: 'Test Todo 2',
    );

    final mockTodosInTodayAndWhenever = TLToDosInTodayAndWhenever(
      workspaceID: 'workspace-1',
      toDosInToday: [mockToDo1],
      toDosInWhenever: [mockToDo2],
    );

    final mockWorkspace = TLWorkspace(
      id: 'workspace-1',
      name: 'Test Workspace',
      workspaceIDToToDos: {
        'workspace-1': mockTodosInTodayAndWhenever,
      },
    );

    setUp(() {
      container = ProviderContainer(
        overrides: [
          tlAppStateProvider
              .overrideWith(() => MockTLAppStateController(mockWorkspace)),
        ],
      );
    });

    Widget buildTestableWidget(Widget child) {
      return ProviderScope(
        child: UncontrolledProviderScope(
          container: container,
          child: TLTheme(
            data: TLThemeType.sunOrange.config,
            child: MaterialApp(
              home: child,
            ),
          ),
        ),
      );
    }

    testWidgets('HomePage has correct structure', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget(const HomePage()));
      await tester.pumpAndSettle(); // アニメーションが完了するまで待機

      // 基本構造の検証
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(TLHomeBottomNavBar), findsOneWidget);
      expect(find.byType(TabBarView), findsOneWidget);
    });

    testWidgets('TLHomeBottomNavBar has correct structure',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const Scaffold(
            bottomNavigationBar: TLHomeBottomNavBar(),
          ),
        ),
      );

      // BottomNavbarの構造検証
      expect(find.byType(BottomAppBar), findsOneWidget);
    });

    testWidgets('CenterButtonOfHomeBottomNavBar exists',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const Scaffold(
            body: CenterButtonOfHomeBottomNavBar(
              doesCurrentWorkspaceExist: true,
            ),
          ),
        ),
      );

      // ウィジェットの存在確認
      expect(find.byType(CenterButtonOfHomeBottomNavBar), findsOneWidget);
    });

    testWidgets('ToDoListInWorkspaceInTodayAndWhenever has correct structure',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          Scaffold(
            body: ToDoListInWorkspaceInTodayAndWhenever(
              corrWorkspace: mockWorkspace,
            ),
          ),
        ),
      );

      // TodoListの構造検証
      expect(find.byType(ListView), findsAtLeastNWidgets(1));
    });

    testWidgets('ToDoListOfAllWorkspacesInToday has correct structure',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const Scaffold(
            body: ToDoListOfAllWorkspacesInToday(),
          ),
        ),
      );

      // TodoListの構造検証
      expect(find.byType(ListView), findsAtLeastNWidgets(1));
    });
  });
}

// モックのTLAppStateController
class MockTLAppStateController extends TLAppStateController {
  final TLWorkspace mockWorkspace;

  MockTLAppStateController(this.mockWorkspace);

  @override
  TLAppState build() {
    return TLAppState(
      tlWorkspaces: [mockWorkspace],
      currentWorkspaceID: mockWorkspace.id,
      selectedThemeType: TLThemeType.sunOrange,
    );
  }

  @override
  Future<void> updateState(dynamic action) async {
    // テスト用に何もしない
  }
}
