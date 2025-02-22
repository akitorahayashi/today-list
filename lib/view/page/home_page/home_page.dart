import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:today_list/model/tl_app_state.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/action/tl_workspace_action.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/service/tl_vibration.dart';
import 'package:today_list/util/tl_workspace_utils.dart';
import 'package:today_list/view/component/common_ui_part/tl_bottom_navbar/center_button_of_bottom_navbar.dart';
import 'package:today_list/view/component/common_ui_part/tl_appbar.dart';
import 'package:today_list/view/component/common_ui_part/tl_bottom_navbar/tl_bottom_navbar.dart';
import 'package:today_list/view/component/dialog/common/tl_single_option_dialog.dart';
import 'package:today_list/view/component/dialog/common/tl_yes_no_dialog.dart';
import 'package:today_list/view/page/category_list_page/category_list_page.dart';
import 'package:today_list/view/page/edit_todo_page/edit_todo_page.dart';
import 'package:today_list/view/page/home_page/tab_content/todo_list_in_workspace_in_today_and_whenever.dart';
import 'package:today_list/view/page/home_page/tab_content/todo_list_of_all_workspaces_in_today.dart';
import 'package:today_list/view/page/setting_page/settings_page.dart';
import 'workspace_drawer/workspace_drawer.dart';

import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// MARK: - HomePage Widget
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

// MARK: - HomePage State
class _HomePageState extends ConsumerState<HomePage>
    with TickerProviderStateMixin {
  bool _accentColorIsNotChanged = true;
  late TabController _tabController;
  final GlobalKey<ScaffoldState> _homePageScaffoldKey =
      GlobalKey<ScaffoldState>();

  void _handleTabIndexChange(int index, WidgetRef ref, TLAppState tlAppState) {
    final newWorkspaceID = index == 0
        ? null
        : tlAppState.tlWorkspaces.elementAtOrNull(index - 1)?.id;

    ref.read(tlAppStateProvider.notifier).dispatchWorkspaceAction(
        TLWorkspaceAction.changeCurrentWorkspaceID(newWorkspaceID));
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_accentColorIsNotChanged) {
        _accentColorIsNotChanged = false;
        setState(() {});
        FlutterNativeSplash.remove();
      }
    });

    final tlAppState = ref.read(tlAppStateProvider);

    // TabControllerを初期化（initialIndexを設定）
    final length = tlAppState.tlWorkspaces.length + 1; // +1 は"Today"タブ分

    // 初回生成
    _tabController = TabController(
      length: length,
      vsync: this,
      initialIndex: 0,
    );

    _tabController.addListener(() {
      _handleTabIndexChange(_tabController.index, ref, tlAppState);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TLThemeConfig tlThemeConfig = TLTheme.of(context);
    final tlAppState = ref.watch(tlAppStateProvider);
    // 現在のWorkspaceを取得
    final TLWorkspace? currentWorkspaceNullAble = () {
      if (tlAppState.currentWorkspaceID == null) return null;
      final matches = tlAppState.tlWorkspaces
          .where((workspace) => workspace.id == tlAppState.currentWorkspaceID);
      return matches.isNotEmpty ? matches.first : null;
    }();

    // workspace数が増減して newLength と tabController.length が異なる場合は再生成する
    final newLength = tlAppState.tlWorkspaces.length + 1;
    if (_tabController.length != newLength) {
      _tabController.dispose(); // 古いのはdispose

      _tabController = TabController(
        length: newLength,
        vsync: this,
        // 今回は期待インデックスを使う or 既存の oldIndex と比較して安全に設定
        initialIndex: 0,
      );

      // リスナーを再設定
      _tabController.addListener(() {
        _handleTabIndexChange(_tabController.index, ref, tlAppState);
      });
    }

    // ビルド後にタブインデックスの調整を行う（アプリ起動時ぐらいで使用）
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 現在のWorkspaceのIndexを取得
      final currentWorkspaceIdx = tlAppState.tlWorkspaces.indexWhere(
          (workspace) => workspace.id == tlAppState.currentWorkspaceID);
      final expectedTabControllerIndex =
          currentWorkspaceIdx != -1 ? currentWorkspaceIdx + 1 : 0;
      if (_tabController.index != expectedTabControllerIndex) {
        _tabController.index = expectedTabControllerIndex;
      }
    });

    // currentWorkspaceを選択しているか
    final bool doesCurrentWorkspaceExist =
        currentWorkspaceNullAble != null ? true : false;

    return Scaffold(
      backgroundColor: tlThemeConfig.backgroundColor,
      key: _homePageScaffoldKey,
      drawer: const TLWorkspaceDrawer(),
      appBar: TLAppBar(
        context: context,
        height: 100,
        pageTitle: _tabController.index == 0
            ? "Today List"
            : currentWorkspaceNullAble?.name ?? "Error",
        leadingButtonOnPressed: () =>
            _homePageScaffoldKey.currentState!.openDrawer(),
        leadingIcon: const Icon(Icons.menu, color: Colors.white),
        trailingButtonOnPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const SettingsPage();
          }));
        },
        trailingIcon: const Icon(Icons.settings, color: Colors.white),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: tlThemeConfig.accentColor,
          unselectedLabelColor: Colors.white,
          indicator: BoxDecoration(
            color: tlThemeConfig.whiteBasedColor,
            borderRadius: BorderRadius.circular(8),
          ),
          indicatorSize: TabBarIndicatorSize.label,
          indicatorPadding: const EdgeInsets.symmetric(horizontal: -16),
          tabs: [
            const Tab(text: "Today"),
            for (TLWorkspace workspace in tlAppState.tlWorkspaces)
              Tab(text: workspace.name),
          ],
          onTap: (index) {
            _handleTabIndexChange(index, ref, tlAppState);
          },
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          const ToDoListOfAllWorkspacesInToday(),
          for (final workspace in tlAppState.tlWorkspaces)
            ToDoListInWorkspaceInTodayAndWhenever(corrWorkspace: workspace),
        ],
      ),
      // 以下の要素はcurrentWorkspaceが存在しない場合は表示しない
      bottomNavigationBar: _BottomNavbar(
        currentWorkspaceNullAble: currentWorkspaceNullAble,
        homePageScaffoldKey: _homePageScaffoldKey,
      ),
      floatingActionButton: doesCurrentWorkspaceExist
          ? CenterButtonOfBottomNavBar(
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return EditToDoPage(
                          corrWorkspace: currentWorkspaceNullAble,
                          ifInToday: true,
                          selectedBigCategoryID:
                              currentWorkspaceNullAble.bigCategories[0].id,
                          selectedSmallCategoryID: null,
                          editedToDoTitle: null,
                          indexOfEdittedTodo: null,
                        );
                      },
                    ),
                  ))
          : null,
      floatingActionButtonLocation: doesCurrentWorkspaceExist
          ? FloatingActionButtonLocation.centerDocked
          : null,
    );
  }
}

// MARK: - Bottom Navbar Widget
class _BottomNavbar extends ConsumerWidget {
  final GlobalKey<ScaffoldState> homePageScaffoldKey;
  final TLWorkspace? currentWorkspaceNullAble;

  const _BottomNavbar({
    required this.homePageScaffoldKey,
    required this.currentWorkspaceNullAble,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TLBottomNavBar(
      leadingIconData: FontAwesomeIcons.squareCheck,
      leadingButtonOnPressed: () => TLYesNoDialog(
        title: "チェック済みToDoを\n削除しますか?",
        message: null,
        yesAction: () async {
          Navigator.pop(context);
          if (currentWorkspaceNullAble != null) {
            // 該当するワークスペースのチェック済みToDo(Today + Whenever)を削除
            final TLWorkspace updatedWorkspace =
                await TLWorkspaceUtils.deleteCheckedToDosInTodayInAWorkspace(
              currentWorkspaceNullAble!,
              onlyToday: false,
            );
            // ワークスペースの更新
            ref.read(tlAppStateProvider.notifier).dispatchWorkspaceAction(
                TLWorkspaceAction.updateCorrWorkspace(updatedWorkspace));
          } else {
            // 全てのワークスペースのチェック済みToDo(Today)を削除
            // ワークスペースの更新
          }

          if (context.mounted) {
            const TLSingleOptionDialog(title: "削除が完了しました！")
                .show(context: context);
          }
          TLVibrationService.vibrate();
        },
      ).show(context: context),
      trailingIconData: FontAwesomeIcons.list,
      trailingButtonOnPressed: () {
        if (currentWorkspaceNullAble != null) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return CategoryListPage(corrWorkspace: currentWorkspaceNullAble!);
          }));
        } else {
          homePageScaffoldKey.currentState?.openDrawer();
        }
      },
    );
  }
}
