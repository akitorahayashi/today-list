import 'package:flutter/material.dart';
import 'package:today_list/model/design/tl_theme_config.dart';

class TLDialog extends StatelessWidget {
  final TLThemeConfig corrThemeConfig;
  final Widget child;

  const TLDialog({
    super.key,
    required this.corrThemeConfig,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: corrThemeConfig.alertBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: corrThemeConfig.accentColor.withValues(alpha: 0.35),
              blurRadius: 5,
              spreadRadius: 3,
            ),
          ],
        ),
        child: Card(
          color: corrThemeConfig.whiteBasedColor.withValues(alpha: 0.95),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: child,
        ),
      ),
    );
  }
}
