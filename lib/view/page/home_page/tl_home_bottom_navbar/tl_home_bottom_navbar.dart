import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/view/component/common_ui_part/tl_animated_icon_button.dart';
import 'package:today_list/view/component/dialog/common/tl_single_option_dialog.dart';
import 'package:today_list/view/component/dialog/common/tl_yes_no_dialog.dart';
import 'package:today_list/flux/store/workspace_store.dart';
import 'package:today_list/flux/store/current_workspace_store.dart';
import 'package:today_list/flux/action/todo_action.dart';
import 'package:today_list/flux/dispatcher/todo_dispatcher.dart';

/// ホーム画面のボトムナビゲーションバー
class TLHomeBottomNavBar extends HookConsumerWidget {
  const TLHomeBottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // アニメーションコントローラーの初期化
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 300),
      initialValue: 1.0, // 初期状態では表示
    );

    // スライドアニメーションの設定
    final slideAnimation = useAnimation(
      Tween<Offset>(
        begin: const Offset(0, 1), // 画面外から
        end: const Offset(0, 0), // 画面内へ
      ).animate(CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      )),
    );

    // キーボードの表示状態を取得
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    // キーボードの表示状態が変わったときのエフェクト
    useEffect(() {
      if (isKeyboardVisible) {
        // キーボードが表示されたらアニメーションを逆再生（非表示に）
        animationController.reverse();
      } else {
        // キーボードが非表示になったらアニメーションを再生（表示に）
        animationController.forward();
      }
      return null;
    }, [isKeyboardVisible]);

    final tlThemeConfig = TLTheme.of(context);
    final currentWorkspaceIdAsync = ref.watch(currentWorkspaceIdProvider);

    final bool doesCurrentWorkspaceExist = currentWorkspaceIdAsync.maybeWhen(
      data: (id) => id != null,
      orElse: () => false,
    );
    const double centerButtonSize = 48;
    const double bottomNavBarHeight = 65;

    const IconData leadingIconData = FontAwesomeIcons.squareCheck;
    const IconData trailingIconData = FontAwesomeIcons.list;

    return Transform.translate(
      offset: slideAnimation,
      child: Stack(
        children: [
          // MARK: - グラデーションの背景
          Positioned.fill(
            child: Container(
              height: bottomNavBarHeight,
              decoration: BoxDecoration(
                gradient: tlThemeConfig.gradientOfNavBar,
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 8,
                    color: Colors.black45,
                  ),
                ],
              ),
            ),
          ),

          // MARK: - Bottom Navigation Bar
          BottomAppBar(
            color: Colors.transparent,
            height: bottomNavBarHeight,
            child: Center(
              child: OverflowBar(
                alignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // MARK: - 削除ボタン
                  TLAnimatedIconButton(
                    size: 33,
                    icon: leadingIconData,
                    onPressed: () => _onLeadingButtonPressed(
                        context, ref, doesCurrentWorkspaceExist),
                  ),

                  const SizedBox(width: centerButtonSize), // 中央のボタン用のスペース

                  // MARK: - カテゴリ一覧 or ドロワーボタン
                  TLAnimatedIconButton(
                      size: 33,
                      icon: trailingIconData,
                      onPressed: () => Scaffold.of(context).openDrawer()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // MARK: - 削除ボタン押下時の処理
  void _onLeadingButtonPressed(
      BuildContext context, WidgetRef ref, bool doesCurrentWorkspaceExist) {
    final workspacesAsync = ref.read(workspacesProvider);
    final currentWorkspaceIdAsync = ref.read(currentWorkspaceIdProvider);

    TLYesNoDialog(
      title: "Do you want to delete\nchecked ToDos?",
      message: null,
      yesAction: () async {
        Navigator.pop(context);

        if (doesCurrentWorkspaceExist) {
          currentWorkspaceIdAsync.whenData((currentWorkspaceId) {
            if (currentWorkspaceId != null) {
              workspacesAsync.whenData((workspaces) {
                final currentWorkspace = workspaces.firstWhere(
                  (workspace) => workspace.id == currentWorkspaceId,
                  orElse: () => workspaces.first,
                );

                TodoDispatcher.dispatch(
                  ref,
                  TodoAction.deleteAllCheckedTodos(
                    workspace: currentWorkspace,
                    ifInToday: true,
                  ),
                );
              });
            }
          });
        } else {
          workspacesAsync.whenData((workspaces) {
            for (final workspace in workspaces) {
              TodoDispatcher.dispatch(
                ref,
                TodoAction.deleteAllCheckedTodos(
                  workspace: workspace,
                  ifInToday: true,
                ),
              );
            }
          });
        }

        if (context.mounted) {
          const TLSingleOptionDialog(title: "Deletion completed")
              .show(context: context);
        }
      },
    ).show(context: context);
  }
}
