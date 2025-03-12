import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/flux/store/user_data_store.dart';
import 'package:today_list/model/settings_data/selected_check_box_icon_data.dart';

void main() {
  group('UserDataNotifier Tests', () {
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

    test('初期状態ではデフォルトのユーザーデータが返される', () async {
      // テスト実行
      final userData = await container.read(userDataProvider.future);

      // 検証
      expect(userData.currentAppIconName, equals('Notebook'));
      expect(userData.selectedCheckBoxIconData.iconCategory, equals('Default'));
      expect(userData.selectedCheckBoxIconData.iconName, equals('Box'));
      expect(userData.earnedCheckBoxIcons, isNotEmpty);
      expect(userData.earnedCheckBoxIcons['Default'], contains('Box'));
      expect(userData.earnedCheckBoxIcons['Default'], contains('Circle'));
    });

    test('選択されたチェックボックスアイコンプロバイダーが正しく動作する', () async {
      // テスト実行
      final selectedIcon = container.read(selectedCheckBoxIconProvider);

      // 検証
      expect(selectedIcon.iconCategory, equals('Default'));
      expect(selectedIcon.iconName, equals('Box'));
    });

    test('チェックボックスアイコンを更新すると状態が更新される', () async {
      // 初期状態を確認
      final initialUserData = await container.read(userDataProvider.future);
      expect(initialUserData.selectedCheckBoxIconData.iconName, equals('Box'));

      // 新しいアイコンデータ
      const newIconData = SelectedCheckBoxIconData(
        iconCategory: 'Default',
        iconName: 'Circle',
      );

      // アイコンを更新
      await container
          .read(userDataProvider.notifier)
          .updateSelectedCheckBoxIcon(newIconData);

      // 変更後の状態を確認
      final updatedUserData = await container.read(userDataProvider.future);
      expect(
        updatedUserData.selectedCheckBoxIconData.iconCategory,
        equals('Default'),
      );
      expect(
        updatedUserData.selectedCheckBoxIconData.iconName,
        equals('Circle'),
      );
    });

    test('獲得したアイコンを更新すると状態が更新される', () async {
      // 初期状態を確認
      final initialUserData = await container.read(userDataProvider.future);
      expect(initialUserData.earnedCheckBoxIcons['Default'], isNotNull);
      expect(
        initialUserData.earnedCheckBoxIcons['Default']!.contains('Star'),
        isFalse,
      );

      // アイコンを獲得
      await container
          .read(userDataProvider.notifier)
          .updateEarnedIcons('Default', 'Star');

      // 変更後の状態を確認
      final updatedUserData = await container.read(userDataProvider.future);
      expect(updatedUserData.earnedCheckBoxIcons['Default'], contains('Star'));
    });
    test('アプリアイコン名を更新すると状態が更新される', () async {
      // 初期状態を確認
      final initialUserData = await container.read(userDataProvider.future);
      expect(initialUserData.currentAppIconName, equals('Notebook'));

      // アプリアイコン名を更新
      const newThemeName = 'Cherry Blossom';
      await container
          .read(userDataProvider.notifier)
          .updateCurrentAppIconName(newThemeName);

      // 変更後の状態を確認
      final updatedUserData = await container.read(userDataProvider.future);
      expect(updatedUserData.currentAppIconName, equals(newThemeName));
    });
  });
}
