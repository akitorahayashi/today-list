import 'package:flutter/material.dart';
import 'package:today_list/alerts/simple_alert.dart';
import '../../components/for_ui/tl_sliver_appbar.dart';
import '../../components/for_todo/todos_in_this_category_today/header_for_todos.dart';
import '../../components/for_todo/todos_in_this_category_today/todos_in_this_category_today.dart';
import '../../components/for_ui/today_list_bottom_navbar/center_button_of_bottom_navbar.dart';
import '../../components/for_ui/today_list_bottom_navbar/today_list_bottom_navbar.dart';
import '../../constants/global_keys.dart';
import '../../constants/theme.dart';
import '../../alerts/yes_no_alert.dart';
import '../../model/user/setting_data.dart';
import '../../model/workspace/tl_workspace.dart';
import '../../model/workspace/tl_workspaces.dart';
import '../../model/tl_category.dart';
import '../../model/externals/tl_vibration.dart';
import '../../crud/for_todo/delete_checked_todos_in_today.dart';
import '../edit_todo_page/edit_todo_page.dart';
import '../category_list_page/category_list_page.dart';
import '../setting_page/setting_page.dart';
import './workspace_drawer/workspace_drawer.dart';

import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({required Key key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  bool accetColorIsChanged = false;
  bool enterSerialCodeMode = false;

  @override
  void initState() {
    super.initState();
    // 画面の描画が終わったタイミングで処理
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!accetColorIsChanged) {
        accetColorIsChanged = true;
        print("accetColor is changed");
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
    return Scaffold(
      key: homePageScaffoldKey,
      drawer: WorkspaceDrawer(key: drawerForWorkspaceKey, isContentMode: false),
      body: Stack(children: [
        // 背景色
        Container(
            color: tlThemeDataList[SettingData.shared.selectedTheme]!
                .backgroundColor),
        // 本体
        CustomScrollView(
          slivers: [
            TLSliverAppBar(
              pageTitle: TLWorkspace.currentWorkspaceIndex == 0
                  ? "Today List"
                  : TLWorkspace.currentWorkspace.name,
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
                  return SettingPage(key: settingPageKey);
                }));
                homePageKey.currentState?.setState(() {});
              },
              trailingIcon: const Icon(Icons.settings, color: Colors.white),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              const SizedBox(
                height: 10,
              ),
              if (TLWorkspace
                  .currentWorkspace
                  .toDos[TLWorkspace.currentWorkspace.bigCategories[0].id]!
                  .toDosInToday
                  .isNotEmpty)
                const SizedBox(height: 7),
              if (TLWorkspace
                  .currentWorkspace
                  .toDos[TLWorkspace.currentWorkspace.bigCategories[0].id]!
                  .toDosInToday
                  .isNotEmpty)
                ToDosInThisCategoryInToday(
                  superKey: homePageKey,
                  bigCategoryOfThisToDo:
                      TLWorkspace.currentWorkspace.bigCategories[0],
                  // workspace
                  selectedWorkspaceIndex: TLWorkspace.currentWorkspaceIndex,
                  selectedWorkspace: TLWorkspace.currentWorkspace,
                ),
              // なし以外のbigCategoryの処理
              for (TLCategory bigCategory
                  in TLWorkspace.currentWorkspace.bigCategories.sublist(1))
                Column(
                  children: [
                    // big header
                    if (TLWorkspace.currentWorkspace.toDos[bigCategory.id]!
                            .toDosInToday.isNotEmpty ||
                        // そのsmallCategoryがToDoを持っていたら、bigHeaderを表示
                        (TLWorkspace.currentWorkspace
                                .smallCategories[bigCategory.id]!.isNotEmpty &&
                            TLWorkspace.currentWorkspace
                                    .smallCategories[bigCategory.id]!
                                    .indexWhere((smallCategory) => TLWorkspace
                                        .currentWorkspace
                                        .toDos[smallCategory.id]!
                                        .toDosInToday
                                        .isNotEmpty) !=
                                -1))
                      HeaderForToDos(
                          isBigCategory: true, category: bigCategory),
                    // big body
                    if (TLWorkspace.currentWorkspace.toDos[bigCategory.id]!
                        .toDosInToday.isNotEmpty)
                      ToDosInThisCategoryInToday(
                        superKey: homePageKey,
                        bigCategoryOfThisToDo: bigCategory,
                        // workspace
                        selectedWorkspaceIndex:
                            TLWorkspace.currentWorkspaceIndex,
                        selectedWorkspace: TLWorkspace.currentWorkspace,
                      ),
                    for (TLCategory smallCategory in TLWorkspace
                            .currentWorkspace.smallCategories[bigCategory.id] ??
                        [])
                      if (TLWorkspace.currentWorkspace.toDos[smallCategory.id]!
                          .toDosInToday.isNotEmpty)
                        Column(
                          children: [
                            // small header
                            HeaderForToDos(
                                isBigCategory: false, category: smallCategory),
                            // small body
                            ToDosInThisCategoryInToday(
                              superKey: homePageKey,
                              bigCategoryOfThisToDo: bigCategory,
                              smallCategoryOfThisToDo: smallCategory,
                              // workspace
                              selectedWorkspaceIndex:
                                  TLWorkspace.currentWorkspaceIndex,
                              selectedWorkspace: TLWorkspace.currentWorkspace,
                            )
                          ],
                        ),
                  ],
                ),
              // なしではない時の処理
              const SizedBox(height: 250)
            ])),
          ],
        ),
        // 今日のチェック済みtodoを全て削除するボタン, カテゴリーリストに移動するボタン
        TodayListBottomNavbar(
          leadingIconData: FontAwesomeIcons.squareCheck,
          //　今日のチェック済みtodoを全て削除するボタン
          leadingButtonOnPressed: () => yesNoAlert(
              context: context,
              title: "チェック済みToDoを\n削除しますか?",
              message: null,
              yesAction: () async {
                Navigator.pop(context);
                deleteCheckedToDosInToday(
                    context: context,
                    selectedWorkspaceIndex: TLWorkspace.currentWorkspaceIndex,
                    selectedWorkspace: TLWorkspace.currentWorkspace);
                TLVibration.vibrate();
                simpleAlert(
                    context: context,
                    title: "削除が完了しました",
                    message: null,
                    buttonText: "OK");
                setState(() {});
                await TLWorkspace.saveSelectedWorkspace(
                    selectedWorkspaceIndex: TLWorkspace.currentWorkspaceIndex);
              }),
          trailingIconData: FontAwesomeIcons.list,
          // カテゴリーリストに移動するボタン
          tralingButtonOnPressed: () async {
            await Navigator.push(context, MaterialPageRoute(builder: (context) {
              return CategoryListPage(
                key: categoryListPageKey,
              );
            }));
          },
        ),
        // 新たにtodoを追加するボタン
        CenterButtonOfBottomNavBar(
          onPressed: () async {
            await Navigator.push(context, MaterialPageRoute(builder: (context) {
              return EditToDoPage(
                key: editToDoPageKey,
                superKey: homePageKey,
                toDoTitle: "",
                belogedSteps: const [],
                isInToday: true,
                bigCategory: TLCategory(id: noneId, title: "なし"),
                smallCategory: null,
                indexOfThisToDoInToDos: null,
                oldCategoryId: null,
              );
            }));
            setState(() {});
          },
        ),
      ]),
    );
  }
}
