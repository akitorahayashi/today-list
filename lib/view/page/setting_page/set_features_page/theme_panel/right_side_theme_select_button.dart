import 'package:flutter/material.dart';
import 'package:today_list/redux/action/tl_theme_action.dart';
import 'package:today_list/redux/action/tl_user_data_action.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/view/component/dialog/app_icon/tl_theme_changed_dialog.dart';
import 'package:today_list/view/component/dialog/change_theme_dialog.dart';
import 'package:today_list/resource/tl_theme_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RightSideThemeSelectButton extends ConsumerStatefulWidget {
  final TLThemeType corrThemeType;
  const RightSideThemeSelectButton({
    super.key,
    required this.corrThemeType,
  });

  @override
  ConsumerState<RightSideThemeSelectButton> createState() =>
      _RightSideThemeSelectButtonState();
}

class _RightSideThemeSelectButtonState
    extends ConsumerState<RightSideThemeSelectButton> {
  @override
  Widget build(BuildContext context) {
    final TLThemeType corrThemeType = widget.corrThemeType;
    final double deviceWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () async {
        // テーマ変更ダイアログを表示
        final result = await ChangeThemeDialog(
          corrThemeType: corrThemeType,
        ).show(context: context);

        // ユーザーがテーマ変更を確認した場合のみ処理を実行
        if (result == true && context.mounted) {
          // テーマを変更
          await ref.read(tlAppStateProvider.notifier).updateState(
              TLThemeAction.changeTheme(newThemeType: corrThemeType));

          // アプリアイコンも変更
          await ref.read(tlAppStateProvider.notifier).updateState(
              TLUserDataAction.updateCurrentAppIconName(
                  newThemeName: corrThemeType.config.themeName));

          // 変更完了ダイアログを表示
          if (context.mounted) {
            await TLThemeChangedDialog(
              themeConfig: corrThemeType.config,
              iconName: corrThemeType.config.themeName,
            ).show(context: context);
          }
        }
      },
      child: Container(
          width: deviceWidth / 2 - 50,
          height: 150,
          decoration: BoxDecoration(
              gradient: corrThemeType.config.gradientOfNavBar,
              borderRadius: BorderRadius.circular(10)),
          // ガラス
          child: Align(
            alignment: Alignment.center,
            // todoのカードを表示
            child: Card(
              elevation: 5,
              color: corrThemeType.config.canTapCardColor,
              child: SizedBox(
                width: deviceWidth / 2 - 70,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: FaIcon(
                          FontAwesomeIcons.square,
                          color: corrThemeType.config.checkmarkColor,
                        ),
                      ),
                      Text(
                        corrThemeType.config.themeTitleInSettings,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: corrThemeType.config.checkmarkColor,
                            fontSize: 12,
                            letterSpacing: 2,
                            fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
