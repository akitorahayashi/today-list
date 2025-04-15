import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:today_list/resource/tl_theme_type.dart';
import 'package:today_list/view/page/settings_page/set_features_page/theme_panel/show_selecting_theme_panel.dart';
import 'package:today_list/view/page/settings_page/set_features_page/theme_panel/show_not_selecting_theme_panel.dart';

void main() {
  testWidgets('現在選択中のテーマパネルが正しく表示される', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: Scaffold(body: ShowSelectingThemePanel())),
      ),
    );

    // テーマパネルが表示されていることを確認
    expect(find.byType(ShowSelectingThemePanel), findsOneWidget);

    // ProviderStorageを使用しているため、ロード中またはデータが表示されているかを確認
    // 実際のテストでは、テーマの名前やアイコンなど特定の要素を確認するとよい
  });

  testWidgets('選択可能なテーマパネルが正しく表示される', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: ShowNotSelectingThemePanel(
              corrThemeType: TLThemeType.limeGreen,
            ),
          ),
        ),
      ),
    );

    // テーマパネルが表示されていることを確認
    expect(find.byType(ShowNotSelectingThemePanel), findsOneWidget);

    // ライムグリーンテーマの情報が表示されているか確認
    // テーマ名が表示されているか（ただし実装によって異なる可能性がある）
    expect(find.text('Lime\nGreen'), findsOneWidget);
  });

  testWidgets('テーマパネルをタップしたときの挙動', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: ShowNotSelectingThemePanel(
              corrThemeType: TLThemeType.limeGreen,
            ),
          ),
        ),
      ),
    );

    // タップ前の状態を確認

    // パネルをタップ
    await tester.tap(find.byType(ShowNotSelectingThemePanel));
    await tester.pumpAndSettle();

    // タップ後の状態確認
    // この確認は、実際の挙動（モーダル表示やテーマ変更など）によって異なる
    // 例えば、プログレスインジケータが表示されるか、新しいダイアログが表示されるかなど
  });

  // オプション: パネルの見た目の検証
  testWidgets('テーマパネルの視覚的なスタイル確認', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: Container(
              color: Colors.white,
              child: ShowNotSelectingThemePanel(
                corrThemeType: TLThemeType.limeGreen,
              ),
            ),
          ),
        ),
      ),
    );

    // パネルのサイズや色などを確認
    // 例: パネル内のカードが存在するか
    expect(find.byType(Card), findsWidgets);
  });
}
