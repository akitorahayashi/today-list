import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/flux/store/current_workspace_store.dart';

void main() {
  group('CurrentWorkspaceIdNotifier Tests', () {
    late ProviderContainer container;

    setUp(() async {
      // SharedPreferencesのモックを設定
      SharedPreferences.setMockInitialValues({});

      // ProviderContainerの初期化
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('初期状態ではnullが返される', () async {
      // テスト実行
      final workspaceId = await container.read(
        currentWorkspaceIdProvider.future,
      );

      // 検証
      expect(workspaceId, isNull);
    });

    test('ワークスペースIDを設定すると状態が更新される', () async {
      // 初期状態を確認
      final initialId = await container.read(currentWorkspaceIdProvider.future);
      expect(initialId, isNull);

      // ワークスペースIDを設定
      const testId = 'test-workspace-id';
      await container
          .read(currentWorkspaceIdProvider.notifier)
          .setCurrentWorkspaceId(testId);

      // 変更後の状態を確認
      final updatedId = await container.read(currentWorkspaceIdProvider.future);
      expect(updatedId, equals(testId));
    });

    test('ワークスペースIDをnullに設定すると削除される', () async {
      // 初期設定
      const testId = 'test-workspace-id';
      await container
          .read(currentWorkspaceIdProvider.notifier)
          .setCurrentWorkspaceId(testId);

      // 設定されたことを確認
      final setId = await container.read(currentWorkspaceIdProvider.future);
      expect(setId, equals(testId));

      // nullに設定
      await container
          .read(currentWorkspaceIdProvider.notifier)
          .setCurrentWorkspaceId(null);

      // 削除されたことを確認
      final updatedId = await container.read(currentWorkspaceIdProvider.future);
      expect(updatedId, isNull);
    });

    test('ワークスペースID設定後にアプリを再起動してもIDが保持される', () async {
      // ワークスペースIDを設定
      const testId = 'test-workspace-id';
      await container
          .read(currentWorkspaceIdProvider.notifier)
          .setCurrentWorkspaceId(testId);

      // 新しいコンテナを作成して再起動をシミュレート
      final newContainer = ProviderContainer();

      // 保存されたIDを確認
      final savedId = await newContainer.read(
        currentWorkspaceIdProvider.future,
      );
      expect(savedId, equals(testId));

      // リソースを解放
      newContainer.dispose();
    });
  });
}
