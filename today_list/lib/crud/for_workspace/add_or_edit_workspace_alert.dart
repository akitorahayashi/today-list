import 'package:flutter/material.dart';
import '../../styles.dart';
import '../../alerts/common/simple_alert.dart';
import '../../constants/global_keys.dart';
import '../../constants/theme.dart';
import '../../model/tl_category.dart';
import '../../model/user/setting_data.dart';
import '../../model/workspace/workspace.dart';
import '../../model/workspace/id_to_jsonworkspaceList.dart';
import '../../model/todo/tl_todos.dart';
import '../../model/externals/tl_vibration.dart';
import 'add_workspace_category_alert.dart';
import 'notify_workspace_is_added.dart';
import 'dart:convert';

class AddOrEditWorkspaceDialog extends StatefulWidget {
  final TLCategory? oldWorkspaceCategory;
  final int? oldIndexInStringWorkspaces;
  const AddOrEditWorkspaceDialog(
      {super.key,
      required this.oldWorkspaceCategory,
      required this.oldIndexInStringWorkspaces});

  @override
  State<AddOrEditWorkspaceDialog> createState() =>
      _AddOrEditWorkspaceDialogState();
}

class _AddOrEditWorkspaceDialogState extends State<AddOrEditWorkspaceDialog> {
  TLCategory _selectedWorkspaceCategory = workspaceCategories[0];
  bool isInitialized = false;
  final TextEditingController _workspaceNameInputController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (widget.oldWorkspaceCategory != null && !isInitialized) {
      isInitialized = true;
      _selectedWorkspaceCategory = widget.oldWorkspaceCategory!;
      _workspaceNameInputController.text = idToJsonWorkspaceList[widget
          .oldWorkspaceCategory!
          .id]![widget.oldIndexInStringWorkspaces!]["name"];
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
                  _selectedWorkspaceCategory.id == noneId
                      ? "カテゴリー"
                      : workspaceCategories[workspaceCategories.indexWhere(
                              (TLCategory workspaceCategory) =>
                                  _selectedWorkspaceCategory.id ==
                                  workspaceCategory.id)]
                          .title,
                  style: TextStyle(
                      fontSize: 14.5,
                      color: Colors.black.withOpacity(
                          _selectedWorkspaceCategory.id == noneId ? 0.4 : 0.5),
                      fontWeight: FontWeight.w600),
                ),
                items: [
                  TLCategory(id: noneId, title: "なし"),
                  ...workspaceCategories.sublist(1),
                  TLCategory(id: "---makeWorkspaceCategory", title: "新しく作る"),
                ].map((TLCategory workspaceCategory) {
                  return DropdownMenuItem(
                    value: workspaceCategory,
                    child: Text(
                      workspaceCategory.title,
                      style: (workspaceCategory.id == noneId &&
                                  _selectedWorkspaceCategory.id == noneId) ||
                              workspaceCategory.id ==
                                  _selectedWorkspaceCategory.id
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
                onChanged: (TLCategory? workspaceCategory) async {
                  if (workspaceCategory != null) {
                    switch (workspaceCategory.id) {
                      case noneId:
                        _selectedWorkspaceCategory = workspaceCategories[0];
                        break;
                      case "---makeWorkspaceCategory":
                        _selectedWorkspaceCategory =
                            await addWorkspaceCategoryAlert(
                                    context: context,
                                    categoryNameInputController:
                                        TextEditingController()) ??
                                workspaceCategories[0];
                        break;
                      default:
                        _selectedWorkspaceCategory = workspaceCategory;
                    }
                    setState(() {});
                  }
                }),
          ),
          // 新しいworkspace名を入力するTextField
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: SizedBox(
                width: 230,
                child: TextField(
                  autofocus: true,
                  cursorColor: theme[settingData.selectedTheme]!.accentColor,
                  controller: _workspaceNameInputController,
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontWeight: FontWeight.w600),
                  decoration: tlInputDecoration(
                      labelText: "新しい名前", icon: null, suffixIcon: null),
                )),
          ),
          // 閉じる 追加するボタン
          ButtonBar(
            alignment: MainAxisAlignment.spaceEvenly,
            children: [
              // カテゴリーを作らずにアラートを閉じるボタン
              TextButton(
                  style: alertButtonStyle(),
                  onPressed: () => Navigator.pop(context),
                  child: const Text("閉じる")),
              // workspaceを追加するボタン
              TextButton(
                  style: alertButtonStyle(),
                  onPressed: () {
                    if (_workspaceNameInputController.text.trim().isEmpty) {
                      // 入力されていなければ退場
                      Navigator.pop(context);
                    } else {
                      // アラートを閉じる
                      Navigator.pop(context);
                      // workspacesを更新
                      if (widget.oldWorkspaceCategory == null) {
                        // add action
                        // 新しくできたWorkspace
                        final createdWorkspaceJsonData = Workspace(
                            name: _workspaceNameInputController.text,
                            bigCategories: [
                              TLCategory(id: noneId, title: "なし")
                            ],
                            smallCategories: {
                              noneId: []
                            },
                            toDos: {
                              noneId:
                                  TLToDos(toDosInToday: [], toDosInWhenever: [])
                            }).toJson();
                        idToJsonWorkspaceList[_selectedWorkspaceCategory.id]!
                            .add(createdWorkspaceJsonData);
                        // 追加したことを知らせる
                        notifyWorkspaceIsAdded(
                            context: context,
                            newWorkspaceName:
                                _workspaceNameInputController.text);
                      } else {
                        // edit action
                        final Workspace editedWorkspace = Workspace.fromJson(
                            idToJsonWorkspaceList[widget.oldWorkspaceCategory!
                                .id]![widget.oldIndexInStringWorkspaces!]);
                        // 名前だけ変える
                        editedWorkspace.name =
                            _workspaceNameInputController.text;
                        // 消して元の場所に入れる
                        idToJsonWorkspaceList[widget.oldWorkspaceCategory!.id]!
                            .removeAt(widget.oldIndexInStringWorkspaces!);
                        idToJsonWorkspaceList[_selectedWorkspaceCategory.id]!
                            .insert(
                          widget.oldIndexInStringWorkspaces!,
                          editedWorkspace.toJson(),
                        );

                        // currentWorkspaceの時
                        if (currentWorkspaceCategoryId ==
                                _selectedWorkspaceCategory.id &&
                            currentWorkspaceIndex ==
                                widget.oldIndexInStringWorkspaces!) {
                          currentWorkspace = editedWorkspace;
                          currentWorkspace.saveCurrentWorkspace(
                              selectedWorkspaceCategoryId:
                                  _selectedWorkspaceCategory.id,
                              newWorkspaceIndex:
                                  widget.oldIndexInStringWorkspaces!);
                        }
                        simpleAlert(
                          context: context,
                          title: "変更することに\n成功しました!!",
                          message: null,
                          buttonText: "OK",
                        );
                      }
                      TLVibration.vibrate();
                      homePageKey.currentState?.setState(() {});
                      manageWorkspacePageKey.currentState?.setState(() {});
                      drawerForWorkspaceKey.currentState?.setState(() {});
                      // workspacesをセーブする
                      Workspace.saveStringWorkspaces();
                    }
                  },
                  child:
                      Text(widget.oldWorkspaceCategory == null ? "追加" : "編集"))
            ],
          )
        ],
      ),
    );
  }
}
