import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/flux/store/workspace_store.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/model/todo/tl_todos_in_today_and_whenever.dart';
import 'package:today_list/util/tl_uuid_generator.dart';

void main() {
  group('WorkspacesNotifier Tests', () {
    late ProviderContainer container;

    setUp(() async {
      // SharedPreferencesのモック設定
      SharedPreferences.setMockInitialValues({});

      // ProviderContainerの初期化
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('初期状態では初期ワークスペースが返される', () async {
      // テスト実行
      final workspaces = await container.read(workspacesProvider.future);

      // 検証
      expect(workspaces, isNotEmpty);
      expect(workspaces.length, equals(1)); // 初期ワークスペースは1つ
      expect(workspaces[0].name, equals('General'));
    });

    test('ワークスペースを追加すると状態が更新される', () async {
      // 初期状態を確認
      final initialWorkspaces = await container.read(workspacesProvider.future);
      final initialCount = initialWorkspaces.length;

      // 新しいワークスペースを作成
      final newWorkspaceId = TLUUIDGenerator.generate();
      final newWorkspace = TLWorkspace(
        id: newWorkspaceId,
        name: 'Test Workspace',
        toDos: TLToDosInTodayAndWhenever(
          workspaceID: newWorkspaceId,
          toDosInToday: [],
          toDosInWhenever: [],
        ),
      );

      // ワークスペースを追加
      await container
          .read(workspacesProvider.notifier)
          .addWorkspace(newWorkspace);

      // 変更後の状態を確認
      final updatedWorkspaces = await container.read(workspacesProvider.future);
      expect(updatedWorkspaces.length, equals(initialCount + 1));
      expect(updatedWorkspaces.last.id, equals(newWorkspaceId));
      expect(updatedWorkspaces.last.name, equals('Test Workspace'));
    });

    test('ワークスペースを更新すると状態が更新される', () async {
      // 初期状態を確認
      final initialWorkspaces = await container.read(workspacesProvider.future);
      final targetWorkspace = initialWorkspaces[0];

      // ワークスペースを更新
      final updatedWorkspace = targetWorkspace.copyWith(name: 'Updated Work');
      await container
          .read(workspacesProvider.notifier)
          .updateWorkspace(updatedWorkspace);

      // 変更後の状態を確認
      final updatedWorkspaces = await container.read(workspacesProvider.future);
      expect(updatedWorkspaces[0].id, equals(targetWorkspace.id));
      expect(updatedWorkspaces[0].name, equals('Updated Work'));
    });

    test('ワークスペースを削除すると状態が更新される', () async {
      // 初期状態を確認
      final initialWorkspaces = await container.read(workspacesProvider.future);
      final initialCount = initialWorkspaces.length;
      final targetWorkspaceId = initialWorkspaces[0].id;

      // ワークスペースを削除
      await container
          .read(workspacesProvider.notifier)
          .deleteWorkspace(targetWorkspaceId);

      // 変更後の状態を確認
      final updatedWorkspaces = await container.read(workspacesProvider.future);
      expect(updatedWorkspaces.length, equals(initialCount - 1));
      expect(updatedWorkspaces.any((w) => w.id == targetWorkspaceId), isFalse);
    });

    test('ワークスペースの並び替えが正しく機能する', () async {
      // 新しいワークスペースを追加
      final newWorkspaceId = TLUUIDGenerator.generate();
      final newWorkspace = TLWorkspace(
        id: newWorkspaceId,
        name: 'Second Workspace',
        toDos: TLToDosInTodayAndWhenever(
          workspaceID: newWorkspaceId,
          toDosInToday: [],
          toDosInWhenever: [],
        ),
      );

      // ワークスペースを追加
      await container
          .read(workspacesProvider.notifier)
          .addWorkspace(newWorkspace);

      // 初期状態を確認
      final initialWorkspaces = await container.read(workspacesProvider.future);
      final firstWorkspace = initialWorkspaces[0];
      final secondWorkspace = initialWorkspaces[1];

      // ワークスペースを並び替え (0番目と1番目を入れ替え)
      await container.read(workspacesProvider.notifier).reorderWorkspace(0, 1);

      // 変更後の状態を確認
      final updatedWorkspaces = await container.read(workspacesProvider.future);
      expect(updatedWorkspaces[0].id, equals(secondWorkspace.id));
      expect(updatedWorkspaces[1].id, equals(firstWorkspace.id));
    });

    test('ワークスペース変更後にアプリを再起動してもワークスペースが保持される', () async {
      // 初期状態を確認
      final initialWorkspaces = await container.read(workspacesProvider.future);
      final targetWorkspace = initialWorkspaces[0];

      // ワークスペースを更新
      final updatedWorkspace = targetWorkspace.copyWith(
        name: 'Persistent Work',
      );
      await container
          .read(workspacesProvider.notifier)
          .updateWorkspace(updatedWorkspace);

      // 新しいコンテナを作成して再起動をシミュレート
      final newContainer = ProviderContainer();

      // 保存されたワークスペースを確認
      final savedWorkspaces = await newContainer.read(
        workspacesProvider.future,
      );
      expect(savedWorkspaces[0].id, equals(targetWorkspace.id));
      expect(savedWorkspaces[0].name, equals('Persistent Work'));

      // リソース解放
      newContainer.dispose();
    });
  });
}
