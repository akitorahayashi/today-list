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

  // -----------------------------
  // Tab Index Handling
  // -----------------------------

  /// スワイプ・タップなどで TabController の index が変わったときに呼ばれる
  void _onTabControllerIndexChanged() {
    // このリスナーはスワイプ途中にも発火しますが、
    // indexIsChanging が false のときに確定扱いとします
    final controller = _tabController;
    if (controller == null) return;

    if (!controller.indexIsChanging) {
      _handleTabIndexChange(controller.index, context);
    }
  }

  /// タブインデックスが変更されたときの共通処理（+タブ含む）
  void _handleTabIndexChange(int index, BuildContext context) {
    final tlAppState = ref.read(tlAppStateProvider);
    final plusTabIndex = tlAppState.tlWorkspaces.length + 1;

    // +タブが押された場合
    if (index == plusTabIndex) {
      const AddOrEditWorkspaceDialog(oldWorkspaceId: null)
          .show(context: context);

      // 「+」タブを押したらダイアログ後、前のタブに戻す
      _tabController?.index = _previousIndex;
      return;
    }

    // 前回のインデックスを更新
    _previousIndex = index;

    // 0 番目タブ -> Today
    // 1 番目以降 -> Workspace
    final newWorkspaceID = (index == 0)
        ? null
        : tlAppState.tlWorkspaces.elementAtOrNull(index - 1)?.id;

    ref
        .read(tlAppStateProvider.notifier)
        .updateState(TLAppStateAction.changeCurrentWorkspaceID(newWorkspaceID));
  }

  // -----------------------------
  // Helpers
  // -----------------------------

  /// 現在の Workspace (null の可能性あり)
  TLWorkspace? _getCurrentWorkspace(TLAppState tlAppState) {
    final currentID = tlAppState.currentWorkspaceID;
    if (currentID == null) return null;

    final filteredList =
        tlAppState.tlWorkspaces.where((ws) => ws.id == currentID);
    return filteredList.isNotEmpty ? filteredList.first : null;
  }

  /// ページタイトルを取得
  String _getPageTitle(TLAppState tlAppState, int currentTabIndex) {
    // TabController が無い場合のために fallback: 0 (Today)
    final index = currentTabIndex;
    if (index == 0) return "Today List";

    final currentWorkspace = _getCurrentWorkspace(tlAppState);
    return currentWorkspace?.name ?? "Error";
  }

  // -----------------------------
  // Leading/Trailing ボタン
  // -----------------------------

  /// 「削除」ボタン押下時の処理 (Yes/Noダイアログ → 削除実行)
  void _onLeadingButtonPressed({
    required BuildContext context,
    required bool doesCurrentWorkspaceExist,
    required TLWorkspace? currentWorkspace,
    required TLAppState tlAppState,
  }) {
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
              ));
          if (context.mounted) {
            const TLSingleOptionDialog(title: "Deletion completed")
                .show(context: context);
          }
        },
      ).show(context: context);
    }
  }

  /// 「カテゴリ一覧 or ドロワー」ボタン押下時の処理
  void _onTrailingButtonPressed({
    required BuildContext context,
    required bool doesCurrentWorkspaceExist,
    required TLAppState tlAppState,
  }) {
    if (doesCurrentWorkspaceExist) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return CategoryListPage(
          corrWorkspaceID: tlAppState.currentWorkspaceID!,
        );
      }));
    } else {
      _homePageScaffoldKey.currentState?.openDrawer();
    }
  }

  // -----------------------------
  // Build
  // -----------------------------
  @override
  Widget build(BuildContext context) {
    final tlAppState = ref.watch(tlAppStateProvider);
    final tlThemeConfig = TLTheme.of(context);

    // タブ数: Today(1) + ワークスペース数 + Plusタブ(1)
    final tabLength = tlAppState.tlWorkspaces.length + 2;

    // 現在のタブインデックスの初期値を計算
    final currentID = tlAppState.currentWorkspaceID;
    final currentWsIndex =
        tlAppState.tlWorkspaces.indexWhere((ws) => ws.id == currentID);
    final initialIndex = (currentWsIndex == -1) ? 0 : currentWsIndex + 1;

    // ここで DefaultTabController を用いてタブを管理
    return DefaultTabController(
      // length が変わるたびに新しいコントローラが生成されるよう Key を付与
      key: ValueKey(tabLength),
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
          final currentWorkspace = _getCurrentWorkspace(tlAppState);
          final doesCurrentWorkspaceExist = (currentWorkspace != null);

          // タイトル
          final pageTitle = _getPageTitle(tlAppState, currentIndex);

          final tabTextStyle = TextStyle(
            color: tlThemeConfig.whiteBasedColor,
            fontSize: 13.6,
            fontWeight: FontWeight.bold,
          );

          return Scaffold(
            key: _homePageScaffoldKey,
            backgroundColor: tlThemeConfig.backgroundColor,
            drawer: const TLWorkspaceDrawer(),
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
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: const EdgeInsets.symmetric(horizontal: -16),
                splashFactory: NoSplash.splashFactory,
                overlayColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.pressed) ||
                      states.contains(MaterialState.focused)) {
                    return Colors.transparent;
                  }
                  return null;
                }),
                // タップ時にも対応するため
                onTap: (index) {
                  // タップ直後に同期的に呼び出す
                  _handleTabIndexChange(index, context);
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
            body: TabBarView(
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
                context: context,
                doesCurrentWorkspaceExist: doesCurrentWorkspaceExist,
                currentWorkspace: currentWorkspace,
                tlAppState: tlAppState,
              ),
              trailingButtonOnPressed: () => _onTrailingButtonPressed(
                context: context,
                doesCurrentWorkspaceExist: doesCurrentWorkspaceExist,
                tlAppState: tlAppState,
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: CenterButtonOfHomeBottomNavBar(
              doesCurrentWorkspaceExist: doesCurrentWorkspaceExist,
            ),
          );
        },
      ),
    );
  }
}
