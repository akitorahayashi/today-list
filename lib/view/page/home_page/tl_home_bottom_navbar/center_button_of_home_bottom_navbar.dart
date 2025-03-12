import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:popover/popover.dart';
import 'package:today_list/model/design/tl_theme_config.dart';
import 'package:today_list/view/component/common_ui_part/tl_circular_action_button.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/flux/store/workspace_store.dart';
import 'package:today_list/flux/store/current_workspace_store.dart';
import 'package:today_list/view/page/add_todo_page/add_todo_page.dart';

/// 中央の追加ボタン（Home画面のBottom Navigation Barに配置）
class CenterButtonOfHomeBottomNavBar extends HookConsumerWidget {
  final bool doesCurrentWorkspaceExist;

  const CenterButtonOfHomeBottomNavBar({
    super.key,
    required this.doesCurrentWorkspaceExist,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // アニメーションコントローラーの初期化
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 300),
      initialValue: 1.0, // 初期状態では表示
    );

    // フェードアニメーションの設定
    final fadeAnimation = useAnimation(
      Tween<double>(
        begin: 0.0,
        end: 1.0,
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

    final TLThemeConfig tlThemeData = TLTheme.of(context);
    final workspacesAsync = ref.watch(workspacesProvider);
    final currentWorkspaceIdAsync = ref.watch(currentWorkspaceIdProvider);

    return Opacity(
      opacity: fadeAnimation,
      child: Builder(
        builder: (context) => TLCircularActionButton(
          icon: Icons.add,
          backgroundColor: tlThemeData.whiteBasedColor,
          borderColor: Colors.black26,
          iconColor: tlThemeData.accentColor,
          onPressed: () => _handleOnPressed(context, ref, workspacesAsync,
              currentWorkspaceIdAsync, tlThemeData),
        ),
      ),
    );
  }

  // MARK: - ボタン押下時の処理
  /// ボタン押下時の動作を制御
  void _handleOnPressed(
      BuildContext context,
      WidgetRef ref,
      AsyncValue<List<dynamic>> workspacesAsync,
      AsyncValue<String?> currentWorkspaceIdAsync,
      TLThemeConfig tlThemeData) {
    if (doesCurrentWorkspaceExist) {
      // 既存のワークスペースがある場合、タスク追加ページを表示
      currentWorkspaceIdAsync.whenData((currentWorkspaceId) {
        if (currentWorkspaceId != null) {
          _showAddToDoPage(context, ref, currentWorkspaceId);
        }
      });
    } else {
      // ワークスペースがない場合、ポップオーバーを表示
      workspacesAsync.whenData((workspaces) {
        _showWorkspaceSelectionPopover(context, ref, workspaces, tlThemeData);
      });
    }
  }

  // MARK: - タスク追加ページの表示
  void _showAddToDoPage(
      BuildContext context, WidgetRef ref, String workspaceID) {
    // 追加画面に遷移
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddToDoPage(
          workspaceID: workspaceID,
        ),
      ),
    );
  }

  // MARK: - ポップオーバーの表示
  void _showWorkspaceSelectionPopover(BuildContext context, WidgetRef ref,
      List<dynamic> workspaces, TLThemeConfig tlThemeData) {
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
            for (final workspace in workspaces)
              GestureDetector(
                onTap: () {
                  Navigator.pop(popoverContext); // ポップオーバーを閉じる

                  // ポップオーバーが閉じた後にボトムシートを表示するために遅延実行
                  Future.delayed(const Duration(milliseconds: 100), () {
                    if (context.mounted) {
                      _showAddToDoPage(context, ref, workspace.id);
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
}
