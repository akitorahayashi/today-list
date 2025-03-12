import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/flux/action/current_workspace_action.dart';
import 'package:today_list/flux/dispatcher/current_workspace_dispatcher.dart';
import 'package:today_list/flux/store/current_workspace_store.dart';
import 'package:today_list/flux/store/workspace_store.dart';
import 'package:today_list/main.dart';
import 'package:today_list/view/component/common_ui_part/tl_loading_indicator.dart';
import 'package:today_list/view/page/home_page/tab_content/todo_list_in_workspace_in_today_and_whenever.dart';
import 'package:today_list/view/page/home_page/tab_content/todo_list_of_all_workspaces_in_today.dart';
import 'package:today_list/view/page/home_page/tl_home_bottom_navbar/center_button_of_home_bottom_navbar.dart';
import 'package:today_list/view/page/home_page/tl_home_bottom_navbar/tl_home_bottom_navbar.dart';
import 'package:today_list/view/component/common_ui_part/tl_appbar.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/model/design/tl_theme_config.dart';
import 'package:today_list/util/device_util.dart';
import 'package:today_list/view/page/home_page/workspace_drawer/workspace_drawer.dart';
import 'package:today_list/view/page/home_page/helper/tl_home_page_helper.dart';

import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';

// MARK: - HomePage Widget
class HomePage extends ConsumerStatefulWidget {
  final String? initialWorkspaceId;

  const HomePage({super.key, this.initialWorkspaceId});

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
  late TabController _tabController;

  // ページタイトル
  String _pageTitle = "Today List";

  // アプリのライフサイクルオブザーバー
  _AppLifecycleObserver? _lifecycleObserver;

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();

    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_onTabControllerIndexChanged);

    // URLスキームからのワークスペースIDを処理
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _handleInitialWorkspaceId();
      _updatePageTitle();
    });

    // initialWorkspaceIdの変更を監視
    _setupWorkspaceIdListener();
  }

  // initialWorkspaceIdの変更を監視するメソッド
  void _setupWorkspaceIdListener() {
    // アプリがアクティブになったときに呼ばれるリスナーを追加
    final appLifecycleState = WidgetsBinding.instance.lifecycleState;
    if (appLifecycleState != null) {
      _lifecycleObserver = _AppLifecycleObserver(
        onResumed: () {
          // アプリがバックグラウンドから復帰したときにワークスペースIDを処理
          if (initialWorkspaceId != null) {
            _handleInitialWorkspaceId();
          }
        },
      );
      WidgetsBinding.instance.addObserver(_lifecycleObserver!);
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabControllerIndexChanged);
    _tabController.dispose();

    // ライフサイクルオブザーバーを解放
    if (_lifecycleObserver != null) {
      WidgetsBinding.instance.removeObserver(_lifecycleObserver!);
    }

    super.dispose();
  }

  // MARK: Tab Index Handling

  /// スワイプ・タップなどで TabController の index が変わったときに呼ばれる
  void _onTabControllerIndexChanged() {
    // このリスナーはスワイプ途中にも発火しますが、
    // indexIsChanging が false のときに確定扱いとします
    if (!_tabController.indexIsChanging) {
      _handleTabIndexChange(_tabController.index);
      _updatePageTitle();
    }
  }

  /// タブインデックスが変更されたときの共通処理
  void _handleTabIndexChange(int index) {
    // TLHomePageHelperに処理を委譲
    TLHomePageHelper.handleTabIndexChange(
      index: index,
      context: context,
      ref: ref,
      tabController: _tabController,
      previousIndex: _previousIndex,
      updatePreviousIndex: (value) => setState(() => _previousIndex = value),
    );
  }

  /// ページタイトルを更新
  Future<void> _updatePageTitle() async {
    final title = await TLHomePageHelper.getPageTitle(
      ref,
      _tabController.index,
    );
    setState(() {
      _pageTitle = title;
    });
  }

  // URLスキームからのワークスペースIDを処理するメソッド
  void _handleInitialWorkspaceId() {
    // コンストラクタから渡されたワークスペースIDを優先的に使用
    final workspaceId = widget.initialWorkspaceId ?? initialWorkspaceId;
    if (workspaceId != null && workspaceId.isNotEmpty) {
      // ワークスペースを切り替える
      CurrentWorkspaceDispatcher.dispatch(
        ref,
        CurrentWorkspaceAction.setCurrentWorkspaceId(workspaceId),
      );

      // ワークスペースタブに切り替える
      final workspacesAsync = ref.read(workspacesProvider);
      workspacesAsync.whenData((workspaces) {
        final workspaceIndex = workspaces.indexWhere(
          (ws) => ws.id == workspaceId,
        );
        if (workspaceIndex >= 0) {
          // ワークスペースのインデックス + 1 (Todayタブがあるため)
          final tabIndex = workspaceIndex + 1;

          // TabControllerのインデックスを設定
          if (_tabController.length > tabIndex) {
            _tabController.animateTo(tabIndex);
          }

          // 前回のインデックスを更新
          setState(() => _previousIndex = tabIndex);

          // ページタイトルを更新
          _updatePageTitle();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final workspacesAsync = ref.watch(workspacesProvider);
    final currentWorkspaceIdAsync = ref.watch(currentWorkspaceIdProvider);
    final tlThemeConfig = TLTheme.of(context);

    // iPadかどうかを判定
    final bool isIpad = DeviceUtil.isIpad(context);

    return workspacesAsync.when(
      data: (workspaces) {
        return currentWorkspaceIdAsync.when(
          data: (currentWorkspaceId) {
            // TabControllerの設定
            final tabCount = workspaces.length + 2; // ワークスペース数 + Todayタブ + +タブ
            if (_tabController.length != tabCount) {
              // 現在のインデックスを保存
              final currentIndex = _tabController.index;

              // TabControllerを初期化
              final oldController = _tabController;
              // リスナーを削除してから破棄
              oldController.removeListener(_onTabControllerIndexChanged);

              // 新しいTabControllerを作成（現在のインデックスを維持）
              _tabController = TabController(
                length: tabCount,
                vsync: this,
                initialIndex: currentIndex < tabCount ? currentIndex : 0,
              );
              _tabController.addListener(_onTabControllerIndexChanged);

              // 古いコントローラーを破棄
              oldController.dispose();
            }

            final tabTextStyle = TextStyle(
              color: tlThemeConfig.navigationTitleColor,
              fontSize: 13.6,
              fontWeight: FontWeight.bold,
            );

            // +タブへのスクロールを制限するカスタムスクロールフィジックス
            final plusTabIndex = workspaces.length + 1;
            final customScrollPhysics =
                TLHomePageHelper.createCustomTabBarScrollPhysics(
                  plusTabIndex: plusTabIndex,
                );

            // タブバーの共通設定
            final tabBar = TabBar(
              isScrollable: true,
              labelColor: tlThemeConfig.accentColor,
              unselectedLabelColor: tlThemeConfig.navigationTitleColor,
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
              controller: _tabController,
              tabs: [
                // 0番目 -> Today
                const Tab(text: "Today"),

                // Workspace分のタブ
                for (final ws in workspaces) Tab(text: ws.name),

                // +タブ
                const Tab(icon: Icon(Icons.add)),
              ],
            );

            // タブバービューの共通設定
            final tabBarView = TabBarView(
              controller: _tabController,
              // +タブへのスクロールを制限するカスタムスクロールフィジックス
              physics: customScrollPhysics,
              children: [
                // 0番目 (Today)
                const ToDoListOfAllWorkspacesInToday(),

                // Workspace分
                for (final ws in workspaces)
                  ToDoListInWorkspaceInTodayAndWhenever(corrWorkspace: ws),

                // 最後の +タブ -> ダミーコンテンツ
                const SizedBox.shrink(),
              ],
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
                    child: _buildScaffold(
                      context: context,
                      tlThemeConfig: tlThemeConfig,
                      currentWorkspaceId: currentWorkspaceId,
                      tabBar: tabBar,
                      tabBarView: tabBarView,
                      showDrawerButton: false, // iPadの場合は左側のボタンなし
                    ),
                  ),
                ],
              );
            }

            // スマートフォン向けの通常レイアウト
            return _buildScaffold(
              context: context,
              tlThemeConfig: tlThemeConfig,
              currentWorkspaceId: currentWorkspaceId,
              tabBar: tabBar,
              tabBarView: tabBarView,
              showDrawerButton: true, // スマホの場合はドロワーボタンを表示
            );
          },
          loading:
              () => Scaffold(
                backgroundColor: TLTheme.of(context).backgroundColor,
                body: const TLLoadingIndicator(),
              ),
          error:
              (error, stackTrace) => Scaffold(
                backgroundColor: TLTheme.of(context).backgroundColor,
                body: Center(child: Text('ワークスペースIDの読み込みに失敗しました: $error')),
              ),
        );
      },
      loading:
          () => const Scaffold(
            backgroundColor: Colors.white,
            body: TLLoadingIndicator(),
          ),
      error:
          (error, stackTrace) => Scaffold(
            backgroundColor: Colors.white,
            body: Center(child: Text('ワークスペースの読み込みに失敗しました: $error')),
          ),
    );
  }

  // Scaffoldを構築するヘルパーメソッド
  Widget _buildScaffold({
    required BuildContext context,
    required TLThemeConfig tlThemeConfig,
    required String? currentWorkspaceId,
    required TabBar tabBar,
    required TabBarView tabBarView,
    required bool showDrawerButton,
  }) {
    return Scaffold(
      key: _homePageScaffoldKey,
      backgroundColor: tlThemeConfig.backgroundColor,
      drawer: showDrawerButton ? const TLWorkspaceDrawer() : null,

      // MARK: App Bar
      appBar: TLAppBar(
        context: context,
        height: 100,
        pageTitle: _pageTitle,
        leadingButtonOnPressed:
            showDrawerButton
                ? () => _homePageScaffoldKey.currentState!.openDrawer()
                : null,
        leadingIconData: showDrawerButton ? Icons.menu : null,
        trailingButtonOnPressed: () {
          // GoRouterを使用して設定画面に遷移
          context.push('/settings');
        },
        trailingIconData: Icons.settings,
        bottom: tabBar,
      ),

      // MARK: TabBar View
      body: tabBarView,

      // MARK: Bottom Nav Bar
      bottomNavigationBar: const TLHomeBottomNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // MARK: Center Button
      floatingActionButton: CenterButtonOfHomeBottomNavBar(
        doesCurrentWorkspaceExist: currentWorkspaceId != null,
      ),
    );
  }
}

// アプリのライフサイクルを監視するクラス
class _AppLifecycleObserver extends WidgetsBindingObserver {
  final VoidCallback onResumed;

  _AppLifecycleObserver({required this.onResumed});

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      onResumed();
    }
  }
}
