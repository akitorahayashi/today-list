import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/action/todo/tl_workspace_action.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/service/tl_vibration.dart';
import 'package:today_list/util/tl_workspace_utils.dart';
import 'package:today_list/view/component/common_ui_part/tl_sliver_appbar.dart';
import 'package:today_list/view/component/common_ui_part/today_list_bottom_navbar/center_button_of_bottom_navbar.dart';
import 'package:today_list/view/component/common_ui_part/today_list_bottom_navbar/today_list_bottom_navbar.dart';
import 'package:today_list/view/component/dialog/common/tl_single_option_dialog.dart';
import 'package:today_list/view/component/dialog/common/tl_yes_no_dialog.dart';
import 'package:today_list/view/screen/category_list_page/category_list_page.dart';
import 'package:today_list/view/screen/edit_todo_page/edit_todo_page.dart';
import 'package:today_list/view/screen/setting_page/setting_page.dart';
import 'workspace_drawer/workspace_drawer.dart';
import 'build_todo_list/num_todos_card.dart';
import 'build_todo_list/list_of_category_to_todos.dart';

import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool _accetColorIsNotChanged = true;
  final GlobalKey<ScaffoldState> homePageScaffoldKey =
      GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_accetColorIsNotChanged) {
        _accetColorIsNotChanged = false;
        setState(() {});
        FlutterNativeSplash.remove();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final TLThemeData tlThemeData = TLTheme.of(context);
    final tlAppState = ref.watch(tlAppStateProvider);
    final currentWorkspaceRef = ref.watch(
      tlAppStateProvider
          .select((state) => state.tlWorkspaces[state.currentWorkspaceIndex]),
    );
    final numOfToDosInToday =
        TLWorkspaceUtils.getNumOfToDo(currentWorkspaceRef, ifInToday: true);
    final numOfToDosInWhenever =
        TLWorkspaceUtils.getNumOfToDo(currentWorkspaceRef, ifInToday: false);

    return Scaffold(
      key: homePageScaffoldKey,
      drawer: const TLWorkspaceDrawer(isContentMode: false),
      body: Stack(
        children: [
          Container(color: tlThemeData.backgroundColor),
          CustomScrollView(
            slivers: [
              _buildAppBar(context, tlAppState, currentWorkspaceRef),
              _buildTodoList(
                  numOfToDosInToday, numOfToDosInWhenever, currentWorkspaceRef),
            ],
          ),
          _buildBottomNavbar(context),
          _buildCenterButton(context),
        ],
      ),
    );
  }

  // MARK - AppBar
  Widget _buildAppBar(
      BuildContext context, tlAppState, TLWorkspace currentWorkspaceRef) {
    return TLSliverAppBar(
      pageTitle: tlAppState.currentWorkspaceIndex == 0
          ? "Today List"
          : currentWorkspaceRef.name,
      leadingButtonOnPressed: () =>
          homePageScaffoldKey.currentState!.openDrawer(),
      leadingIcon: const Icon(Icons.menu, color: Colors.white),
      trailingButtonOnPressed: () async {
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const TLSettingPage();
        }));
      },
      trailingIcon: const Icon(Icons.settings, color: Colors.white),
    );
  }

  // MARK - ToDo List Section
  Widget _buildTodoList(int numOfToDosInToday, int numOfToDosInWhenever,
      TLWorkspace currentWorkspaceRef) {
    return SliverList(
      delegate: SliverChildListDelegate([
        // --- Today Section ---
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: NumToDosCard(ifInToday: true, numTodos: numOfToDosInToday),
        ),
        ListOfCategoryToToDos(
            ifInToday: true, currentWorkspace: currentWorkspaceRef),
        // --- Whenever Section ---
        if (numOfToDosInWhenever != 0)
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child:
                NumToDosCard(ifInToday: false, numTodos: numOfToDosInWhenever),
          ),
        ListOfCategoryToToDos(
            ifInToday: false, currentWorkspace: currentWorkspaceRef),
        const SizedBox(height: 250),
      ]),
    );
  }

  // MARK - Bottom Navigation Bar
  Widget _buildBottomNavbar(BuildContext context) {
    final currentWorkspaceRef = ref.watch(
      tlAppStateProvider
          .select((state) => state.tlWorkspaces[state.currentWorkspaceIndex]),
    );
    final tlAppStateReducer = ref.read(tlAppStateProvider.notifier);

    return TodayListBottomNavbar(
      leadingIconData: FontAwesomeIcons.squareCheck,
      leadingButtonOnPressed: () =>
          _deleteCheckedToDos(context, currentWorkspaceRef, tlAppStateReducer),
      trailingIconData: FontAwesomeIcons.list,
      tralingButtonOnPressed: () async {
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const CategoryListPage();
        }));
      },
    );
  }

  // MARK - Center Add Button
  Widget _buildCenterButton(BuildContext context) {
    final currentWorkspaceRef = ref.watch(
      tlAppStateProvider
          .select((state) => state.tlWorkspaces[state.currentWorkspaceIndex]),
    );

    return CenterButtonOfBottomNavBar(
      onPressed: () async {
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
          return EditToDoPage(
            ifInToday: true,
            selectedBigCategoryID: currentWorkspaceRef.bigCategories[0].id,
            selectedSmallCategoryID: null,
            editedToDoTitle: null,
            indexOfEdittedTodo: null,
          );
        }));
      },
    );
  }

  // TODO dispatchを使う方法に書き換える - Delete Checked ToDos
  void _deleteCheckedToDos(BuildContext context,
      TLWorkspace currentWorkspaceRef, tlAppStateReducer) {
    showDialog(
      context: context,
      builder: ((context) => TLYesNoDialog(
            title: "チェック済みToDoを\n削除しますか?",
            message: null,
            yesAction: () async {
              Navigator.pop(context);
              final updatedWorkspace =
                  await TLWorkspaceUtils.deleteCheckedToDosInTodayInAWorkspace(
                currentWorkspaceRef,
                onlyToday: false,
              );
              tlAppStateReducer.dispatchWorkspaceAction(
                  TLWorkspaceAction.updateCurrentWorkspace(updatedWorkspace));

              if (context.mounted) {
                const TLSingleOptionDialog(title: "削除が完了しました！")
                    .show(context: context);
              }
              TLVibrationService.vibrate();
            },
          )),
    );
  }
}
