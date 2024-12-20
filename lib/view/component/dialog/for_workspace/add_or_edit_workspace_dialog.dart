import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/view/component/dialog/tl_base_dialog_mixin.dart';
import 'package:today_list/view_model/todo/tl_workspaces_state.dart';
import '../common/tl_single_option_dialog.dart';
import '../../../../styles.dart';
import '../../../../model/design/tl_theme.dart';
import '../../../../model/todo/tl_category.dart';
import '../../../../model/todo/tl_workspace.dart';
import '../../../../model/todo/tl_todos.dart';
import '../../../../service/tl_vibration.dart';

class AddOrEditWorkspaceDialog extends ConsumerStatefulWidget
    with TLBaseDialogMixin {
  final int? oldIndexInWorkspaces;
  const AddOrEditWorkspaceDialog(
      {super.key, required this.oldIndexInWorkspaces});

  @override
  ConsumerState<AddOrEditWorkspaceDialog> createState() =>
      _AddOrEditWorkspaceDialogState();
}

class _AddOrEditWorkspaceDialogState
    extends ConsumerState<AddOrEditWorkspaceDialog> {
  final TextEditingController _workspaceNameInputController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.oldIndexInWorkspaces == null) return;
    Future.microtask(() {
      final List<TLWorkspace> workspaces =
          ref.read(tlWorkspacesStateProvider).tlWorkspaces;
      _workspaceNameInputController.text =
          workspaces[widget.oldIndexInWorkspaces!].name;
    });
  }

  @override
  dispose() {
    _workspaceNameInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TLThemeData tlThemeData = TLTheme.of(context);
    final List<TLWorkspace> tlWorkspaces =
        ref.watch(tlWorkspacesStateProvider).tlWorkspaces;
    // notifier
    TLWorkspacesStateNotifier tlWorkspacesNotifier =
        ref.read(tlWorkspacesStateProvider.notifier);

    return Dialog(
      backgroundColor: tlThemeData.alertColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 28.0),
            child: Text(
              "Workspace",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(0.4)),
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
                  cursorColor: tlThemeData.accentColor,
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
                  style: alertButtonStyle(accentColor: tlThemeData.accentColor),
                  onPressed: () => Navigator.pop(context),
                  child: const Text("閉じる")),
              // workspaceを追加するボタン
              TextButton(
                  style: alertButtonStyle(accentColor: tlThemeData.accentColor),
                  onPressed: () {
                    if (_workspaceNameInputController.text.trim().isEmpty) {
                      // 入力されていなければ退場
                      Navigator.pop(context);
                    } else {
                      // アラートを閉じる
                      Navigator.pop(context);
                      // workspacesを更新
                      if (widget.oldIndexInWorkspaces == null) {
                        // add action
                        // 新しくできたWorkspace
                        final createdWorkspace = TLWorkspace(
                            id: UniqueKey().toString(),
                            name: _workspaceNameInputController.text,
                            bigCategories: [
                              TLCategory(id: noneID, title: "なし")
                            ],
                            smallCategories: {
                              noneID: []
                            },
                            categoryIDToToDos: {
                              noneID:
                                  TLToDos(toDosInToday: [], toDosInWhenever: [])
                            });
                        ref
                            .read(tlWorkspacesStateProvider.notifier)
                            .addWorkspace(createdWorkspace);
                        // 追加したことを知らせる
                        showDialog(
                            context: context,
                            builder: (context) => TLSingleOptionDialog(
                                title: _workspaceNameInputController.text,
                                message: "が追加されました!"));
                      } else {
                        // edit action
                        final TLWorkspace editedWorkspace =
                            tlWorkspaces[widget.oldIndexInWorkspaces!];
                        // 名前だけ変える
                        editedWorkspace.name =
                            _workspaceNameInputController.text;
                        tlWorkspacesNotifier.updateTLWorkspaceList(
                            updatedTLWorkspaceList:
                                List<TLWorkspace>.from(tlWorkspaces));
                        const TLSingleOptionDialog(title: "変更することに\n成功しました！")
                            .show(context: context);
                      }
                      TLVibrationService.vibrate();
                    }
                  },
                  child:
                      Text(widget.oldIndexInWorkspaces == null ? "追加" : "編集"))
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
