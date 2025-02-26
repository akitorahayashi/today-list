import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popover/popover.dart';
import 'package:today_list/view/component/common_ui_part/tl_circular_action_button.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/view/page/edit_todo_page/edit_todo_page.dart';

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

    final GlobalKey buttonKey = GlobalKey(); // ボタンの位置を特定するためのキー

    return TLCircularActionButton(
      key: buttonKey,
      icon: Icons.add,
      backgroundColor: Colors.white,
      borderColor: Colors.black26,
      iconColor: tlThemeData.accentColor,
      onPressed: () {
        if (doesCurrentWorkspaceExist) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return EditToDoPage(
                  corrWorkspaceID: tlAppState.currentWorkspaceID!,
                );
              },
            ),
          );
        } else {
          showPopover(
            context: context,
            backgroundColor: tlThemeData.backgroundColor,
            direction: PopoverDirection.top,
            width: 250,
            height: 300,
            shadow: [
              BoxShadow(
                color: tlThemeData.accentColor,
                blurRadius: 5,
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return EditToDoPage(
                                  corrWorkspaceID: workspace.id,
                                );
                              },
                            ),
                          );
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
                                  child: Text(workspace.name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                        color: tlThemeData.accentColor,
                                        letterSpacing: 1,
                                      ))),
                            ),
                          ),
                        ))
                ],
              );
            },
          );
        }
      },
    );
  }
}
