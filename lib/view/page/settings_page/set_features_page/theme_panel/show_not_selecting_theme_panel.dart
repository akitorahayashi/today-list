import 'package:flutter/material.dart';
import 'package:today_list/flux/action/theme_action.dart';
import 'package:today_list/flux/action/user_data_action.dart';
import 'package:today_list/flux/dispatcher/theme_dispatcher.dart';
import 'package:today_list/flux/dispatcher/user_data_dispatcher.dart';
import 'package:today_list/view/component/dialog/change_theme_dialog.dart';
import 'package:today_list/resource/tl_theme_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:today_list/view/component/dialog/common/tl_single_option_dialog.dart';

class ShowNotSelectingThemePanel extends ConsumerStatefulWidget {
  final TLThemeType corrThemeType;
  const ShowNotSelectingThemePanel({
    super.key,
    required this.corrThemeType,
  });

  @override
  ConsumerState<ShowNotSelectingThemePanel> createState() =>
      _RightSideThemeSelectButtonState();
}

class _RightSideThemeSelectButtonState
    extends ConsumerState<ShowNotSelectingThemePanel> {
  @override
  Widget build(BuildContext context) {
    final TLThemeType corrThemeType = widget.corrThemeType;

    return GestureDetector(
      onTap: () async {
        // テーマ変更ダイアログを表示
        final result = await ChangeThemeDialog(
          corrThemeType: corrThemeType,
        ).show(context: context);

        // ユーザーがテーマ変更を確認した場合のみ処理を実行
        if (result == true && context.mounted) {
          // テーマを変更
          await ThemeDispatcher.dispatch(
            ref,
            ThemeAction.changeTheme(newThemeType: corrThemeType),
          );

          // アプリアイコンも変更
          await UserDataDispatcher.dispatch(
            ref,
            UserDataAction.updateCurrentAppIconName(
              newThemeName: corrThemeType.config.themeName,
            ),
          );

          if (context.mounted) {
            const TLSingleOptionDialog(
              title: "Theme Changed",
            ).show(context: context);
          }
        }
      },
      child: Container(
          width: 120, // 幅を調整
          height: 120, // 高さを固定
          decoration: BoxDecoration(
              gradient: corrThemeType.config.gradientOfNavBar,
              borderRadius: BorderRadius.circular(10)),
          // ガラス
          child: Align(
            alignment: Alignment.center,
            // todoのカードを表示
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Card(
                elevation: 5,
                color: corrThemeType.config.canTapCardColor,
                child: SizedBox(
                  width: 100, // カードの幅を調整
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          corrThemeType.config.themeTitleInSettings,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: corrThemeType.config.accentColor,
                              fontSize: 14, // フォントサイズを調整
                              letterSpacing: 1,
                              fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 6),
                        FaIcon(
                          FontAwesomeIcons.square,
                          color: corrThemeType.config.accentColor,
                          size: 20, // アイコンサイズを調整
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
