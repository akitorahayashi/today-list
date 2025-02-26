import 'package:flutter/material.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/styles.dart';
import 'package:today_list/view/component/dialog/tl_base_dialog_mixin.dart';
import 'package:today_list/view/component/dialog/design/tl_dialog.dart';

class TLYesNoDialog extends ConsumerWidget with TLBaseDialogMixin {
  final String title;
  final String? message;
  final Function()? yesAction;

  const TLYesNoDialog({
    super.key,
    required this.title,
    this.message,
    required this.yesAction,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeConfig tlThemeConfig = TLTheme.of(context);
    return TLDialog(
      corrThemeConfig: tlThemeConfig,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 16),
              child: Text(
                title,
                style: TextStyle(
                    color: tlThemeConfig.accentColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            if (message != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  message!,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.6),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            if (message == null)
              const SizedBox(
                height: 30,
              ),
            OverflowBar(
              alignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: alertButtonStyle(
                        accentColor: tlThemeConfig.accentColor),
                    child: const Text("Close")),
                TextButton(
                  onPressed: yesAction,
                  style:
                      alertButtonStyle(accentColor: tlThemeConfig.accentColor),
                  child: const Text("Yes"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
