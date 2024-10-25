import 'package:flutter/material.dart';
import '../../styles.dart';
import '../../alerts/simple_alert.dart';
import '../../constants/global_keys.dart';
import '../../model/tl_theme.dart';
import '../../model/todo/tl_category.dart';
import '../../model/workspace/tl_workspace.dart';
import '../../model/workspace/tl_workspaces.dart';
import '../../model/todo/tl_todos.dart';
import '../../model/external/tl_vibration.dart';
import 'notify_workspace_is_added.dart';

class AddOrEditWorkspaceDialog extends StatefulWidget {
  final int? oldIndexInStringWorkspaces;
  const AddOrEditWorkspaceDialog(
      {super.key, required this.oldIndexInStringWorkspaces});

  @override
  State<AddOrEditWorkspaceDialog> createState() =>
      _AddOrEditWorkspaceDialogState();
}

class _AddOrEditWorkspaceDialogState extends State<AddOrEditWorkspaceDialog> {
  bool isInitialized = false;
  final TextEditingController _workspaceNameInputController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    final TLThemeData _tlThemeData = TLTheme.of(context);
    if (widget.oldIndexInStringWorkspaces != null && !isInitialized) {
      isInitialized = true;
      _workspaceNameInputController.text =
          tlworkspaces[widget.oldIndexInStringWorkspaces!]["name"];
    }
    return Dialog(
      backgroundColor: _tlThemeData.alertColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: const EdgeInsets.only(top: 28.0),
            child: Text(
              "Workspace",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
            ),
          ),
          // スペーサー
          const SizedBox(
            height: 40,
          ),
          // 新しいworkspace名を入力するTextField
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: SizedBox(
                width: 230,
                child: TextField(
                  autofocus: true,
                  cursorColor: _tlThemeData.accentColor,
                  controller: _workspaceNameInputController,
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontWeight: FontWeight.w600),
                  decoration: tlInputDecoration(
                      context: context,
                      labelText: "新しい名前",
                      icon: null,
                      suffixIcon: null),
                )),
          ),
          // 閉じる 追加するボタン
          OverflowBar(
            alignment: MainAxisAlignment.spaceEvenly,
            children: [
              // カテゴリーを作らずにアラートを閉じるボタン
              TextButton(
                  style: alertButtonStyle(context: context),
                  onPressed: () => Navigator.pop(context),
                  child: const Text("閉じる")),
              // workspaceを追加するボタン
              TextButton(
                  style: alertButtonStyle(context: context),
                  onPressed: () {
                    if (_workspaceNameInputController.text.trim().isEmpty) {
                      // 入力されていなければ退場
                      Navigator.pop(context);
                    } else {
                      // アラートを閉じる
                      Navigator.pop(context);
                      // workspacesを更新
                      if (widget.oldIndexInStringWorkspaces == null) {
                        // add action
                        // 新しくできたWorkspace
                        final createdWorkspaceJsonData = TLWorkspace(
                            id: UniqueKey().toString(),
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
                        tlworkspaces.add(createdWorkspaceJsonData);
                        // 追加したことを知らせる
                        notifyWorkspaceIsAdded(
                            context: context,
                            newWorkspaceName:
                                _workspaceNameInputController.text);
                      } else {
                        // edit action
                        final TLWorkspace editedWorkspace =
                            TLWorkspace.fromJson(tlworkspaces[
                                widget.oldIndexInStringWorkspaces!]);
                        // 名前だけ変える
                        editedWorkspace.name =
                            _workspaceNameInputController.text;
                        // 消して元の場所に入れる
                        tlworkspaces
                            .removeAt(widget.oldIndexInStringWorkspaces!);
                        tlworkspaces.insert(
                          widget.oldIndexInStringWorkspaces!,
                          editedWorkspace.toJson(),
                        );

                        // currentWorkspaceの時
                        if (TLWorkspace.currentWorkspaceIndex ==
                            widget.oldIndexInStringWorkspaces!) {
                          TLWorkspace.currentWorkspace = editedWorkspace;
                          TLWorkspace.changeCurrentWorkspace(
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
                      TLWorkspace.saveWorkspaces();
                    }
                  },
                  child: Text(
                      widget.oldIndexInStringWorkspaces == null ? "追加" : "編集"))
            ],
          ),
          const SizedBox(
            height: 16,
          )
        ],
      ),
    );
  }
}
