import 'package:flutter/material.dart';
import 'package:today_list/model/design/icon_for_checkbox.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/model/user/setting_data.dart';
import 'package:today_list/model/external/tl_ads.dart';

class TLCheckBox extends StatelessWidget {
  final bool isChecked;
  final Color? iconColor;
  final double? iconSize;

  TLCheckBox({
    required this.isChecked,
    this.iconColor,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    final TLThemeData _tlThemeData = TLTheme.of(context);
    // このカテゴリーで指定されたアイコンがない場合、デフォルトのものを使う
    IconForCheckBox thisIconData = (() {
      // 指定したアイコンがなければ、チェックボックスを使う
      if (iconsForCheckBox[SettingData.shared.defaultIconCategory] != null &&
          iconsForCheckBox[SettingData.shared.defaultIconCategory]![
                  SettingData.shared.defaultIconRarity] !=
              null &&
          iconsForCheckBox[SettingData.shared.defaultIconCategory]![SettingData
                  .shared
                  .defaultIconRarity]![SettingData.shared.defaultIconName] !=
              null &&
          TLAds.isPassActive) {
        return iconsForCheckBox[SettingData.shared.defaultIconCategory]![
            SettingData.shared
                .defaultIconRarity]![SettingData.shared.defaultIconName]!;
      } else {
        return iconsForCheckBox["Default"]!["Common"]!["box"]!;
      }
    }());

    return Icon(
      isChecked ? thisIconData.checkedIcon : thisIconData.notCheckedIcon,
      color: iconColor ??
          (isChecked
              ? _tlThemeData.checkmarkColor
              : Colors.black.withOpacity(0.56)),
      size: iconSize ??
          (fontawesomeCategories
                  .contains(SettingData.shared.defaultIconCategory)
              ? 17
              : 19),
    );
  }
}
