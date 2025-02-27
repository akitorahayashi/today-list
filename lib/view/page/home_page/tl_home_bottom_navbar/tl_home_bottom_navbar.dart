import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:today_list/view/component/common_ui_part/tl_animated_icon_button.dart';
import 'package:today_list/view/component/dialog/common/tl_single_option_dialog.dart';
import 'package:today_list/view/component/dialog/common/tl_yes_no_dialog.dart';
import 'package:today_list/view/page/category_list_page/category_list_page.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/redux/action/tl_app_state_action.dart';
import 'package:today_list/redux/action/tl_workspace_action.dart';

// MARK: - TLHomeBottomNavBar Widget
class TLHomeBottomNavBar extends ConsumerWidget {
  const TLHomeBottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeConfig tlThemeData = TLTheme.of(context);
    final tlAppState = ref.watch(tlAppStateProvider);

    final bool doesCurrentWorkspaceExist =
        tlAppState.currentWorkspaceID != null;
    const double centerButtonSize = 48;
    const double bottomNavBarHeight = 65;

    const IconData leadingIconData = FontAwesomeIcons.squareCheck;
    const IconData trailingIconData = FontAwesomeIcons.list;

    return Stack(
      children: [
        // MARK: - グラデーションの背景
        Positioned.fill(
          child: Container(
            height: bottomNavBarHeight,
            decoration: BoxDecoration(
              gradient: tlThemeData.gradientOfNavBar,
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
                  onPressed: () => _onTrailingButtonPressed(
                      context, ref, doesCurrentWorkspaceExist),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // MARK: - 削除ボタン押下時の処理
  void _onLeadingButtonPressed(
      BuildContext context, WidgetRef ref, bool doesCurrentWorkspaceExist) {
    final tlAppState = ref.read(tlAppStateProvider);
    final currentWorkspaceID = tlAppState.currentWorkspaceID;

    TLYesNoDialog(
      title: "Do you want to delete\nchecked ToDos?",
      message: null,
      yesAction: () async {
        Navigator.pop(context);

        if (doesCurrentWorkspaceExist && currentWorkspaceID != null) {
          ref.read(tlAppStateProvider.notifier).updateState(
                TLWorkspaceAction.deleteAllCheckedToDosInWorkspace(tlAppState
                    .tlWorkspaces
                    .firstWhere((ws) => ws.id == currentWorkspaceID)),
              );
        } else {
          ref.read(tlAppStateProvider.notifier).updateState(
                TLAppStateAction.deleteAllCheckedToDosInTodayInWorkspaceList(
                    tlAppState.tlWorkspaces),
              );
        }

        if (context.mounted) {
          const TLSingleOptionDialog(title: "Deletion completed")
              .show(context: context);
        }
      },
    ).show(context: context);
  }

  // MARK: - カテゴリ一覧 or ドロワーを開く処理
  void _onTrailingButtonPressed(
      BuildContext context, WidgetRef ref, bool doesCurrentWorkspaceExist) {
    final tlAppState = ref.read(tlAppStateProvider);
    final currentWorkspaceID = tlAppState.currentWorkspaceID;

    if (doesCurrentWorkspaceExist && currentWorkspaceID != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              CategoryListPage(corrWorkspaceID: currentWorkspaceID),
        ),
      );
    } else {
      Scaffold.of(context).openDrawer();
    }
  }
}
