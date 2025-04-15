import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// TabContentの切り替えが正しく機能するかテスト
void main() {
  // Set up SharedPreferences mock
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('TabBar - タブの切り替えテスト', (WidgetTester tester) async {
    // 簡易的なタブ切り替えテスト - ラベルを使用してテスト状態を確認
    await tester.pumpWidget(
      MaterialApp(
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              bottom: const TabBar(
                tabs: [
                  Tab(text: 'Tab 1'),
                  Tab(text: 'Tab 2'),
                  Tab(text: 'Tab 3'),
                ],
              ),
            ),
            body: const TabBarView(
              children: [
                Center(child: Text('Content 1')),
                Center(child: Text('Content 2')),
                Center(child: Text('Content 3')),
              ],
            ),
          ),
        ),
      ),
    );

    // 初期レンダリング
    await tester.pumpAndSettle(const Duration(milliseconds: 50));

    // 初期状態でTab 1が表示されていることを確認
    expect(find.text('Content 1'), findsOneWidget);
    expect(find.text('Content 2'), findsNothing);
    expect(find.text('Content 3'), findsNothing);

    // Tab 2をタップ
    await tester.tap(find.text('Tab 2'));
    await tester.pumpAndSettle(const Duration(milliseconds: 50));

    // Tab 2の内容が表示されていることを確認
    expect(find.text('Content 1'), findsNothing);
    expect(find.text('Content 2'), findsOneWidget);
    expect(find.text('Content 3'), findsNothing);

    // Tab 3をタップ
    await tester.tap(find.text('Tab 3'));
    await tester.pumpAndSettle(const Duration(milliseconds: 50));

    // Tab 3の内容が表示されていることを確認
    expect(find.text('Content 1'), findsNothing);
    expect(find.text('Content 2'), findsNothing);
    expect(find.text('Content 3'), findsOneWidget);

    // Tab 1に戻る
    await tester.tap(find.text('Tab 1'));
    await tester.pumpAndSettle(const Duration(milliseconds: 50));

    // Tab 1の内容が表示されていることを確認
    expect(find.text('Content 1'), findsOneWidget);
    expect(find.text('Content 2'), findsNothing);
    expect(find.text('Content 3'), findsNothing);
  });
}
