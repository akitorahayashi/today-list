import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../common/tl_single_option_dialog.dart';
import '../../../style/styles.dart';
import '../../../model/design/tl_theme.dart';
import '../../../model/todo/tl_category.dart';
import '../../../model/tl_workspace.dart';
import '../../../model/provider/tl_workspaces_provider.dart';
import '../../../model/todo/tl_todos.dart';
import '../../../model/external/tl_vibration.dart';

class AddOrEditWorkspaceDialog extends ConsumerStatefulWidget {
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
      final List<TLWorkspace> workspaces = ref.read(tlWorkspacesProvider);
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
    final List<TLWorkspace> tlWorkspaces = ref.watch(tlWorkspacesProvider);
    // notifier
    TLWorkspacesNotifier tlWorkspacesNotifier =
        ref.read(tlWorkspacesProvider.notifier);

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
                            .read(tlWorkspacesProvider.notifier)
                            .addWorkspace(newTLWorkspace: createdWorkspace);
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
                                todo
                        showDialog(
                          context: context,
                          builder: (context) => const TLSingleOptionDialog(
                            title: "変更することに\n成功しました！",
                            message: null,
                          ),
                        );
                      }
                      TLVibration.vibrate();
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
