import 'package:flutter/material.dart';
import 'package:today_list/model/design/tl_theme_config.dart';
import 'package:today_list/styles.dart';
import 'package:today_list/view/component/dialog/design/tl_dialog.dart';
import 'package:today_list/view/component/dialog/tl_base_dialog_mixin.dart';

class TLThemeChangedDialog extends StatelessWidget with TLBaseDialogMixin {
  final TLThemeConfig themeConfig;
  final String? iconName;

  const TLThemeChangedDialog({
    super.key,
    required this.themeConfig,
    required this.iconName,
  });

  // アイコン名からアセットパスを取得
  String _getIconAssetPath(String? name) {
    if (name == null) {
      return 'assets/tl_sun.png'; // デフォルトアイコン
    }

    // テーマ名に基づいてアイコンを選択
    switch (name) {
      case 'Sun Orange':
        return 'assets/tl_sun.png';
      case 'Marine Blue':
        return 'assets/tl_marine.png';
      case 'Lime Green':
        return 'assets/tl_lime.png';
      default:
        return 'assets/tl_sun.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return TLDialog(
      corrThemeConfig: themeConfig,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // タイトル
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: const TextStyle(
                      color: Colors.black45,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    children: [
                      const TextSpan(text: 'Theme changed to \n'),
                      TextSpan(
                        text: iconName == null ? 'Default' : '"$iconName"',
                        style: TextStyle(
                          color: themeConfig.accentColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // アイコン表示部分
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 12),
                child: Container(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                    color: themeConfig.accentColor.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: themeConfig.accentColor.withValues(alpha: 0.1),
                        blurRadius: 3,
                        spreadRadius: 3,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      _getIconAssetPath(iconName),
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              // OKボタン
              TextButton(
                onPressed: () => Navigator.pop(context),
                style: alertButtonStyle(accentColor: themeConfig.accentColor),
                child: const Text("OK"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
