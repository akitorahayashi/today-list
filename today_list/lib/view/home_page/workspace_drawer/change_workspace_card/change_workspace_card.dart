import 'package:flutter/material.dart';
import '../../../../model/external/tl_vibration.dart';
import '../../../../model/workspace/tl_workspace.dart';
import '../../../../model/workspace/tl_workspaces_provider.dart';
import '../../../../model/tl_theme.dart';
import 'notify_current_workspace_is_changed.dart';
import 'slidable_for_workspace_card.dart';

class ChangeWorkspaceCard extends StatefulWidget {
  final bool isDisplayMode;
  final int indexInWorkspaces;
  const ChangeWorkspaceCard({
    Key? key,
    required this.isDisplayMode,
    required this.indexInWorkspaces,
  }) : super(key: key);

  @override
  State<ChangeWorkspaceCard> createState() => _ChangeWorkspaceCardState();
}

class _ChangeWorkspaceCardState extends State<ChangeWorkspaceCard> {
  bool get isCurrentWorkspace =>
      widget.indexInWorkspaces == TLWorkspace.currentWorkspaceIndex;

  @override
  Widget build(BuildContext context) {
    final TLThemeData _tlThemeData = TLTheme.of(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(
          5, 1, 5, (isCurrentWorkspace && !widget.isDisplayMode) ? 5 : 0),
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
                  if (isCurrentWorkspace) {
                    Navigator.pop(context);
                  } else {
                    TLWorkspace.changeCurrentWorkspace(
                        newWorkspaceIndex: widget.indexInWorkspaces);
                    TLVibration.vibrate();
                    Navigator.pop(context);
                    notifyCurrentWorkspaceIsChanged(
                        context: context,
                        newWorkspaceName: TLWorkspace.currentWorkspace.name);
                  }
                },
                child: SlidableForWorkspaceCard(
                  isInDrawerList: true,
                  isCurrentWorkspace: isCurrentWorkspace,
                  indexInTLWorkspaces: widget.indexInWorkspaces,
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                      child: Text(
                          (isCurrentWorkspace && widget.isDisplayMode
                                  ? "☆ "
                                  : "") +
                              (isCurrentWorkspace
                                  ? TLWorkspace.currentWorkspace.name
                                  : _initialTLWorkspaces[
                                      widget.indexInWorkspaces]["name"]) +
                              ((isCurrentWorkspace && widget.isDisplayMode)
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
