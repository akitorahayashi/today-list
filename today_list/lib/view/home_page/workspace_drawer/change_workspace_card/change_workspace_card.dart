import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/dialogs/common/single_option_dialog.dart';
import 'package:today_list/model/workspace/current_tl_workspace_provider.dart';
import '../../../../model/external/tl_vibration.dart';
import '../../../../model/workspace/tl_workspace.dart';
import '../../../../model/workspace/tl_workspaces_provider.dart';
import '../../../../model/tl_theme.dart';
import 'notify_current_workspace_is_changed.dart';
import '../../../../slidables/slidable_for_workspace_card.dart';

class ChangeWorkspaceCard extends ConsumerWidget {
  final bool isInDrawerList;
  final int indexInWorkspaces;
  const ChangeWorkspaceCard({
    Key? key,
    required this.isInDrawerList,
    required this.indexInWorkspaces,
  }) : super(key: key);

  bool get  =>
      widget.indexInWorkspaces == TLWorkspace.currentWorkspaceIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeData _tlThemeData = TLTheme.of(context);
    final CurrentTLWorkspaceNotifier _currentTLWorkspaceNotifier =
        ref.read(currentTLWorkspaceProvider.notifier);
        final int _currentTLWorkspaceIndex = _currentTLWorkspaceNotifier.currentTLWorkspaceIndex;
    final bool _isCurrentWorkspace =
        indexInWorkspaces == TLWorkspace.currentWorkspaceIndex;
    return Padding(
      padding: EdgeInsets.fromLTRB(
          5, 1, 5, (_isCurrentWorkspace && !widget.isInDrawerList) ? 5 : 0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 70),
        child: Card(
          color: _tlThemeData.panelColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: GestureDetector(
                onTap: () async {
                  if (_isCurrentWorkspace) {
                    Navigator.pop(context);
                  } else {
                    TLWorkspace.changeCurrentWorkspace(
                        newWorkspaceIndex: widget.indexInWorkspaces);
                    TLVibration.vibrate();
                    Navigator.pop(context);
                    showDialog(context: context, builder: (context) => SingleOptionDialog(title: title, message: message, buttonText: buttonText))
                    notifyCurrentWorkspaceIsChanged(
                        context: context,
                        newWorkspaceName: TLWorkspace.currentWorkspace.name);
                  }
                },
                child: SlidableForWorkspaceCard(
                  isInDrawerList: true,
                  isCurrentWorkspace: _isCurrentWorkspace,
                  indexInTLWorkspaces: widget.indexInWorkspaces,
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                      child: Text(
                          (_isCurrentWorkspace && widget.isInDrawerList
                                  ? "☆ "
                                  : "") +
                              (_isCurrentWorkspace
                                  ? TLWorkspace.currentWorkspace.name
                                  : _initialTLWorkspaces[
                                      widget.indexInWorkspaces]["name"]) +
                              ((_isCurrentWorkspace && widget.isInDrawerList)
                                  ? "   "
                                  : ""),
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: _tlThemeData.accentColor,
                              letterSpacing: 1)),
                    ),
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
