import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/dialogs/common/single_option_dialog.dart';
import 'package:today_list/model/workspace/current_tl_workspace_provider.dart';
import '../../constants/styles.dart';
import '../../model/tl_theme.dart';
import '../../model/todo/tl_category.dart';
import '../../model/workspace/tl_workspace.dart';
import '../../model/workspace/tl_workspaces_provider.dart';
import '../../model/todo/tl_todos.dart';
import '../../model/external/tl_vibration.dart';

class AddOrEditWorkspaceDialog extends ConsumerStatefulWidget {
  final int? oldIndexInStringWorkspaces;
  const AddOrEditWorkspaceDialog(
      {super.key, required this.oldIndexInStringWorkspaces});

  @override
  _AddOrEditWorkspaceDialogState createState() =>
      _AddOrEditWorkspaceDialogState();
}

class _AddOrEditWorkspaceDialogState
    extends ConsumerState<AddOrEditWorkspaceDialog> {
  final TextEditingController _workspaceNameInputController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.oldIndexInStringWorkspaces != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final List<TLWorkspace> workspaces = ref.read(tlWorkspacesProvider);
        _workspaceNameInputController.text =
            workspaces[widget.oldIndexInStringWorkspaces!].name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final TLThemeData _tlThemeData = TLTheme.of(context);
    final List<TLWorkspace> _tlWorkspaces = ref.watch(tlWorkspacesProvider);
    final _currentTLWorkspaceNotifier =
        ref.read(currentTLWorkspaceProvider.notifier);
    final _currentTLWorkspaceIndex =
        _currentTLWorkspaceNotifier.currentTLWorkspaceIndex;

    return Dialog(
      backgroundColor: _tlThemeData.alertColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 28.0),
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
                  style:
                      alertButtonStyle(accentColor: _tlThemeData.accentColor),
                  onPressed: () => Navigator.pop(context),
                  child: const Text("閉じる")),
              // workspaceを追加するボタン
              TextButton(
                  style:
                      alertButtonStyle(accentColor: _tlThemeData.accentColor),
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
                        final createdWorkspace = TLWorkspace(
                            id: UniqueKey().toString(),
                            name: _workspaceNameInputController.text,
                            bigCategories: [
                              TLCategory(id: defaultID, title: "なし")
                            ],
                            smallCategories: {
                              defaultID: []
                            },
                            toDos: {
                              defaultID:
                                  TLToDos(toDosInToday: [], toDosInWhenever: [])
                            });
                        ref
                            .read(tlWorkspacesProvider.notifier)
                            .addTLWorkspace(newTLWorkspace: createdWorkspace);
                        // 追加したことを知らせる
                        notifyWorkspaceIsAdded(
                            context: context,
                            newWorkspaceName:
                                _workspaceNameInputController.text);
                      } else {
                        // edit action
                        final TLWorkspace editedWorkspace =
                            _tlWorkspaces[widget.oldIndexInStringWorkspaces!];
                        // 名前だけ変える
                        editedWorkspace.name =
                            _workspaceNameInputController.text;
                        // 更新する
                        ref
                            .read(tlWorkspacesProvider.notifier)
                            .updateCurrentTLWorkspace(
                              indexInWorkspaceList:
                                  widget.oldIndexInStringWorkspaces!,
                              updatedTLWorkspace: editedWorkspace,
                            );

                        // currentWorkspaceの時
                        if (_currentTLWorkspaceIndex ==
                            widget.oldIndexInStringWorkspaces!) {
                          _currentTLWorkspaceNotifier
                              .changeCurrentWorkspaceIndex(
                                  widget.oldIndexInStringWorkspaces!);
                        }
                        showDialog(
                          context: context,
                          builder: (context) => SingleOptionDialog(
                            title: "変更することに\n成功しました!",
                            message: null,
                            buttonText: "OK",
                          ),
                        );
                      }
                      TLVibration.vibrate();
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
