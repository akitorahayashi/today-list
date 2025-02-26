import 'package:flutter/material.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:today_list/view/component/dialog/design/tl_dialog.dart';
import '../../../../model/design/tl_theme/tl_theme.dart';
import '../tl_base_dialog_mixin.dart';
import '../../../../styles.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class TLSingleOptionDialog extends ConsumerWidget with TLBaseDialogMixin {
  final String title;
  final String? message;

  const TLSingleOptionDialog({
    super.key,
    required this.title,
    this.message,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeConfig corrThemeConfig = TLTheme.of(context);
    return TLDialog(
      corrThemeConfig: corrThemeConfig,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 16),
                child: Text(
                  title,
                  style: TextStyle(
                      color: corrThemeConfig.accentColor,
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
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: alertButtonStyle(
                      accentColor: corrThemeConfig.accentColor),
                  child: const Text("OK"))
            ],
          ),
        ),
      ),
    );
  }
}
