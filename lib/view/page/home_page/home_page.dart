import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/view/component/dialog/for_workspace/add_or_edit_workspace_dialog.dart';
import 'package:today_list/view/page/home_page/tab_content/todo_list_in_workspace_in_today_and_whenever.dart';
import 'package:today_list/view/page/home_page/tab_content/todo_list_of_all_workspaces_in_today.dart';
import 'package:today_list/view/page/home_page/tl_home_bottom_navbar/center_button_of_home_bottom_navbar.dart';
import 'package:today_list/view/page/home_page/tl_home_bottom_navbar/tl_home_bottom_navbar.dart';
import 'package:today_list/view/page/category_list_page/category_list_page.dart';
import 'package:today_list/view/page/setting_page/settings_page.dart';
import 'package:today_list/view/component/common_ui_part/tl_appbar.dart';
import 'package:today_list/view/component/dialog/common/tl_single_option_dialog.dart';
import 'package:today_list/view/component/dialog/common/tl_yes_no_dialog.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:today_list/model/tl_app_state.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/action/tl_app_state_action.dart';
import 'package:today_list/redux/action/tl_workspace_action.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
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
  late TabController _tabController;
  final GlobalKey<ScaffoldState> _homePageScaffoldKey =
      GlobalKey<ScaffoldState>();
  // + タブに対して
  int _previousIndex = 0; // タップ前のインデックスを保持

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();

    final tlAppState = ref.read(tlAppStateProvider);
    _initTabController(tlAppState);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  /// タブインデックスを変更したときの処理
  /// 「+タブ」が押されたら print() を実行し、Today タブに戻す
  void _handleTabIndexChange(int index, WidgetRef ref, TLAppState tlAppState) {
    final plusTabIndex = tlAppState.tlWorkspaces.length + 1;
    if (index == plusTabIndex) {
      // +タブが押された場合
      const AddOrEditWorkspaceDialog(oldWorkspaceId: null)
          .show(context: context);
      _tabController.index = _previousIndex; // タップ前のインデックスに戻す
      return;
    }

    // 記録
    _previousIndex = index;

    // 0番目タブ → Today
    // 1番目以降 → Workspace
    final newWorkspaceID = (index == 0)
        ? null
        : tlAppState.tlWorkspaces.elementAtOrNull(index - 1)?.id;

    ref
        .read(tlAppStateProvider.notifier)
        .updateState(TLAppStateAction.changeCurrentWorkspaceID(newWorkspaceID));
  }

  /// TabController の初期設定
  void _initTabController(TLAppState tlAppState) {
    // 「Today」 + ワークスペース数 + 「+タブ」
    final length = tlAppState.tlWorkspaces.length + 2;

    _tabController = TabController(
      length: length,
      vsync: this,
      initialIndex: 0,
    );

    // スワイプなども拾うため、リスナーを設定
    _tabController.addListener(() {
      // スワイプ中は indexIsChanging=true の間も変化するため、
      // 完了後に確定した index を処理
      if (!_tabController.indexIsChanging) {
        _handleTabIndexChange(_tabController.index, ref, tlAppState);
      }
    });
  }

  /// Workspaceが増減したら TabController を再生成する
  void _updateTabControllerIfNeeded(TLAppState tlAppState) {
    final newLength = tlAppState.tlWorkspaces.length + 2;
    if (_tabController.length == newLength) return;
    _tabController.dispose();
    _initTabController(tlAppState);
  }

  /// 現在の Workspace (null の可能性あり)
  TLWorkspace? _getCurrentWorkspace(TLAppState tlAppState) {
    final currentID = tlAppState.currentWorkspaceID;
    if (currentID == null) return null;

    final filteredList =
        tlAppState.tlWorkspaces.where((ws) => ws.id == currentID);
    return filteredList.isNotEmpty ? filteredList.first : null;
  }

  /// ビルド後にタブインデックスを再調整 (初期表示時など)
  void _adjustTabIndexAfterBuild(TLAppState tlAppState) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentWorkspaceIdx = tlAppState.tlWorkspaces
          .indexWhere((ws) => ws.id == tlAppState.currentWorkspaceID);
      final expectedIndex =
          (currentWorkspaceIdx != -1) ? currentWorkspaceIdx + 1 : 0; // Today

      if (_tabController.index != expectedIndex) {
        _tabController.index = expectedIndex;
        setState(() {});
      }
    });
  }

  /// ページタイトルを取得
  String _getPageTitle(TLAppState tlAppState) {
    final currentWorkspace = _getCurrentWorkspace(tlAppState);
    return (_tabController.index == 0)
        ? "Today List"
        : (currentWorkspace?.name ?? "Error");
  }

  /// 「削除」ボタン押下時の処理 (Yes/Noダイアログ→削除実行)
  void _onLeadingButtonPressed(
    BuildContext context,
    bool doesCurrentWorkspaceExist,
    TLWorkspace? currentWorkspace,
    TLAppState tlAppState,
  ) {
    if (doesCurrentWorkspaceExist) {
      TLYesNoDialog(
        title: "Do you want to delete\nchecked ToDos?",
        message: null,
        yesAction: () async {
          Navigator.pop(context);
          ref.read(tlAppStateProvider.notifier).updateState(
                TLWorkspaceAction.deleteAllCheckedToDosInWorkspace(
                    currentWorkspace!),
              );
          if (context.mounted) {
            const TLSingleOptionDialog(title: "Deletion completed")
                .show(context: context);
          }
        },
      ).show(context: context);
    } else {
      TLYesNoDialog(
        title: "Do you want to delete\nchecked ToDos?",
        message: null,
        yesAction: () async {
          Navigator.pop(context);
          ref.read(tlAppStateProvider.notifier).updateState(
                TLAppStateAction.deleteAllCheckedToDosInTodayInWorkspaceList(
                  tlAppState.tlWorkspaces,
                ),
              );
          if (context.mounted) {
            const TLSingleOptionDialog(title: "Deletion completed")
                .show(context: context);
          }
        },
      ).show(context: context);
    }
  }

  /// 「カテゴリ一覧 or ドロワー」ボタン押下時の処理
  void _onTrailingButtonPressed(
    BuildContext context,
    bool doesCurrentWorkspaceExist,
    TLAppState tlAppState,
  ) {
    if (doesCurrentWorkspaceExist) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return CategoryListPage(
            corrWorkspaceID: tlAppState.currentWorkspaceID!);
      }));
    } else {
      _homePageScaffoldKey.currentState?.openDrawer();
    }
  }

  @override
  Widget build(BuildContext context) {
    final tlThemeConfig = TLTheme.of(context);
    final tlAppState = ref.watch(tlAppStateProvider);

    // Workspace数が変化した場合に TabController を再生成
    _updateTabControllerIfNeeded(tlAppState);

    // ビルド後にタブインデックスを再調整
    _adjustTabIndexAfterBuild(tlAppState);

    // タイトル
    final pageTitle = _getPageTitle(tlAppState);

    // 現在のWorkspace (nullの可能性あり)
    final currentWorkspace = _getCurrentWorkspace(tlAppState);

    // Workspaceがあるかどうか
    final doesCurrentWorkspaceExist = (currentWorkspace != null);

    final tabTextStyle = TextStyle(
      color: tlThemeConfig.whiteBasedColor,
      fontSize: 13.6,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      backgroundColor: tlThemeConfig.backgroundColor,
      key: _homePageScaffoldKey,
      drawer: const TLWorkspaceDrawer(),
      appBar: TLAppBar(
        context: context,
        height: 100,
        pageTitle: pageTitle,
        leadingButtonOnPressed: () =>
            _homePageScaffoldKey.currentState!.openDrawer(),
        leadingIconData: Icons.menu,
        trailingButtonOnPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const SettingsPage();
          }));
        },
        trailingIconData: Icons.settings,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: tlThemeConfig.accentColor,
          unselectedLabelColor: Colors.white,
          labelStyle: tabTextStyle,
          unselectedLabelStyle: tabTextStyle,
          indicator: BoxDecoration(
            color: tlThemeConfig.whiteBasedColor,
            borderRadius: BorderRadius.circular(8),
          ),
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
          tabs: [
            // 0番目 -> Today
            const Tab(text: "Today"),

            // Workspace分のタブ
            for (final ws in tlAppState.tlWorkspaces) Tab(text: ws.name),

            // +タブ
            const Tab(icon: Icon(Icons.add)),
          ],
          // タップ時にも対応するため
          onTap: (index) {
            // スワイプ中は .addListener() 側で対応するが
            // タップ時はここで同期的に呼び出し
            _handleTabIndexChange(index, ref, tlAppState);
          },
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // 0番目 (Today)
          const ToDoListOfAllWorkspacesInToday(),

          // Workspace分
          for (final ws in tlAppState.tlWorkspaces)
            ToDoListInWorkspaceInTodayAndWhenever(corrWorkspace: ws),

          // 最後の +タブ -> ダミーコンテンツ
          Container(
            color: Colors.grey.withOpacity(0.2),
            child: const Center(
              child: Text(
                "＋タブに対応する画面\n(必要に応じて自由に拡張)",
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: TLHomeBottomNavBar(
        doesCurrentWorkspaceExist: doesCurrentWorkspaceExist,
        leadingButtonOnPressed: () => _onLeadingButtonPressed(
          context,
          doesCurrentWorkspaceExist,
          currentWorkspace,
          tlAppState,
        ),
        trailingButtonOnPressed: () => _onTrailingButtonPressed(
          context,
          doesCurrentWorkspaceExist,
          tlAppState,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CenterButtonOfHomeBottomNavBar(
        doesCurrentWorkspaceExist: doesCurrentWorkspaceExist,
      ),
    );
  }
}
