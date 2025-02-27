import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popover/popover.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:today_list/view/component/common_ui_part/tl_circular_action_button.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/view/page/edit_todo_page/edit_todo_page.dart';

/// 中央の追加ボタン（Home画面のBottom Navigation Barに配置）
class CenterButtonOfHomeBottomNavBar extends ConsumerWidget {
  final bool doesCurrentWorkspaceExist;

  const CenterButtonOfHomeBottomNavBar({
    super.key,
    required this.doesCurrentWorkspaceExist,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeConfig tlThemeData = TLTheme.of(context);
    final tlAppState = ref.watch(tlAppStateProvider);

    return TLCircularActionButton(
      icon: Icons.add,
      backgroundColor: tlThemeData.whiteBasedColor,
      borderColor: Colors.black26,
      iconColor: tlThemeData.accentColor,
      onPressed: () => _handleOnPressed(context, ref, tlAppState, tlThemeData),
    );
  }

  // MARK: - ボタン押下時の処理
  /// ボタン押下時の動作を制御
  void _handleOnPressed(BuildContext context, WidgetRef ref, var tlAppState,
      TLThemeConfig tlThemeData) {
    if (doesCurrentWorkspaceExist) {
      // 既存のワークスペースがある場合、タスク編集画面へ遷移
      _navigateToEditToDoPage(context, tlAppState.currentWorkspaceID!);
    } else {
      // ワークスペースがない場合、ポップオーバーを表示
      _showWorkspaceSelectionPopover(context, tlAppState, tlThemeData);
    }
  }

  // MARK: - タスク編集画面への遷移
  void _navigateToEditToDoPage(BuildContext context, String workspaceID) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditToDoPage(corrWorkspaceID: workspaceID),
      ),
    );
  }

  // MARK: - ポップオーバーの表示
  void _showWorkspaceSelectionPopover(
      BuildContext context, var tlAppState, TLThemeConfig tlThemeData) {
    showPopover(
      context: context,
      backgroundColor: tlThemeData.whiteBasedColor,
      direction: PopoverDirection.top,
      width: 250,
      height: 300,
      shadow: [
        BoxShadow(
          color: tlThemeData.accentColor,
          blurRadius: 8,
        ),
      ],
      bodyBuilder: (context) {
        return ListView(
          padding: const EdgeInsets.only(top: 6, bottom: 36),
          children: [
            for (final workspace in tlAppState.tlWorkspaces)
              GestureDetector(
                onTap: () {
                  Navigator.pop(context); // ポップオーバーを閉じる
                  _navigateToEditToDoPage(context, workspace.id);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: 70),
                    child: Card(
                      color: tlThemeData.canTapCardColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          workspace.name,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: tlThemeData.accentColor,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
