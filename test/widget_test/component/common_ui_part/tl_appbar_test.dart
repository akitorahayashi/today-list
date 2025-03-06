import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/model/design/tl_theme_config.dart';
import 'package:today_list/resource/tl_theme_type.dart';
import 'package:today_list/view/component/common_ui_part/tl_animated_icon_button.dart';
import 'package:today_list/view/component/common_ui_part/tl_appbar.dart';

void main() {
  // モックのTLThemeConfigを作成
  final mockThemeConfig = TLThemeConfig(
    themeName: 'Mock Theme',
    themeTitleInSettings: 'Mock Theme',
    titleColorOfSettingPage: Colors.blue,
    settingPanelColor: Colors.white,
    backgroundColor: Colors.white,
    gradientOfNavBar: const LinearGradient(
      colors: [Colors.blue, Colors.lightBlue],
    ),
    otherAppsElevatedButtonColor: Colors.blue,
    otherAppsPressedElevatedButtonColor: Colors.lightBlue,
    accentColor: Colors.blue,
    canTapCardColor: Colors.blue,
    whiteBasedColor: Colors.white,
    tlDoubleCardBorderColor: Colors.grey,
    checkmarkColor: Colors.green,
    alertBackgroundColor: Colors.red,
    bigCategoryChipColor: Colors.amber,
    toggleButtonsBackgroundColor: Colors.grey,
    toggleButtonsBackgroundSplashColor: Colors.grey.shade300,
  );

  testWidgets('TLAppBar renders with title', (WidgetTester tester) async {
    int leadingTapCount = 0;
    int trailingTapCount = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: TLTheme(
          data: mockThemeConfig,
          child: Builder(
            builder: (context) => Scaffold(
              appBar: TLAppBar(
                context: context,
                pageTitle: 'Test Title',
                leadingIconData: Icons.arrow_back,
                leadingButtonOnPressed: () {
                  leadingTapCount++;
                },
                trailingIconData: Icons.settings,
                trailingButtonOnPressed: () {
                  trailingTapCount++;
                },
              ),
              body: const Center(child: Text('Test Body')),
            ),
          ),
        ),
      ),
    );

    // AppBarが存在することを確認
    expect(find.byType(AppBar), findsOneWidget);

    // タイトルが表示されていることを確認
    expect(find.text('Test Title'), findsOneWidget);

    // アイコンボタンが存在することを確認
    expect(find.byType(TLAnimatedIconButton), findsAtLeastNWidgets(2));

    // 戻るボタンをタップ
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pump();
    expect(leadingTapCount, 1);

    // 設定ボタンをタップ
    await tester.tap(find.byIcon(Icons.settings));
    await tester.pump();
    expect(trailingTapCount, 1);
  });

  testWidgets('TLAppBar renders with custom height',
      (WidgetTester tester) async {
    const double customHeight = 80.0;

    await tester.pumpWidget(
      MaterialApp(
        home: TLTheme(
          data: mockThemeConfig,
          child: Builder(
            builder: (context) => Scaffold(
              appBar: TLAppBar(
                context: context,
                pageTitle: 'Test Title',
                height: customHeight,
                leadingIconData: Icons.arrow_back,
                leadingButtonOnPressed: () {},
                trailingIconData: Icons.settings,
                trailingButtonOnPressed: () {},
              ),
              body: const Center(child: Text('Test Body')),
            ),
          ),
        ),
      ),
    );

    // AppBarが存在することを確認
    expect(find.byType(AppBar), findsOneWidget);

    // カスタム高さが設定されていることを確認
    final TLAppBar appBar = tester.widget<TLAppBar>(find.byType(TLAppBar));
    expect(appBar.preferredSize.height, customHeight);
  });

  testWidgets('TLAppBar renders with trailing icons list',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: TLTheme(
          data: mockThemeConfig,
          child: Builder(
            builder: (context) => Scaffold(
              appBar: TLAppBar(
                context: context,
                pageTitle: 'Test Title',
                leadingIconData: Icons.arrow_back,
                leadingButtonOnPressed: () {},
                trailingIconData: null,
                trailingButtonOnPressed: null,
                trailingIcons: [
                  IconButton(
                      icon: const Icon(Icons.favorite), onPressed: () {}),
                  IconButton(icon: const Icon(Icons.share), onPressed: () {}),
                ],
              ),
              body: const Center(child: Text('Test Body')),
            ),
          ),
        ),
      ),
    );

    // AppBarが存在することを確認
    expect(find.byType(AppBar), findsOneWidget);

    // 複数のトレイリングアイコンが表示されていることを確認
    expect(find.byIcon(Icons.favorite), findsOneWidget);
    expect(find.byIcon(Icons.share), findsOneWidget);
  });

  testWidgets('TLAppBar renders with bottom widget',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: DefaultTabController(
          length: 3,
          child: TLTheme(
            data: mockThemeConfig,
            child: Builder(
              builder: (context) => Scaffold(
                appBar: TLAppBar(
                  context: context,
                  pageTitle: 'Test Title',
                  leadingIconData: Icons.arrow_back,
                  leadingButtonOnPressed: () {},
                  trailingIconData: Icons.settings,
                  trailingButtonOnPressed: () {},
                  bottom: const TabBar(
                    tabs: [
                      Tab(icon: Icon(Icons.directions_car)),
                      Tab(icon: Icon(Icons.directions_transit)),
                      Tab(icon: Icon(Icons.directions_bike)),
                    ],
                  ),
                ),
                body: const TabBarView(
                  children: [
                    Center(child: Text('Car')),
                    Center(child: Text('Transit')),
                    Center(child: Text('Bike')),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

    // AppBarが存在することを確認
    expect(find.byType(AppBar), findsOneWidget);

    // TabBarが存在することを確認
    expect(find.byType(TabBar), findsOneWidget);

    // タブアイコンが表示されていることを確認
    expect(find.byIcon(Icons.directions_car), findsOneWidget);
    expect(find.byIcon(Icons.directions_transit), findsOneWidget);
    expect(find.byIcon(Icons.directions_bike), findsOneWidget);
  });
}
