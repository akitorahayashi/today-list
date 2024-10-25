import '../../../../constants/icon_for_checkbox.dart';
import '../../../../constants/theme.dart';
import '../../../../model/user/setting_data.dart';
import 'icon_rarity_block/icon_rarity_block.dart';
import 'package:flutter/material.dart';

class IconCategoryPanel extends StatelessWidget {
  final String iconCategoryName;
  const IconCategoryPanel({super.key, required this.iconCategoryName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          // カテゴリー名
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 3.0),
            child: Text(
              iconCategoryName,
              style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                  color: tlThemeDataList[SettingData.shared.selectedThemeIndex]!
                      .checkmarkColor),
            ),
          ),
          // Super Rare, Rare
          Row(
            children: [
              if (iconsForCheckBox[iconCategoryName]!["Super Rare"]!.isNotEmpty)
                Expanded(
                    flex: 2,
                    child: IconCategoryBlock(
                      iconCategoryName: iconCategoryName,
                      iconRarity: "Super Rare",
                    )),
              if (iconsForCheckBox[iconCategoryName]!["Rare"]!.isNotEmpty)
                Expanded(
                    flex: 3,
                    child: IconCategoryBlock(
                      iconCategoryName: iconCategoryName,
                      iconRarity: "Rare",
                    )),
            ],
          ),
          // Common
          IconCategoryBlock(
            iconCategoryName: iconCategoryName,
            iconRarity: "Common",
          ),
        ],
      ),
    );
  }
}
