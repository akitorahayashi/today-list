import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popover/popover.dart';
import 'package:today_list/model/design/tl_theme_config.dart';
import 'package:today_list/view/component/common_ui_part/tl_circular_action_button.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/view/page/home_page/add_todo_sheet/add_todo_sheet.dart';

// ボトムシートの表示状態を管理するプロバイダー
final bottomSheetVisibilityProvider = StateProvider<bool>((ref) => false);

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

    return Builder(
      builder: (context) => TLCircularActionButton(
        icon: Icons.add,
        backgroundColor: tlThemeData.whiteBasedColor,
        borderColor: Colors.black26,
        iconColor: tlThemeData.accentColor,
        onPressed: () =>
            _handleOnPressed(context, ref, tlAppState, tlThemeData),
      ),
    );
  }

  // MARK: - ボタン押下時の処理
  /// ボタン押下時の動作を制御
  void _handleOnPressed(BuildContext context, WidgetRef ref, var tlAppState,
      TLThemeConfig tlThemeData) {
    if (doesCurrentWorkspaceExist) {
      // 既存のワークスペースがある場合、タスク追加シートを表示
      _showAddToDoSheet(context, ref, tlAppState.currentWorkspaceID!);
    } else {
      // ワークスペースがない場合、ポップオーバーを表示
      _showWorkspaceSelectionPopover(context, ref, tlAppState, tlThemeData);
    }
  }

  // MARK: - タスク追加シートの表示
  void _showAddToDoSheet(
      BuildContext context, WidgetRef ref, String workspaceID) {
    // モーダルボトムシートを表示
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddToDoSheet(
        workspaceID: workspaceID,
        onComplete: () {
          // シートを閉じる
          Navigator.pop(context);
        },
      ),
    );
  }

  // MARK: - ポップオーバーの表示
  void _showWorkspaceSelectionPopover(BuildContext context, WidgetRef ref,
      var tlAppState, TLThemeConfig tlThemeData) {
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
      bodyBuilder: (popoverContext) {
        return ListView(
          padding: const EdgeInsets.only(top: 6, bottom: 36),
          children: [
            for (final workspace in tlAppState.tlWorkspaces)
              GestureDetector(
                onTap: () {
                  Navigator.pop(popoverContext); // ポップオーバーを閉じる

                  // ポップオーバーが閉じた後にボトムシートを表示するために遅延実行
                  Future.delayed(const Duration(milliseconds: 100), () {
                    if (context.mounted) {
                      _showAddToDoSheet(context, ref, workspace.id);
                    }
                  });
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

  // ボトムシートを閉じるメソッド（静的メソッド）
  static void closeBottomSheet(WidgetRef ref) {
    // 状態を更新
    try {
      ref.read(bottomSheetVisibilityProvider.notifier).state = false;
    } catch (e) {
      // refが既に破棄されている場合のエラーを防止
    }
  }
}
