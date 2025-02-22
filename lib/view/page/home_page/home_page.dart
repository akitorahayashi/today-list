import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
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
import 'package:today_list/view/page/setting_page/settings_page.dart';
import 'workspace_drawer/workspace_drawer.dart';
import 'build_todo_list/num_todos_card.dart';
import 'build_todo_list/list_of_category_to_todos.dart';

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
  final GlobalKey<ScaffoldState> homePageScaffoldKey =
      GlobalKey<ScaffoldState>();

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
    _tabController =
        TabController(length: tlAppState.tlWorkspaces.length + 1, vsync: this);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        ref.read(tlAppStateProvider.notifier).dispatchWorkspaceAction(
            TLWorkspaceAction.changeCurrentWorkspaceID(
                tlAppState.tlWorkspaces[_tabController.index - 1].id));
      }
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
    final String? currentWorkspaceID = ref
        .watch(tlAppStateProvider.select((state) => state.currentWorkspaceID));
    final TLWorkspace? currentWorkspaceNullAble =
        tlAppState.getCorrWorkspace(currentWorkspaceID);

    final currentWorkspaceIdx = tlAppState.tlWorkspaces
        .indexWhere((workspace) => workspace.id == currentWorkspaceID);
    if (currentWorkspaceIdx != -1 &&
        _tabController.index != currentWorkspaceIdx) {
      Future.microtask(() {
        _tabController.animateTo(currentWorkspaceIdx);
      });
    }

    // currentWorkspaceを選択しているか
    final bool doesCurrentWorkspaceExist =
        currentWorkspaceNullAble != null ? true : false;

    return DefaultTabController(
      length: tlAppState.tlWorkspaces.length + 1,
      child: Scaffold(
        backgroundColor: tlThemeConfig.backgroundColor,
        key: homePageScaffoldKey,
        drawer: const TLWorkspaceDrawer(isContentMode: false),
        appBar: TLAppBar(
          context: context,
          height: 100,
          pageTitle: currentWorkspaceNullAble?.name ?? "Today List",
          leadingButtonOnPressed: () =>
              homePageScaffoldKey.currentState!.openDrawer(),
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
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              const Tab(text: "Today"),
              for (TLWorkspace workspace in tlAppState.tlWorkspaces)
                Tab(text: workspace.name),
            ],
            onTap: (index) {
              if (index != 0) {
                ref.read(tlAppStateProvider.notifier).dispatchWorkspaceAction(
                    const TLWorkspaceAction.changeCurrentWorkspaceID(null));
              } else {
                ref.read(tlAppStateProvider.notifier).dispatchWorkspaceAction(
                    TLWorkspaceAction.changeCurrentWorkspaceID(
                        tlAppState.tlWorkspaces[index].id));
              }
            },
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            for (final workspace in tlAppState.tlWorkspaces)
              _TodoListInTodayAndWhenever(corrWorkspace: workspace),
          ],
        ),
        // 以下の要素はcurrentWorkspaceが存在しない場合は表示しない
        bottomNavigationBar: doesCurrentWorkspaceExist
            ? _BottomNavbar(corrWorkspace: currentWorkspaceNullAble)
            : null,
        floatingActionButton: doesCurrentWorkspaceExist
            ? CenterButtonOfBottomNavBar(
                onPressed: () =>
                    _navigateToEditToDoPage(context, currentWorkspaceNullAble))
            : null,
        floatingActionButtonLocation: doesCurrentWorkspaceExist
            ? FloatingActionButtonLocation.centerDocked
            : null,
      ),
    );
  }

  // MARK: - 編集ページへの遷移処理
  void _navigateToEditToDoPage(
      BuildContext context, TLWorkspace corrWorkspace) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return EditToDoPage(
            corrWorkspace: corrWorkspace,
            ifInToday: true,
            selectedBigCategoryID: corrWorkspace.bigCategories[0].id,
            selectedSmallCategoryID: null,
            editedToDoTitle: null,
            indexOfEdittedTodo: null,
          );
        },
      ),
    );
  }
}

// MARK: - TodoList Widget
class _TodoListInTodayAndWhenever extends StatelessWidget {
  final TLWorkspace corrWorkspace;

  const _TodoListInTodayAndWhenever({required this.corrWorkspace});

  @override
  Widget build(BuildContext context) {
    final numOfToDosInToday =
        TLWorkspaceUtils.getNumOfToDo(corrWorkspace, ifInToday: true);
    final numOfToDosInWhenever =
        TLWorkspaceUtils.getNumOfToDo(corrWorkspace, ifInToday: false);

    return ListView(
      key: PageStorageKey(corrWorkspace.id), // スクロール位置を保持
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: NumToDosCard(ifInToday: true, numTodos: numOfToDosInToday),
        ),
        ListOfCategoryToToDos(ifInToday: true, corrWorkspace: corrWorkspace),
        if (numOfToDosInWhenever != 0)
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child:
                NumToDosCard(ifInToday: false, numTodos: numOfToDosInWhenever),
          ),
        ListOfCategoryToToDos(ifInToday: false, corrWorkspace: corrWorkspace),
        const SizedBox(height: 250),
      ],
    );
  }
}

// MARK: - Bottom Navbar Widget
class _BottomNavbar extends ConsumerWidget {
  final TLWorkspace corrWorkspace;

  const _BottomNavbar({required this.corrWorkspace});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tlAppStateReducer = ref.read(tlAppStateProvider.notifier);

    return TLBottomNavBar(
      leadingIconData: FontAwesomeIcons.squareCheck,
      leadingButtonOnPressed: () => TLYesNoDialog(
        title: "チェック済みToDoを\n削除しますか?",
        message: null,
        yesAction: () async {
          Navigator.pop(context);
          final TLWorkspace updatedWorkspace =
              await TLWorkspaceUtils.deleteCheckedToDosInTodayInAWorkspace(
            corrWorkspace,
            onlyToday: false,
          );
          tlAppStateReducer.dispatchWorkspaceAction(
              TLWorkspaceAction.updateCorrWorkspace(updatedWorkspace));

          if (context.mounted) {
            const TLSingleOptionDialog(title: "削除が完了しました！")
                .show(context: context);
          }
          TLVibrationService.vibrate();
        },
      ).show(context: context),
      trailingIconData: FontAwesomeIcons.list,
      trailingButtonOnPressed: () async {
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
          return CategoryListPage(corrWorkspace: corrWorkspace);
        }));
      },
    );
  }
}
