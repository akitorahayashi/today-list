import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/flux/store/todo_store.dart';
import 'package:today_list/flux/store/workspace_store.dart';
import 'package:today_list/model/todo/tl_todo.dart';
import 'package:today_list/model/todo/tl_step.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/model/todo/tl_todos_in_today_and_whenever.dart';
import 'package:today_list/util/tl_uuid_generator.dart';

void main() {
  group('TodoNotifier Tests', () {
    late ProviderContainer container;
    late TLWorkspace testWorkspace;
    late TLToDo testTodo;

    setUp(() async {
      // SharedPreferencesのモック設定
      SharedPreferences.setMockInitialValues({});

      // ProviderContainerの初期化
      container = ProviderContainer();

      // テスト用のワークスペースを作成
      final workspaceId = TLUUIDGenerator.generate();
      testWorkspace = TLWorkspace(
        id: workspaceId,
        name: 'Test Workspace',
        workspaceIDToToDos: {
          workspaceId: TLToDosInTodayAndWhenever(
            workspaceID: workspaceId,
            toDosInToday: [],
            toDosInWhenever: [],
          ),
        },
      );

      // ワークスペースを追加
      await container
          .read(workspacesProvider.notifier)
          .addWorkspace(testWorkspace);

      // テスト用のToDoを作成
      testTodo = TLToDo(
        id: TLUUIDGenerator.generate(),
        workspaceID: testWorkspace.id,
        content: 'Test Todo',
        isInToday: true,
        isChecked: false,
        steps: [],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('ToDoを追加すると正しくワークスペースに反映される', () async {
      // ToDoを追加
      await container
          .read(todoProvider.notifier)
          .addTodo(testWorkspace, testTodo);

      // ワークスペースの状態を取得
      final workspaces = await container.read(workspacesProvider.future);
      final updatedWorkspace = workspaces.firstWhere(
        (w) => w.id == testWorkspace.id,
      );

      // 検証
      expect(
        updatedWorkspace.workspaceIDToToDos[updatedWorkspace.id]!.toDosInToday,
        isNotEmpty,
      );
      expect(
        updatedWorkspace
            .workspaceIDToToDos[updatedWorkspace.id]!
            .toDosInToday
            .length,
        equals(1),
      );
      expect(
        updatedWorkspace
            .workspaceIDToToDos[updatedWorkspace.id]!
            .toDosInToday[0]
            .content,
        equals('Test Todo'),
      );
    });

    test('ToDoを更新すると正しくワークスペースに反映される', () async {
      // ToDoを追加
      await container
          .read(todoProvider.notifier)
          .addTodo(testWorkspace, testTodo);

      // 更新用のToDoを作成
      final updatedTodo = testTodo.copyWith(content: 'Updated Todo');

      // 最新のワークスペースを取得
      final workspaces = await container.read(workspacesProvider.future);
      final currentWorkspace = workspaces.firstWhere(
        (w) => w.id == testWorkspace.id,
      );

      // ToDoを更新
      await container
          .read(todoProvider.notifier)
          .updateTodo(currentWorkspace, updatedTodo);

      // 更新後のワークスペースを取得
      final updatedWorkspaces = await container.read(workspacesProvider.future);
      final updatedWorkspace = updatedWorkspaces.firstWhere(
        (w) => w.id == testWorkspace.id,
      );

      // 検証
      expect(
        updatedWorkspace
            .workspaceIDToToDos[updatedWorkspace.id]!
            .toDosInToday[0]
            .content,
        equals('Updated Todo'),
      );
    });

    test('ToDoのチェック状態を切り替えると正しく反映される', () async {
      // ToDoを追加
      await container
          .read(todoProvider.notifier)
          .addTodo(testWorkspace, testTodo);

      // 最新のワークスペースを取得
      final workspaces = await container.read(workspacesProvider.future);
      final currentWorkspace = workspaces.firstWhere(
        (w) => w.id == testWorkspace.id,
      );
      final currentTodo =
          currentWorkspace
              .workspaceIDToToDos[currentWorkspace.id]!
              .toDosInToday[0];

      // ToDoのチェック状態を切り替え
      await container
          .read(todoProvider.notifier)
          .toggleTodoCheck(currentWorkspace, currentTodo, true);

      // 更新後のワークスペースを取得
      final updatedWorkspaces = await container.read(workspacesProvider.future);
      final updatedWorkspace = updatedWorkspaces.firstWhere(
        (w) => w.id == testWorkspace.id,
      );

      // 検証
      expect(
        updatedWorkspace
            .workspaceIDToToDos[updatedWorkspace.id]!
            .toDosInToday[0]
            .isChecked,
        isTrue,
      );
    });

    test('ToDoを削除すると正しくワークスペースから削除される', () async {
      // ToDoを追加
      await container
          .read(todoProvider.notifier)
          .addTodo(testWorkspace, testTodo);

      // 最新のワークスペースを取得
      final workspaces = await container.read(workspacesProvider.future);
      final currentWorkspace = workspaces.firstWhere(
        (w) => w.id == testWorkspace.id,
      );
      final currentTodo =
          currentWorkspace
              .workspaceIDToToDos[currentWorkspace.id]!
              .toDosInToday[0];

      // ToDoを削除
      await container
          .read(todoProvider.notifier)
          .deleteTodo(currentWorkspace, currentTodo, true);

      // 更新後のワークスペースを取得
      final updatedWorkspaces = await container.read(workspacesProvider.future);
      final updatedWorkspace = updatedWorkspaces.firstWhere(
        (w) => w.id == testWorkspace.id,
      );

      // 検証
      expect(
        updatedWorkspace.workspaceIDToToDos[updatedWorkspace.id]!.toDosInToday,
        isEmpty,
      );
    });

    test('ToDoを今日といつかの間で切り替えると正しく反映される', () async {
      // ToDoを追加
      await container
          .read(todoProvider.notifier)
          .addTodo(testWorkspace, testTodo);

      // 最新のワークスペースを取得
      final workspaces = await container.read(workspacesProvider.future);
      final currentWorkspace = workspaces.firstWhere(
        (w) => w.id == testWorkspace.id,
      );
      final currentTodo =
          currentWorkspace
              .workspaceIDToToDos[currentWorkspace.id]!
              .toDosInToday[0];

      // ToDoを今日といつかの間で切り替え
      await container
          .read(todoProvider.notifier)
          .toggleTodoTodayWhenever(currentWorkspace, currentTodo);

      // 更新後のワークスペースを取得
      final updatedWorkspaces = await container.read(workspacesProvider.future);
      final updatedWorkspace = updatedWorkspaces.firstWhere(
        (w) => w.id == testWorkspace.id,
      );

      // 検証
      expect(
        updatedWorkspace.workspaceIDToToDos[updatedWorkspace.id]!.toDosInToday,
        isEmpty,
      );
      expect(
        updatedWorkspace
            .workspaceIDToToDos[updatedWorkspace.id]!
            .toDosInWhenever,
        isNotEmpty,
      );
      expect(
        updatedWorkspace
            .workspaceIDToToDos[updatedWorkspace.id]!
            .toDosInWhenever[0]
            .content,
        equals('Test Todo'),
      );
      expect(
        updatedWorkspace
            .workspaceIDToToDos[updatedWorkspace.id]!
            .toDosInWhenever[0]
            .isInToday,
        isFalse,
      );
    });

    test('ステップを追加したToDoを更新すると正しく反映される', () async {
      // ToDoを追加
      await container
          .read(todoProvider.notifier)
          .addTodo(testWorkspace, testTodo);

      // 最新のワークスペースを取得
      final workspaces = await container.read(workspacesProvider.future);
      final currentWorkspace = workspaces.firstWhere(
        (w) => w.id == testWorkspace.id,
      );
      final currentTodo =
          currentWorkspace
              .workspaceIDToToDos[currentWorkspace.id]!
              .toDosInToday[0];

      // ステップを追加したToDoを作成
      final step = TLStep(
        id: TLUUIDGenerator.generate(),
        content: 'Test Step',
        isChecked: false,
      );
      final todoWithStep = currentTodo.copyWith(steps: [step]);

      // ToDoを更新
      await container
          .read(todoProvider.notifier)
          .updateTodo(currentWorkspace, todoWithStep);

      // 更新後のワークスペースを取得
      final updatedWorkspaces = await container.read(workspacesProvider.future);
      final updatedWorkspace = updatedWorkspaces.firstWhere(
        (w) => w.id == testWorkspace.id,
      );

      // 検証
      expect(
        updatedWorkspace
            .workspaceIDToToDos[updatedWorkspace.id]!
            .toDosInToday[0]
            .steps,
        isNotEmpty,
      );
      expect(
        updatedWorkspace
            .workspaceIDToToDos[updatedWorkspace.id]!
            .toDosInToday[0]
            .steps[0]
            .content,
        equals('Test Step'),
      );
    });

    test('ステップのチェック状態を切り替えると正しく反映される', () async {
      // ステップを持つToDoを作成
      final step = TLStep(
        id: TLUUIDGenerator.generate(),
        content: 'Test Step',
        isChecked: false,
      );
      final todoWithStep = testTodo.copyWith(steps: [step]);

      // ToDoを追加
      await container
          .read(todoProvider.notifier)
          .addTodo(testWorkspace, todoWithStep);

      // 最新のワークスペースを取得
      final workspaces = await container.read(workspacesProvider.future);
      final currentWorkspace = workspaces.firstWhere(
        (w) => w.id == testWorkspace.id,
      );
      final currentTodo =
          currentWorkspace
              .workspaceIDToToDos[currentWorkspace.id]!
              .toDosInToday[0];
      final currentStep = currentTodo.steps[0];

      // ステップのチェック状態を切り替え
      await container
          .read(todoProvider.notifier)
          .toggleStepCheck(currentWorkspace, currentTodo, currentStep);

      // 更新後のワークスペースを取得
      final updatedWorkspaces = await container.read(workspacesProvider.future);
      final updatedWorkspace = updatedWorkspaces.firstWhere(
        (w) => w.id == testWorkspace.id,
      );

      // 検証
      expect(
        updatedWorkspace
            .workspaceIDToToDos[updatedWorkspace.id]!
            .toDosInToday[0]
            .steps[0]
            .isChecked,
        isTrue,
      );
    });

    test('チェック済みのToDoをすべて削除すると正しく反映される', () async {
      // チェック済みのToDoを作成
      final checkedTodo = testTodo.copyWith(isChecked: true);

      // チェックされていないToDoを作成
      final uncheckedTodo = TLToDo(
        id: TLUUIDGenerator.generate(),
        workspaceID: testWorkspace.id,
        content: 'Unchecked Todo',
        isInToday: true,
        isChecked: false,
        steps: [],
      );

      // 両方のToDoを追加
      await container
          .read(todoProvider.notifier)
          .addTodo(testWorkspace, checkedTodo);
      await container
          .read(todoProvider.notifier)
          .addTodo(testWorkspace, uncheckedTodo);

      // 最新のワークスペースを取得
      final workspaces = await container.read(workspacesProvider.future);
      final currentWorkspace = workspaces.firstWhere(
        (w) => w.id == testWorkspace.id,
      );

      // チェック済みのToDoをすべて削除
      await container
          .read(todoProvider.notifier)
          .deleteAllCheckedTodos(currentWorkspace, true);

      // 更新後のワークスペースを取得
      final updatedWorkspaces = await container.read(workspacesProvider.future);
      final updatedWorkspace = updatedWorkspaces.firstWhere(
        (w) => w.id == testWorkspace.id,
      );

      // 検証
      expect(
        updatedWorkspace
            .workspaceIDToToDos[updatedWorkspace.id]!
            .toDosInToday
            .length,
        equals(1),
      );
      expect(
        updatedWorkspace
            .workspaceIDToToDos[updatedWorkspace.id]!
            .toDosInToday[0]
            .content,
        equals('Unchecked Todo'),
      );
      expect(
        updatedWorkspace
            .workspaceIDToToDos[updatedWorkspace.id]!
            .toDosInToday[0]
            .isChecked,
        isFalse,
      );
    });
  });
}
