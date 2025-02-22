import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/action/tl_workspace_action.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/view/component/dialog/common/tl_single_option_dialog.dart';
import 'package:today_list/view/component/slidable/slidable_for_workspace_card.dart';
import 'dart:ui';

class ChangeWorkspaceCard extends ConsumerWidget {
  final bool isDefaultWorkspace;
  final TLWorkspace corrWorkspace;

  const ChangeWorkspaceCard({
    super.key,
    required this.isDefaultWorkspace,
    required this.corrWorkspace,
  });

  // MARK: - UI (Build)
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeConfig theme = TLTheme.of(context);
    final String? currentWorkspaceId = ref
        .watch(tlAppStateProvider.select((state) => state.currentWorkspaceID));
    final bool isCurrentWorkspace = corrWorkspace.id == currentWorkspaceId;

    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 1, 5, 0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 70),
        child: Card(
          color: theme.canTapCardColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: GestureDetector(
              onTap: () => _handleWorkspaceSelection(ref, isCurrentWorkspace),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: SlidableForWorkspaceCard(
                  isCurrentWorkspace: isCurrentWorkspace,
                  corrWorkspace: corrWorkspace,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          isCurrentWorkspace
                              ? "☆ ${corrWorkspace.name}   "
                              : corrWorkspace.name,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: theme.accentColor,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // MARK: - Handle Workspace Selection
  void _handleWorkspaceSelection(WidgetRef ref, bool isCurrentWorkspace) async {
    if (isCurrentWorkspace) {
      Navigator.pop(ref.context);
      return;
    }

    await ref.read(tlAppStateProvider.notifier).dispatchWorkspaceAction(
          TLWorkspaceAction.changeCurrentWorkspaceID(corrWorkspace.id),
        );

    if (ref.context.mounted) {
      Navigator.pop(ref.context);
      TLSingleOptionDialog(
        title: corrWorkspace.name,
        message: "に変更しました！",
      ).show(context: ref.context);
    }
  }
}
