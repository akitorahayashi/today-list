import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/view/component/dialog/tl_base_dialog_mixin.dart';
import 'package:today_list/styles.dart';
import 'package:today_list/view/component/dialog/common/tl_single_option_dialog.dart';
import 'package:today_list/view_model/design/theme_idx_provider.dart';
import '../../../model/design/tl_theme/tl_theme.dart';
import '../../../service/tl_connectivity.dart';
import '../../../service/tl_method_channel.dart';
import '../../../service/tl_vibration.dart';

import 'package:glassmorphism_ui/glassmorphism_ui.dart';

class ChangeThemeDialog extends ConsumerWidget with TLBaseDialogMixin {
  final int corrIndex;
  final TLThemeConfig corrThemeData;
  const ChangeThemeDialog({
    super.key,
    required this.corrIndex,
    required this.corrThemeData,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SelectedThemeIndexNotifier selectedThemeIndexNotifier =
        ref.read(selectedThemeIndexProvider.notifier);
    return Dialog(
      backgroundColor: corrThemeData.alertColor,
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
                    gradient: corrThemeData.gradientOfNavBar,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: GlassContainer(
                    child: Align(
                      alignment: Alignment.center,
                      child: Card(
                        elevation: 5,
                        color: corrThemeData.panelColor,
                        child: Container(
                          width: 150,
                          height: 50,
                          alignment: Alignment.center,
                          child: Text(
                            corrThemeData.themeName,
                            style: TextStyle(
                                color: corrThemeData.checkmarkColor,
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
              child: Text("${corrThemeData.themeName}に変更しますか？"),
            ),
            // 操作ボタン
            OverflowBar(
              alignment: MainAxisAlignment.spaceEvenly,
              children: [
                // 戻るボタン
                TextButton(
                  style:
                      alertButtonStyle(accentColor: corrThemeData.accentColor),
                  onPressed: () => Navigator.pop(context),
                  // InkWell
                  child: const Text("戻る"),
                ),
                // 変更するボタン
                TextButton(
                    style: alertButtonStyle(
                        accentColor: corrThemeData.accentColor),
                    onPressed: () {
                      // このアラートを消す
                      Navigator.pop(context);
                      selectedThemeIndexNotifier.changeThemeIndex(corrIndex);
                      TLConnectivityService.sendSelectedThemeToAppleWatch(
                          selectedThemeIndex: corrIndex);
                      TLMethodChannelService.updateSelectedTheme(
                          selectedThemeIndex: corrIndex);
                      TLVibrationService.vibrate();
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
