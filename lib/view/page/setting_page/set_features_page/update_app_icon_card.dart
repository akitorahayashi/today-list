import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/design/tl_theme_config.dart';
import 'package:today_list/redux/action/tl_user_data_action.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/view/component/dialog/common/tl_yes_no_dialog.dart';
import 'package:today_list/view/component/todo_card/tl_checkbox.dart';
import 'package:today_list/service/tl_vibration.dart';
import 'package:today_list/model/design/tl_theme.dart';

class UpdateAppIconCard extends ConsumerWidget {
  const UpdateAppIconCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeConfig tlThemeConfig = TLTheme.of(context);
    final deviceWidth = MediaQuery.of(context).size.width;
    // provider
    final String currentAppIconName = ref.watch(tlAppStateProvider
        .select((state) => state.tlUserData.currentAppIconName));
    // notifier
    final TLAppStateController tlAppStateController =
        ref.read(tlAppStateProvider.notifier);
    final bool isMatched = currentAppIconName == tlThemeConfig.themeName;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        width: deviceWidth - 50,
        child: GestureDetector(
          onTap: isMatched
              ? null
              : () async {
                  await TLYesNoDialog(
                    title: "Change App Icon",
                    message: "Change the app icon to match the theme?",
                    yesAction: () {
                      if (context.mounted) {
                        Navigator.pop(context);
                        TLVibrationService.vibrate();
                        tlAppStateController.updateState(
                            TLUserDataAction.updateCurrentAppIconName(
                                newThemeName: tlThemeConfig.themeName));
                      }
                    },
                  ).show(context: context);
                },
          child: Card(
            // 色
            color: tlThemeConfig.canTapCardColor,
            // 浮き具合
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              // child
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 18, 16, 15),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        // 左側のチェックボックス
                        Padding(
                          padding: const EdgeInsets.fromLTRB(4, 0, 16, 0),
                          // const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                          child: Transform.scale(
                            scale: 1.2,
                            child: TLCheckBox(
                              isChecked: isMatched,
                            ),
                          ),
                        ),
                        // toDoのタイトル
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Match the app icon to the theme.",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: isMatched
                                    ? tlThemeConfig.checkmarkColor
                                    : Colors.black.withValues(alpha: 0.6),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
