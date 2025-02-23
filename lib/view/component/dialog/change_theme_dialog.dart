import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:today_list/redux/action/tl_theme_action.dart';
import 'package:today_list/redux/reducer/tl_app_state_reducer.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/resource/tl_theme_type.dart';
import 'package:today_list/view/component/dialog/tl_base_dialog_mixin.dart';
import 'package:today_list/styles.dart';
import 'package:today_list/view/component/dialog/common/tl_single_option_dialog.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';

class ChangeThemeDialog extends ConsumerWidget with TLBaseDialogMixin {
  final TLThemeType corrThemeType;

  const ChangeThemeDialog({super.key, required this.corrThemeType});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeConfig corrThemeConfig = corrThemeType.config;
    final tlAppStateNotifier = ref.read(tlAppStateProvider.notifier);

    return Dialog(
      backgroundColor: corrThemeConfig.alertBackgroundColor,
      child: DefaultTextStyle(
        style: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black45),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildThemePreview(corrThemeConfig),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text("${corrThemeConfig.themeName}に変更しますか？"),
            ),
            _buildActionButtons(context, tlAppStateNotifier, corrThemeConfig),
          ],
        ),
      ),
    );
  }

  // MARK - Build Theme Preview
  Widget _buildThemePreview(themeConfig) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: SizedBox(
        width: 250,
        height: 80,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: themeConfig.gradientOfNavBar,
            borderRadius: BorderRadius.circular(10),
          ),
          child: GlassContainer(
            child: Align(
              alignment: Alignment.center,
              child: Card(
                elevation: 5,
                color: themeConfig.canTapCardColor,
                child: Container(
                  width: 150,
                  height: 50,
                  alignment: Alignment.center,
                  child: Text(
                    themeConfig.themeName,
                    style: TextStyle(
                        color: themeConfig.checkmarkColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // MARK - Build Action Buttons
  Widget _buildActionButtons(
      BuildContext context, TLAppStateReducer tlAppStateNotifier, themeConfig) {
    return OverflowBar(
      alignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Cancel Button
        TextButton(
          style: alertButtonStyle(accentColor: themeConfig.accentColor),
          onPressed: () => Navigator.pop(context),
          child: const Text("戻る"),
        ),
        // Confirm Button
        TextButton(
          style: alertButtonStyle(accentColor: themeConfig.accentColor),
          onPressed: () {
            Navigator.pop(context); // Close current dialog
            tlAppStateNotifier.dispatchThemeAction(
                TLThemeAction.changeTheme(newThemeType: corrThemeType));

            // Show completion alert
            const TLSingleOptionDialog(title: "変更が完了しました")
                .show(context: context);
          },
          child: const Text("変更"),
        ),
      ],
    );
  }
}
