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
        toDos: TLToDosInTodayAndWhenever(
          workspaceID: workspaceId,
          toDosInToday: [],
          toDosInWhenever: [],
        ),
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
      expect(updatedWorkspace.toDos.toDosInToday, isNotEmpty);
      expect(updatedWorkspace.toDos.toDosInToday.length, equals(1));
      expect(
        updatedWorkspace.toDos.toDosInToday[0].content,
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
        updatedWorkspace.toDos.toDosInToday[0].content,
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
      final currentTodo = currentWorkspace.toDos.toDosInToday[0];

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
      expect(updatedWorkspace.toDos.toDosInToday[0].isChecked, isTrue);
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
      final currentTodo = currentWorkspace.toDos.toDosInToday[0];

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
      expect(updatedWorkspace.toDos.toDosInToday, isEmpty);
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
      final currentTodo = currentWorkspace.toDos.toDosInToday[0];

      // ToDoを今日/いつかで切り替え
      await container
          .read(todoProvider.notifier)
          .toggleTodoTodayWhenever(currentWorkspace, currentTodo);

      // 更新後のワークスペースを取得
      final updatedWorkspaces = await container.read(workspacesProvider.future);
      final updatedWorkspace = updatedWorkspaces.firstWhere(
        (w) => w.id == testWorkspace.id,
      );

      // 検証
      expect(updatedWorkspace.toDos.toDosInToday, isEmpty);
      expect(updatedWorkspace.toDos.toDosInWhenever, isNotEmpty);
      expect(
        updatedWorkspace.toDos.toDosInWhenever[0].content,
        equals('Test Todo'),
      );
    });

    test('ステップを追加したToDoが正しく保存される', () async {
      // ステップを含むToDoを作成
      final todoWithSteps = testTodo.copyWith(
        steps: [
          TLStep(
            id: TLUUIDGenerator.generate(),
            content: 'Step 1',
            isChecked: false,
          ),
          TLStep(
            id: TLUUIDGenerator.generate(),
            content: 'Step 2',
            isChecked: false,
          ),
        ],
      );

      // ステップ付きToDoを追加
      await container
          .read(todoProvider.notifier)
          .addTodo(testWorkspace, todoWithSteps);

      // ワークスペースの状態を取得
      final workspaces = await container.read(workspacesProvider.future);
      final updatedWorkspace = workspaces.firstWhere(
        (w) => w.id == testWorkspace.id,
      );

      // 検証
      expect(updatedWorkspace.toDos.toDosInToday[0].steps.length, equals(2));
    });

    test('ステップのチェック状態を切り替えると正しく反映される', () async {
      // ステップを含むToDoを作成
      final todoWithSteps = testTodo.copyWith(
        steps: [
          TLStep(
            id: TLUUIDGenerator.generate(),
            content: 'Step 1',
            isChecked: false,
          ),
        ],
      );

      // ステップ付きToDoを追加
      await container
          .read(todoProvider.notifier)
          .addTodo(testWorkspace, todoWithSteps);

      // 最新のワークスペースを取得
      final workspaces = await container.read(workspacesProvider.future);
      final currentWorkspace = workspaces.firstWhere(
        (w) => w.id == testWorkspace.id,
      );
      final currentTodo = currentWorkspace.toDos.toDosInToday[0];
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
      expect(updatedWorkspace.toDos.toDosInToday[0].steps[0].isChecked, isTrue);
    });

    test('すべてのステップをチェックするとToDoもチェックされる', () async {
      // ステップを含むToDoを作成
      final todoWithSteps = testTodo.copyWith(
        steps: [
          TLStep(
            id: TLUUIDGenerator.generate(),
            content: 'Step 1',
            isChecked: false,
          ),
        ],
      );

      // ステップ付きToDoを追加
      await container
          .read(todoProvider.notifier)
          .addTodo(testWorkspace, todoWithSteps);

      // 最新のワークスペースを取得
      final workspaces = await container.read(workspacesProvider.future);
      final currentWorkspace = workspaces.firstWhere(
        (w) => w.id == testWorkspace.id,
      );
      final currentTodo = currentWorkspace.toDos.toDosInToday[0];
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
      expect(updatedWorkspace.toDos.toDosInToday[0].isChecked, isTrue);
    });

    test('ToDoを並べ替えると正しくワークスペースに反映される', () async {
      // 複数のToDoを追加
      final todo1 = testTodo.copyWith(content: 'Todo 1');
      final todo2 = TLToDo(
        id: TLUUIDGenerator.generate(),
        workspaceID: testWorkspace.id,
        content: 'Todo 2',
        isInToday: true,
        isChecked: false,
        steps: [],
      );

      await container.read(todoProvider.notifier).addTodo(testWorkspace, todo1);
      await container.read(todoProvider.notifier).addTodo(testWorkspace, todo2);

      // 最新のワークスペースを取得
      final workspaces = await container.read(workspacesProvider.future);
      final currentWorkspace = workspaces.firstWhere(
        (w) => w.id == testWorkspace.id,
      );
      final todos = currentWorkspace.toDos.toDosInToday;

      // ToDoを並べ替え
      await container
          .read(todoProvider.notifier)
          .reorderTodos(currentWorkspace, todos, 0, 1, '', true);

      // 更新後のワークスペースを取得
      final updatedWorkspaces = await container.read(workspacesProvider.future);
      final updatedWorkspace = updatedWorkspaces.firstWhere(
        (w) => w.id == testWorkspace.id,
      );

      // 検証
      expect(updatedWorkspace.toDos.toDosInToday[0].content, equals('Todo 2'));
      expect(updatedWorkspace.toDos.toDosInToday[1].content, equals('Todo 1'));
    });

    test('チェック済みのToDoをすべて削除すると正しく反映される', () async {
      // チェック済みToDoを追加
      final checkedTodo = testTodo.copyWith(isChecked: true);
      final uncheckedTodo = TLToDo(
        id: TLUUIDGenerator.generate(),
        workspaceID: testWorkspace.id,
        content: 'Unchecked Todo',
        isInToday: true,
        isChecked: false,
        steps: [],
      );

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

      // チェック済みToDoをすべて削除
      await container
          .read(todoProvider.notifier)
          .deleteAllCheckedTodos(currentWorkspace, true);

      // 更新後のワークスペースを取得
      final updatedWorkspaces = await container.read(workspacesProvider.future);
      final updatedWorkspace = updatedWorkspaces.firstWhere(
        (w) => w.id == testWorkspace.id,
      );

      // 検証
      expect(updatedWorkspace.toDos.toDosInToday.length, equals(1));
      expect(
        updatedWorkspace.toDos.toDosInToday[0].content,
        equals('Unchecked Todo'),
      );
    });

    test('ステップを並べ替えると正しくワークスペースに反映される', () async {
      // 複数のステップを含むToDoを作成
      final todoWithSteps = testTodo.copyWith(
        steps: [
          TLStep(
            id: TLUUIDGenerator.generate(),
            content: 'Step 1',
            isChecked: false,
          ),
          TLStep(
            id: TLUUIDGenerator.generate(),
            content: 'Step 2',
            isChecked: false,
          ),
        ],
      );

      // ステップ付きToDoを追加
      await container
          .read(todoProvider.notifier)
          .addTodo(testWorkspace, todoWithSteps);

      // 最新のワークスペースを取得
      final workspaces = await container.read(workspacesProvider.future);
      final currentWorkspace = workspaces.firstWhere(
        (w) => w.id == testWorkspace.id,
      );
      final currentTodo = currentWorkspace.toDos.toDosInToday[0];

      // ステップを並べ替え
      await container
          .read(todoProvider.notifier)
          .reorderSteps(currentWorkspace, currentTodo, 0, 1);

      // 更新後のワークスペースを取得
      final updatedWorkspaces = await container.read(workspacesProvider.future);
      final updatedWorkspace = updatedWorkspaces.firstWhere(
        (w) => w.id == testWorkspace.id,
      );

      // 検証
      expect(
        updatedWorkspace.toDos.toDosInToday[0].steps[0].content,
        equals('Step 2'),
      );
      expect(
        updatedWorkspace.toDos.toDosInToday[0].steps[1].content,
        equals('Step 1'),
      );
    });
  });
}
