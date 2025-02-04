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
import 'num_todos_card.dart';
import 'todos_block.dart';

import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool _accetColorIsChanged = false;
  final GlobalKey<ScaffoldState> homePageScaffoldKey =
      GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // 画面の描画が終わったタイミングで処理
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_accetColorIsChanged) {
        _accetColorIsChanged = true;
        // accetColor is changed
        setState(() {});
        FlutterNativeSplash.remove();
      }
      // if (settingData.isFirstEntry) {
      //   Navigator.push(context, MaterialPageRoute(builder: (context) {
      //     return const ShowTutorialPage();
      //   }));
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    final TLThemeData tlThemeData = TLTheme.of(context);
    // provider
    final tlAppState = ref.watch(tlAppStateProvider);
    // notifier
    final tlAppStateReducer = ref.read(tlAppStateProvider.notifier);
    // others
    final TLWorkspace currentWorkspaceRef =
        tlAppState.tlWorkspaces[tlAppState.currentWorkspaceIndex];
    // final int currentWorkspaceIndex = tlAppState.currentWorkspaceIndex;
    final numOfToDosInToday =
        TLWorkspaceUtils.getNumOfToDo(currentWorkspaceRef, ifInToday: true);
    final numOfToDosInWhenever =
        TLWorkspaceUtils.getNumOfToDo(currentWorkspaceRef, ifInToday: false);

    return Scaffold(
      key: homePageScaffoldKey,
      drawer: const TLWorkspaceDrawer(isContentMode: false),
      body: Stack(children: [
        // 背景色
        Container(color: tlThemeData.backgroundColor),
        // 本体
        CustomScrollView(
          slivers: [
            TLSliverAppBar(
              pageTitle: tlAppState.currentWorkspaceIndex == 0
                  ? "Today List"
                  : currentWorkspaceRef.name,
              // drawerを表示するボタン
              leadingButtonOnPressed: () =>
                  homePageScaffoldKey.currentState!.openDrawer(),
              leadingIcon: const Icon(
                Icons.menu,
                color: Colors.white,
              ),
              // setting pageへ移動するボタン
              trailingButtonOnPressed: () async {
                await Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return const TLSettingPage();
                }));
              },
              trailingIcon: const Icon(Icons.settings, color: Colors.white),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              const SizedBox(
                height: 10,
              ),
              NumToDosCard(ifInToday: true, numTodos: numOfToDosInToday),
              TodosBlock(
                  ifInToday: true, currentTLWorkspace: currentWorkspaceRef),
              if (numOfToDosInWhenever != 0)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: NumToDosCard(
                      ifInToday: false, numTodos: numOfToDosInWhenever),
                ),
              TodosBlock(
                  ifInToday: false, currentTLWorkspace: currentWorkspaceRef),

              // スペーサー
              const SizedBox(height: 250)
            ])),
          ],
        ),
        // 今日のチェック済みtodoを全て削除するボタン, カテゴリーリストに移動するボタン
        TodayListBottomNavbar(
          leadingIconData: FontAwesomeIcons.squareCheck,
          //　今日のチェック済みtodoを全て削除するボタン
          leadingButtonOnPressed: () => showDialog(
            context: context,
            builder: ((context) => TLYesNoDialog(
                  title: "チェック済みToDoを\n削除しますか?",
                  message: null,
                  yesAction: () async {
                    Navigator.pop(context);
                    // このworkspaceの今日に分類されているToDoを削除
                    final updatedWorkspace = await TLWorkspaceUtils
                        .deleteCheckedToDosInTodayInAWorkspace(
                      currentWorkspaceRef,
                      onlyToday: false,
                    );
                    // 状態を保存
                    tlAppStateReducer.dispatchWorkspaceAction(
                        TLWorkspaceAction.updateCurrentWorkspace(
                            updatedWorkspace));
                    if (context.mounted) {
                      const TLSingleOptionDialog(title: "削除が完了しました！")
                          .show(context: context);
                    }
                    TLVibrationService.vibrate();
                  },
                )),
          ),
          trailingIconData: FontAwesomeIcons.list,
          // カテゴリーリストに移動するボタン
          tralingButtonOnPressed: () async {
            await Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const CategoryListPage();
            }));
          },
        ),
        // 新たにtodoを追加するボタン
        CenterButtonOfBottomNavBar(
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
        ),
      ]),
    );
  }
}
