import 'package:flutter/material.dart';
import '../constants/global_keys.dart';
import '../crud/for_workspace/notify_workspace_is_added.dart';
import 'common/simple_alert.dart';
import '../constants/theme.dart';
import '../model/tl_category.dart';
import '../model/user/setting_data.dart';
import '../model/workspace/workspace.dart';
import '../model/workspace/id_to_jsonworkspaceList.dart';
import '../model/todo/tl_todos.dart';
import '../model/externals/tl_vibration.dart';
import '../styles.dart';
import 'dart:convert';

class EditWorkspaceDialog extends StatefulWidget {
  final String? oldWorkspaceCategoryId;
  final int? oldWorkspaceIndex;
  const EditWorkspaceDialog(
      {super.key,
      required this.oldWorkspaceCategoryId,
      required this.oldWorkspaceIndex});

  @override
  State<EditWorkspaceDialog> createState() => _EditWorkspaceDialogState();
}

class _EditWorkspaceDialogState extends State<EditWorkspaceDialog> {
  String? _selectedWorkspaceCategoryId;
  bool isInitialized = false;
  final TextEditingController _workspaceNameInputController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (widget.oldWorkspaceCategoryId != null && !isInitialized) {
      isInitialized = true;
      _selectedWorkspaceCategoryId = widget.oldWorkspaceCategoryId;
      _workspaceNameInputController.text =
          workspaces[widget.oldWorkspaceCategoryId]![widget.oldWorkspaceIndex!]
              ["name"];
    }
    return Dialog(
      backgroundColor: theme[settingData.selectedTheme]!.alertColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // スペーサー
          const SizedBox(
            height: 30,
          ),
          // カテゴリー選択のためのDropdownButton
          SizedBox(
            width: 230,
            child: DropdownButton(
                iconEnabledColor: theme[settingData.selectedTheme]!.accentColor,
                isExpanded: true,
                // smallCategoryをなしにすることで選択できるようになることを知らせる
                hint: Text(
                  _selectedWorkspaceCategoryId == null
                      ? "Category"
                      : workspaceCategories[workspaceCategories.indexWhere(
                              (workspaceCategory) =>
                                  _selectedWorkspaceCategoryId ==
                                  workspaceCategory.id)]
                          .title,
                  style: TextStyle(
                      color: Colors.black.withOpacity(
                          _selectedWorkspaceCategoryId == null ? 0.4 : 0.5),
                      fontWeight: FontWeight.w600),
                ),
                items: [
                  TLCategory(id: noneId, title: "なし"),
                  ...workspaceCategories.sublist(1),
                  TLCategory(id: "---makeNew", title: "新しく作る"),
                ].map((TLCategory item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(
                      item.title,
                      style: (item.id == noneId &&
                                  _selectedWorkspaceCategoryId == null) ||
                              item.id == _selectedWorkspaceCategoryId
                          ? TextStyle(
                              color:
                                  theme[settingData.selectedTheme]!.accentColor,
                              fontWeight: FontWeight.bold)
                          : TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontWeight: FontWeight.bold),
                    ),
                  );
                }).toList(),
                onChanged: (TLCategory? newSmallCategory) async {
                  // if (newSmallCated
                }),
          ),
          // 新しいworkspace名を入力するTextFormField
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: SizedBox(
                width: 230,
                child: TextField(
                  autofocus: true,
                  controller: _workspaceNameInputController,
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                    hintText: "Workspace",
                    hintStyle: TextStyle(
                        color: Colors.black.withOpacity(0.4),
                        fontWeight: FontWeight.w600),
                  ),
                )),
          ),
          // 閉じる 追加するボタン
          ButtonBar(
            alignment: MainAxisAlignment.spaceEvenly,
            children: [
              // カテゴリーを作らずにアラートを閉じるボタン
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: alertButtonStyle(),
                  child: const Text("閉じる")),
              // workspaceを追加するボタン
              TextButton(
                  style: alertButtonStyle(),
                  onPressed: () {
                    if (_workspaceNameInputController.text.trim().isNotEmpty) {
                      final String enteredWorkspaceName =
                          _workspaceNameInputController.text;
                      // アラートを閉じる
                      Navigator.pop(context);
                      // workspacesを更新
                      if (widget.oldWorkspaceCategoryId == null) {
                        // add action
                        workspaces[_selectedWorkspaceCategoryId ?? noneId]!.add(
                            Workspace(
                                name: enteredWorkspaceName,
                                bigCategories: [
                              TLCategory(id: noneId, title: "なし")
                            ],
                                smallCategories: {
                              noneId: []
                            },
                                toDos: {
                              noneId:
                                  TLToDos(toDosInToday: [], toDosInWhenever: [])
                            }).toJson());
                        notifyWorkspaceIsAdded(
                            context: context,
                            newWorkspaceName: enteredWorkspaceName);
                      } else {
                        // edit action
                        final Workspace editedWorkspace = Workspace.fromJson(
                            workspaces[widget.oldWorkspaceCategoryId!]![
                                widget.oldWorkspaceIndex!]);
                        editedWorkspace.name = enteredWorkspaceName;
                        // 入れて消す
                        workspaces[_selectedWorkspaceCategoryId ?? noneId]!
                            .insert(widget.oldWorkspaceIndex!,
                                editedWorkspace.toJson());
                        workspaces[widget.oldWorkspaceCategoryId]!
                            .removeAt(widget.oldWorkspaceIndex! + 1);
                        simpleAlert(
                            context: context,
                            title: "変更することに\n成功しました!!",
                            message: null,
                            buttonText: "thank you!");
                      }
                      drawerForWorkspaceKey.currentState?.setState(() {});
                      homePageKey.currentState?.setState(() {});
                      manageWorkspacePageKey.currentState?.setState(() {});
                      TLVibration.vibrate();
                      // workspacesをセーブする
                      Workspace.saveStringWorkspaces();
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  child:
                      Text(widget.oldWorkspaceCategoryId == null ? "追加" : "編集"))
            ],
          )
        ],
      ),
    );
  }
}
