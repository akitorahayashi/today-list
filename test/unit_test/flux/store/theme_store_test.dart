import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/flux/store/theme_store.dart';
import 'package:today_list/resource/tl_theme_type.dart';

void main() {
  group('ThemeNotifier Tests', () {
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

    test('初期状態ではデフォルトテーマ(notebook)が返される', () async {
      // テスト実行
      final themeType = await container.read(themeProvider.future);

      // 検証
      expect(themeType, equals(TLThemeType.notebook));
    });

    test('テーマを変更すると状態が更新される', () async {
      // 初期状態を確認
      final initialTheme = await container.read(themeProvider.future);
      expect(initialTheme, equals(TLThemeType.notebook));

      // テーマを変更
      await container
          .read(themeProvider.notifier)
          .changeTheme(TLThemeType.marineBlue);

      // 変更後の状態を確認
      final updatedTheme = await container.read(themeProvider.future);
      expect(updatedTheme, equals(TLThemeType.marineBlue));
    });

    test('テーマ変更後にアプリを再起動してもテーマが保持される', () async {
      // テーマを変更
      await container
          .read(themeProvider.notifier)
          .changeTheme(TLThemeType.cherryBlossom);

      // 新しいコンテナを作成して再起動をシミュレート
      final newContainer = ProviderContainer();

      // 保存されたテーマを確認
      final savedTheme = await newContainer.read(themeProvider.future);
      expect(savedTheme, equals(TLThemeType.cherryBlossom));

      // リソース解放
      newContainer.dispose();
    });
  });
}
