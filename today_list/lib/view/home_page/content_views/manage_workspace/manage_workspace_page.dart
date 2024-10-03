// import '../../../../model/tl_category.dart';
// import '../../../../components/for_ui/tl_sliver_appbar.dart';
// import '../../../../model/user/setting_data.dart';
// import '../../../../model/workspace/workspace.dart';
// import '../../../../model/workspace/workspaces.dart';
// import '../../../../constants/global_keys.dart';
// import '../../../../constants/theme.dart';
// import 'workspace_category_block_in_manage.dart';
// import '../../workspace_drawer/workspace_drawer.dart';
// import '../../workspace_drawer/change_workspace_card/change_workspace_card.dart';
// import '../../workspace_drawer/add_workspace_button.dart';
// import 'package:flutter/material.dart';

// import 'package:reorderables/reorderables.dart';

// class ManageWorkspacePage extends StatefulWidget {
//   const ManageWorkspacePage({required Key key}) : super(key: key);

//   @override
//   State<ManageWorkspacePage> createState() => _ManageWorkspacePageState();
// }

// class _ManageWorkspacePageState extends State<ManageWorkspacePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: manageWorkspacesPageScaffoldKey,
//       drawer: WorkspaceDrawer(key: drawerForWorkspaceKey, isContentMode: true),
//       body: Stack(children: [
//         // 背景色
//         Container(color: theme[settingData.selectedTheme]!.backgroundColor),
//         // 本体
//         CustomScrollView(
//           slivers: [
//             TLSliverAppBar(
//               titleFontSize: 17,
//               titleSpacing: 0.3,
//               pageTitle: "Manage Workspaces",
//               // drawerを表示するボタン
//               leadingButtonOnPressed: () {
//                 manageWorkspacesPageScaffoldKey.currentState!.openDrawer();
//               },
//               leadingIcon: const Icon(
//                 Icons.menu,
//                 color: Colors.white,
//               ),
//               // home pageへ移動するボタン
//               trailingButtonOnPressed: () {
//                 Navigator.pop(context);
//                 homePageKey.currentState?.setState(() {});
//               },
//               trailingIcon: const Icon(
//                 Icons.close,
//                 color: Colors.white,
//                 size: 27.5,
//               ),
//               actions: null,
//             ),
//             SliverList(
//                 delegate: SliverChildListDelegate([
//               // 現在のworkspaceのためのカード
//               Padding(
//                 padding: const EdgeInsets.only(top: 10.0),
//                 child: Card(
//                   color: theme[settingData.selectedTheme]!.settingPanelColor,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10)),
//                   child: Card(
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10)),
//                     child: Column(
//                       children: [
//                         // currrent workspace card
//                         const Padding(
//                           padding: EdgeInsets.only(top: 8.0, bottom: 3.0),
//                           child: Text(
//                             "current workspace",
//                             style: TextStyle(
//                               color: Colors.black45,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16,
//                             ),
//                           ),
//                         ),
//                         ChangeWorkspaceCard(
//                           isInDrawerList: false,
//                           workspaceName:
//                               workspaces[currentWorkspaceCategoryId]![
//                                   currentWorkspaceIndex]["name"]!,
//                           indexOfWorkspaceCategory: workspaceCategories
//                               .indexWhere((oneOfWorkspaceCategory) =>
//                                   oneOfWorkspaceCategory.id ==
//                                   currentWorkspaceCategoryId),
//                           indexInStringWorkspaces: currentWorkspaceIndex,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               // workspace categoryなどを表示する
//               Card(
//                   color: theme[settingData.selectedTheme]!.settingPanelColor,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10)),
//                   child: Padding(
//                     padding: const EdgeInsets.only(top: 1.0, bottom: 5.0),
//                     child: Column(
//                       children: [
//                         ReorderableColumn(
//                             children: [
//                               ...(() {
//                                 return [
//                                   for (int indexOfWorkspaceCategory = 0;
//                                       indexOfWorkspaceCategory <
//                                           workspaceCategories.length;
//                                       indexOfWorkspaceCategory++)
//                                     WorkspaceCategoryBlockInManage(
//                                       key: Key(UniqueKey().toString()),
//                                       indexOfWorkspaceCategory:
//                                           indexOfWorkspaceCategory,
//                                     ),
//                                 ];
//                               }())
//                             ],
//                             onReorder: (oldIndex, newIndex) {
//                               if (!(newIndex == 0 || oldIndex == 0)) {
//                                 final TLCategory reorderedCategory =
//                                     workspaceCategories.removeAt(oldIndex);
//                                 workspaceCategories.insert(
//                                     newIndex, reorderedCategory);
//                                 manageWorkspacePageKey.currentState
//                                     ?.setState(() {});
//                                 TLCategory.saveWorkspaceCategories();
//                               }
//                             }),
//                         // 新しくworkspaceを追加する
//                         const AddWorkspaceButton()
//                       ],
//                     ),
//                   )),
//               const SizedBox(height: 250)
//             ])),
//           ],
//         ),
//       ]),
//     );
//   }
// }
