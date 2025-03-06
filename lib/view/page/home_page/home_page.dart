import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/view/page/home_page/tab_content/todo_list_in_workspace_in_today_and_whenever.dart';
import 'package:today_list/view/page/home_page/tab_content/todo_list_of_all_workspaces_in_today.dart';
import 'package:today_list/view/page/home_page/tl_home_bottom_navbar/center_button_of_home_bottom_navbar.dart';
import 'package:today_list/view/page/home_page/tl_home_bottom_navbar/tl_home_bottom_navbar.dart';
import 'package:today_list/view/page/settings_page/settings_page.dart';
import 'package:today_list/view/component/common_ui_part/tl_appbar.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/view/page/home_page/helper/tl_home_page_helper.dart';
import 'package:today_list/util/device_util.dart';
import 'workspace_drawer/workspace_drawer.dart';

import 'package:flutter_native_splash/flutter_native_splash.dart';

// MARK: - HomePage Widget
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

// MARK: - HomePage State
class _HomePageState extends ConsumerState<HomePage>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _homePageScaffoldKey =
      GlobalKey<ScaffoldState>();

  // 前回のタブインデックスを保持
  int _previousIndex = 0;

  // 現在アタッチしている TabController
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

  @override
  void dispose() {
    _tabController?.removeListener(_onTabControllerIndexChanged);
    super.dispose();
  }

  // MARK: Tab Index Handling

  /// スワイプ・タップなどで TabController の index が変わったときに呼ばれる
  void _onTabControllerIndexChanged() {
    // このリスナーはスワイプ途中にも発火しますが、
    // indexIsChanging が false のときに確定扱いとします
    final controller = _tabController;
    if (controller == null) return;

    if (!controller.indexIsChanging) {
      _handleTabIndexChange(controller.index);
    }
  }

  /// タブインデックスが変更されたときの共通処理（+タブ含む）
  void _handleTabIndexChange(int index) {
    TLHomePageHelper.handleTabIndexChange(
      index: index,
      context: context,
      ref: ref,
      tabController: _tabController,
      previousIndex: _previousIndex,
      updatePreviousIndex: (value) => _previousIndex = value,
    );
  }

  // MARK: Buildメソッド
  @override
  Widget build(BuildContext context) {
    final tlAppState = ref.watch(tlAppStateProvider);
    final tlThemeConfig = TLTheme.of(context);

    // iPadかどうかを判定
    final bool isIpad = DeviceUtil.isIpad(context);

    // タブ数: Today(1) + ワークスペース数 + Plusタブ(1)
    final tabLength = tlAppState.tlWorkspaces.length + 2;
    // +タブのインデックス
    final plusTabIndex = tlAppState.tlWorkspaces.length + 1;

    // 現在のタブインデックスの初期値を計算
    final initialIndex = TLHomePageHelper.calculateInitialIndex(tlAppState);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 初回描画時に初期インデックスを設定
      if (_tabController?.index != initialIndex) {
        _tabController?.index = initialIndex;
      }
    });

    // ここで DefaultTabController を用いてタブを管理
    return DefaultTabController(
      // length が変わるたびに新しいコントローラが生成されるよう Key を付与
      key: ValueKey(tabLength.hashCode),
      length: tabLength,
      initialIndex: initialIndex,
      child: Builder(
        builder: (BuildContext ctx) {
          // ここで DefaultTabController が生成したコントローラを取得
          final newController = DefaultTabController.of(ctx);

          // まだアタッチしていない or 変わった場合は、古いリスナーを外し、新しいリスナーを付与
          if (_tabController != newController) {
            _tabController?.removeListener(_onTabControllerIndexChanged);
            _tabController = newController;
            _tabController?.addListener(_onTabControllerIndexChanged);
          }

          // 現在のインデックスを取得（リスナーが呼ばれる前の build タイミングで表示用に使う）
          final currentIndex = _tabController?.index ?? initialIndex;

          // Workspace (nullの可能性あり)
          final currentWorkspace =
              TLHomePageHelper.getCurrentWorkspace(tlAppState);
          final doesCurrentWorkspaceExist = (currentWorkspace != null);

          // タイトル
          final pageTitle =
              TLHomePageHelper.getPageTitle(tlAppState, currentIndex);

          final tabTextStyle = TextStyle(
            color: tlThemeConfig.whiteBasedColor,
            fontSize: 13.6,
            fontWeight: FontWeight.bold,
          );

          // iPadの場合はドロワーを常に表示するレイアウト
          if (isIpad) {
            return Row(
              children: [
                // 常に表示されるドロワー部分
                const SizedBox(
                  width: 280, // ドロワーの幅
                  child: TLWorkspaceDrawer(),
                ),
                // メインコンテンツ部分
                Expanded(
                  child: Scaffold(
                    key: _homePageScaffoldKey,
                    backgroundColor: tlThemeConfig.backgroundColor,
                    // MARK: App Bar (iPadの場合は左側のボタンなし)
                    appBar: TLAppBar(
                      context: context,
                      height: 100,
                      pageTitle: pageTitle,
                      leadingButtonOnPressed: null,
                      leadingIconData: null, // iPadの場合は左側のボタンなし
                      trailingButtonOnPressed: () async {
                        await Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const SettingsPage();
                        }));
                      },
                      trailingIconData: Icons.settings,
                      bottom: TabBar(
                        isScrollable: true,
                        labelColor: tlThemeConfig.accentColor,
                        unselectedLabelColor: Colors.white,
                        labelStyle: tabTextStyle,
                        unselectedLabelStyle: tabTextStyle,
                        indicator: BoxDecoration(
                          color: tlThemeConfig.whiteBasedColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        dividerColor: Colors.transparent,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorPadding:
                            const EdgeInsets.symmetric(horizontal: -16),
                        splashFactory: NoSplash.splashFactory,
                        overlayColor: WidgetStateProperty.resolveWith((states) {
                          if (states.contains(WidgetState.pressed) ||
                              states.contains(WidgetState.focused)) {
                            return Colors.transparent;
                          }
                          return null;
                        }),
                        // タップ時にも対応するため
                        onTap: (index) {
                          // タップ直後に同期的に呼び出す
                          _handleTabIndexChange(index);
                        },
                        tabs: [
                          // 0番目 -> Today
                          const Tab(text: "Today"),

                          // Workspace分のタブ
                          for (final ws in tlAppState.tlWorkspaces)
                            Tab(text: ws.name),

                          // +タブ
                          const Tab(icon: Icon(Icons.add)),
                        ],
                      ),
                    ),

                    // MARK: TabBar View
                    body: TabBarView(
                      // +タブへのスクロールを制限するカスタムスクロールフィジックス
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        // 0番目 (Today)
                        const ToDoListOfAllWorkspacesInToday(),

                        // Workspace分
                        for (final ws in tlAppState.tlWorkspaces)
                          ToDoListInWorkspaceInTodayAndWhenever(
                              corrWorkspace: ws),

                        // 最後の +タブ -> ダミーコンテンツ
                        Container(
                          color: Colors.grey.withValues(alpha: 0.2),
                          child: const Center(
                            child: Text(
                              "＋タブに対応する画面\n(必要に応じて自由に拡張)",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // MARK: Bottom Nav Bar
                    bottomNavigationBar: const TLHomeBottomNavBar(),
                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.centerDocked,
                    // MARK: Center Button
                    floatingActionButton: CenterButtonOfHomeBottomNavBar(
                      doesCurrentWorkspaceExist: doesCurrentWorkspaceExist,
                    ),
                  ),
                ),
              ],
            );
          }

          // スマートフォン向けの通常レイアウト
          return Scaffold(
            key: _homePageScaffoldKey,
            backgroundColor: tlThemeConfig.backgroundColor,
            drawer: const TLWorkspaceDrawer(),

            // MARK: App Bar
            appBar: TLAppBar(
              context: context,
              height: 100,
              pageTitle: pageTitle,
              leadingButtonOnPressed: () =>
                  _homePageScaffoldKey.currentState!.openDrawer(),
              leadingIconData: Icons.menu,
              trailingButtonOnPressed: () async {
                await Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return const SettingsPage();
                }));
              },
              trailingIconData: Icons.settings,
              bottom: TabBar(
                isScrollable: true,
                labelColor: tlThemeConfig.accentColor,
                unselectedLabelColor: Colors.white,
                labelStyle: tabTextStyle,
                unselectedLabelStyle: tabTextStyle,
                indicator: BoxDecoration(
                  color: tlThemeConfig.whiteBasedColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                dividerColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: const EdgeInsets.symmetric(horizontal: -16),
                splashFactory: NoSplash.splashFactory,
                overlayColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.pressed) ||
                      states.contains(WidgetState.focused)) {
                    return Colors.transparent;
                  }
                  return null;
                }),
                // タップ時にも対応するため
                onTap: (index) {
                  // タップ直後に同期的に呼び出す
                  _handleTabIndexChange(index);
                },
                tabs: [
                  // 0番目 -> Today
                  const Tab(text: "Today"),

                  // Workspace分のタブ
                  for (final ws in tlAppState.tlWorkspaces) Tab(text: ws.name),

                  // +タブ
                  const Tab(icon: Icon(Icons.add)),
                ],
              ),
            ),

            // MARK: TabBar View
            body: TabBarView(
              // +タブへのスクロールを制限するカスタムスクロールフィジックス
              physics: const NeverScrollableScrollPhysics(),
              children: [
                // 0番目 (Today)
                const ToDoListOfAllWorkspacesInToday(),

                // Workspace分
                for (final ws in tlAppState.tlWorkspaces)
                  ToDoListInWorkspaceInTodayAndWhenever(corrWorkspace: ws),

                // 最後の +タブ -> ダミーコンテンツ
                Container(
                  color: Colors.grey.withValues(alpha: 0.2),
                  child: const Center(
                    child: Text(
                      "＋タブに対応する画面\n(必要に応じて自由に拡張)",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            // MARK: Bottom Nav Bar
            bottomNavigationBar: const TLHomeBottomNavBar(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            // MARK: Center Button
            floatingActionButton: CenterButtonOfHomeBottomNavBar(
              doesCurrentWorkspaceExist: doesCurrentWorkspaceExist,
            ),
          );
        },
      ),
    );
  }
}
