import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/view/component/dialog/common/tl_yes_no_dialog.dart';
import 'package:today_list/view/component/todo_card/tl_checkbox.dart';
import 'package:today_list/service/tl_vibration.dart';
import 'package:today_list/view_model/design/theme_idx_provider.dart';
import 'package:today_list/view_model/settings/setting_data_provider.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/model/setting_data/setting_data.dart';

class UpdaateAppIconCard extends ConsumerWidget {
  const UpdaateAppIconCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeData tlThemeData = TLTheme.of(context);
    final deviceWidth = MediaQuery.of(context).size.width;
    // provider
    final int selectedThemeIdx = ref.watch(selectedThemeIndexProvider);
    final SettingData settingData = ref.watch(settingDataProvider);
    // notifier
    final SettingDataNotifier settingDataNotifier =
        ref.read(settingDataProvider.notifier);
    final bool isMatched = settingData.currentAppIconName ==
        tlThemeDataList[selectedThemeIdx].themeName;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        width: deviceWidth - 50,
        child: GestureDetector(
          onTap: isMatched
              ? null
              : () async {
                  await TLYesNoDialog(
                    title: "アプリアイコンの変更",
                    message: "テーマに合ったアプリアイコンに変更しますか？",
                    yesAction: () {
                      Navigator.pop(context);
                      TLVibrationService.vibrate();
                      settingDataNotifier.changeIcon(
                          themeName:
                              tlThemeDataList[selectedThemeIdx].themeName);
                    },
                  ).show(context: context);
                },
          child: Card(
            // 色
            color: tlThemeData.panelColor,
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
                                    ? tlThemeData.checkmarkColor
                                    : Colors.black.withOpacity(0.6),
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
