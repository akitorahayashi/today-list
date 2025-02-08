import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/redux/action/tl_theme_action.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/resource/tl_theme_type.dart';
import 'package:today_list/view/component/dialog/tl_base_dialog_mixin.dart';
import 'package:today_list/styles.dart';
import 'package:today_list/view/component/dialog/common/tl_single_option_dialog.dart';

import 'package:glassmorphism_ui/glassmorphism_ui.dart';

class ChangeThemeDialog extends ConsumerWidget with TLBaseDialogMixin {
  final TLThemeType corrThemeType;
  const ChangeThemeDialog({
    super.key,
    required this.corrThemeType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final corrThemeConfig = corrThemeType.config;
    final tlAppStateNotifier = ref.watch(tlAppStateProvider.notifier);
    return Dialog(
      backgroundColor: corrThemeConfig.alertColor,
      child: DefaultTextStyle(
        style: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black45),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // テーマの模型
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: SizedBox(
                width: 250,
                height: 80,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: corrThemeConfig.gradientOfNavBar,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: GlassContainer(
                    child: Align(
                      alignment: Alignment.center,
                      child: Card(
                        elevation: 5,
                        color: corrThemeConfig.panelColor,
                        child: Container(
                          width: 150,
                          height: 50,
                          alignment: Alignment.center,
                          child: Text(
                            corrThemeConfig.themeName,
                            style: TextStyle(
                                color: corrThemeConfig.checkmarkColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text("${corrThemeConfig.themeName}に変更しますか？"),
            ),
            // 操作ボタン
            OverflowBar(
              alignment: MainAxisAlignment.spaceEvenly,
              children: [
                // 戻るボタン
                TextButton(
                  style: alertButtonStyle(
                      accentColor: corrThemeConfig.accentColor),
                  onPressed: () => Navigator.pop(context),
                  // InkWell
                  child: const Text("戻る"),
                ),
                // 変更するボタン
                TextButton(
                    style: alertButtonStyle(
                        accentColor: corrThemeConfig.accentColor),
                    onPressed: () {
                      // このアラートを消す
                      Navigator.pop(context);
                      tlAppStateNotifier.dispatchThemeAction(
                          TLThemeAction.changeTheme(themeType: corrThemeType));
                      // 完了を知らせるアラートを表示
                      const TLSingleOptionDialog(title: "変更が完了しました")
                          .show(context: context);
                    },
                    // InkWell
                    child: const Text("変更")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
