import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/redux/action/todo/tl_workspace_action.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/resource/initial_tl_workspaces.dart';
import 'package:today_list/util/tl_validation.dart';
import 'package:today_list/view/component/dialog/tl_base_dialog_mixin.dart';
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

  Future<void> _onEditSuccess(BuildContext context,
      List<TLWorkspace> tlWorkspaces, int oldIndex, String newName) async {
    // notifier
    final tlAppStateReducer = ref.read(tlAppStateProvider.notifier);

    final TLWorkspace editedWorkspace = tlWorkspaces[oldIndex];
    tlWorkspaces[oldIndex] = editedWorkspace.copyWith(name: newName);
    tlAppStateReducer.dispatchWorkspaceAction(
        TLWorkspaceAction.updateWorkspaceList(
            List<TLWorkspace>.from(tlWorkspaces)));
    const TLSingleOptionDialog(title: "変更することに\n成功しました！")
        .show(context: context);
  }

  Future<void> _onAddSuccess(
      BuildContext context, String workspaceName, WidgetRef ref) async {
    // 新しくできたWorkspace
    final createdWorkspace = TLWorkspace(
        id: UniqueKey().toString(),
        name: workspaceName,
        bigCategories: [
          const TLCategory(id: noneID, title: "なし")
        ],
        smallCategories: {
          noneID: []
        },
        categoryIDToToDos: {
          noneID: const TLToDos(toDosInToday: [], toDosInWhenever: [])
        });
    ref.read(tlAppStateProvider.notifier).dispatchWorkspaceAction(
        TLWorkspaceAction.addWorkspace(createdWorkspace));
    TLSingleOptionDialog(title: workspaceName, message: "が追加されました!")
        .show(context: context);
  }

  @override
  void initState() {
    super.initState();
    if (widget.oldIndexInWorkspaces == null) return;
    Future.microtask(() {
      final List<TLWorkspace> workspaces =
          ref.read(tlAppStateProvider).tlWorkspaces;
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
        ref.watch(tlAppStateProvider).tlWorkspaces;

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
                  onPressed: () async {
                    TLVibrationService.vibrate();
                    final workspaceName = _workspaceNameInputController.text;
                    // バリデーションを実施し、成功した場合は該当する処理を実行
                    await TLValidation.validateNameAndExecute(
                        context: context,
                        name: workspaceName,
                        validator: TLValidation.validateWorkspaceName,
                        onSuccess: () async {
                          Navigator.pop(context);
                          if (widget.oldIndexInWorkspaces == null) {
                            // add action
                            await _onAddSuccess(context, workspaceName, ref);
                          } else {
                            // edit action
                            await _onEditSuccess(context, tlWorkspaces,
                                widget.oldIndexInWorkspaces!, workspaceName);
                          }
                        });
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
