import 'package:flutter/material.dart';
import 'package:today_list/alerts/common/simple_alert.dart';
import '../../components/for_ui/tl_sliver_appbar.dart';
import '../../components/for_todo/todos_in_this_category_today/header_for_todos.dart';
import '../../components/for_todo/todos_in_this_category_today/todos_in_this_category_today.dart';
import '../../components/for_ui/today_list_bottom_navbar/center_button_of_bottom_navbar.dart';
import '../../components/for_ui/today_list_bottom_navbar/today_list_bottom_navbar.dart';
import '../../constants/global_keys.dart';
import '../../constants/theme.dart';
import '../../alerts/common/yes_no_alert.dart';
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
import '../.././main.dart';

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
        FlutterNativeSplash.remove();
      }
      // if (settingData.isFirstEntry) {
      //   Navigator.push(context, MaterialPageRoute(builder: (context) {
      //     return const ShowTutorialPage();
      //   }));
      // }

      // admob.readAdsData();
      // purchase.initPlatformState();
    });

    TLWorkspace.readWorkspaces().then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homePageScaffoldKey,
      drawer: WorkspaceDrawer(key: drawerForWorkspaceKey, isContentMode: false),
      body: Stack(children: [
        // 背景色
        Container(color: theme[settingData.selectedTheme]!.backgroundColor),
        // 本体
        CustomScrollView(
          slivers: [
            TLSliverAppBar(
              pageTitle: "Today List",
              // drawerを表示するボタン
              leadingButtonOnPressed: () =>
                  homePageScaffoldKey.currentState!.openDrawer(),
              leadingIcon: const Icon(
                Icons.menu,
                color: Colors.white,
              ),
              // setting pageへ移動するボタン
              trailingButtonOnPressed: !adTestMode
                  ? null
                  : () async {
                      await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return SettingPage(key: settingPageKey);
                      }));
                      homePageKey.currentState?.setState(() {});
                    },
              trailingIcon: !adTestMode
                  ? null
                  : const Icon(Icons.settings, color: Colors.white),
              // pro pageへ遷移するボタン
              // actions: adIsClosed
              //     ? null
              //     : [
              //         Padding(
              //           padding: EdgeInsets.only(
              //               left: 5.0,
              //               bottom: 5.0,
              //               right: purchase.havePurchased ? 8.0 : 5.5),
              //           child: GestureDetector(
              //             onTap: () async {
              //               enterSerialCodeMode = false;
              //               await Navigator.push(context,
              //                   MaterialPageRoute(builder: (context) {
              //                 return ProPage(
              //                   key: proPageKey,
              //                 );
              //               }));
              //               homePageKey.currentState?.setState(() {});
              //             },
              //             onLongPress: () {
              //               enterSerialCodeMode = true;
              //               simpleAlert(
              //                   context: context,
              //                   title:
              //                       "連続ログイン日数: ${settingData.consecutiveLoginDays}日",
              //                   message:
              //                       "- はじめ -\nCoinの欠片・・・1枚\n\n- 3日連続ログイン -\nCoinの欠片・・・2枚\n\n- 7日連続ログイン -\nCoinの欠片・・・3枚",
              //                   buttonText: "OK");
              //               setState(() {});
              //             },
              //             onDoubleTap: !enterSerialCodeMode
              //                 ? null
              //                 : () {
              //                     admob.letUserEnterSerialCode(
              //                         context: context);
              //                   },
              //             child: (() {
              //               return isDevelopperMode
              //                   ? const Icon(
              //                       Icons.construction,
              //                       color: Colors.white,
              //                     )
              //                   : purchase.havePurchased
              //                       ? const Icon(
              //                           FontAwesomeIcons.crown,
              //                           color: Colors.white,
              //                           size: 17,
              //                         )
              //                       : Transform.rotate(
              //                           angle: 3.14,
              //                           child: const Icon(
              //                             Icons.auto_awesome,
              //                             color: Colors.white,
              //                           ));
              //             }()),
              //           ),
              //         ),
              // setting pageへ遷移する
              //   Padding(
              //     padding:
              //         const EdgeInsets.only(bottom: 5.0, right: 16.5),
              //     child: Padding(
              //       padding: const EdgeInsets.only(left: 5.0),
              //       child: GestureDetector(
              //           onTap: () async {
              //             await Navigator.push(context,
              //                 MaterialPageRoute(builder: (context) {
              //               return SettingPage(
              //                 key: settingPageKey,
              //               );
              //             }));
              //             homePageKey.currentState?.setState(() {});
              //           },
              //           child: const Icon(Icons.settings,
              //               color: Colors.white)),
              //     ),
              //   ),
              // ],
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              const SizedBox(
                height: 10,
              ),
              Center(
                  child: Text(
                "- ${currentWorkspace.name} - ",
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black45,
                    fontWeight: FontWeight.bold),
              )),
              // // 今までこなしたToDoの数を表示
              // EffortCard(
              //     effortTitle: currentWorkspace.name,
              //     effort: currentWorkspace.numberOfToDosHaveBeenDone),
              // 今日のtodoを表示
              // なしの時の処理
              if (currentWorkspace.toDos[currentWorkspace.bigCategories[0].id]!
                  .toDosInToday.isNotEmpty)
                const SizedBox(height: 7),
              if (currentWorkspace.toDos[currentWorkspace.bigCategories[0].id]!
                  .toDosInToday.isNotEmpty)
                ToDosInThisCategoryInToday(
                  superKey: homePageKey,
                  bigCategoryOfThisToDo: currentWorkspace.bigCategories[0],
                  // workspace
                  selectedWorkspaceCategoryId: currentWorkspaceCategoryId,
                  selectedWorkspaceIndex: currentWorkspaceIndex,
                  selectedWorkspace: currentWorkspace,
                ),
              // なし以外のbigCategoryの処理
              for (TLCategory bigCategory
                  in currentWorkspace.bigCategories.sublist(1))
                Column(
                  children: [
                    // big header
                    if (currentWorkspace
                            .toDos[bigCategory.id]!.toDosInToday.isNotEmpty ||
                        // そのsmallCategoryがToDoを持っていたら、bigHeaderを表示
                        (currentWorkspace
                                .smallCategories[bigCategory.id]!.isNotEmpty &&
                            currentWorkspace.smallCategories[bigCategory.id]!
                                    .indexWhere((smallCategory) =>
                                        currentWorkspace
                                            .toDos[smallCategory.id]!
                                            .toDosInToday
                                            .isNotEmpty) !=
                                -1))
                      HeaderForToDos(
                          isBigCategory: true, category: bigCategory),
                    // big body
                    if (currentWorkspace
                        .toDos[bigCategory.id]!.toDosInToday.isNotEmpty)
                      ToDosInThisCategoryInToday(
                        superKey: homePageKey,
                        bigCategoryOfThisToDo: bigCategory,
                        // workspace
                        selectedWorkspaceCategoryId: currentWorkspaceCategoryId,
                        selectedWorkspaceIndex: currentWorkspaceIndex,
                        selectedWorkspace: currentWorkspace,
                      ),
                    for (TLCategory smallCategory
                        in currentWorkspace.smallCategories[bigCategory.id] ??
                            [])
                      if (currentWorkspace
                          .toDos[smallCategory.id]!.toDosInToday.isNotEmpty)
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
                              selectedWorkspaceCategoryId:
                                  currentWorkspaceCategoryId,
                              selectedWorkspaceIndex: currentWorkspaceIndex,
                              selectedWorkspace: currentWorkspace,
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
                    selectedWorkspaceCategoryId: currentWorkspaceCategoryId,
                    selectedWorkspaceIndex: currentWorkspaceIndex,
                    selectedWorkspace: currentWorkspace);
                TLVibration.vibrate();
                simpleAlert(
                    context: context,
                    title: "削除が完了しました",
                    message: null,
                    buttonText: "OK");
                setState(() {});
                await TLWorkspace.saveSelectedWorkspace(
                    selectedWorkspaceIndex: TLWorkspace.currentWorkspaceIndex,
                    selectedWorkspace: TLWorkspace.currentWorkspace);
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
