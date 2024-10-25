import 'package:flutter/material.dart';
import '../../../../../constants/icon_for_checkbox.dart';
import '../../../../../model/tl_theme.dart';
import '../../../../../model/user/setting_data.dart';
import './icon_card.dart';

class IconCategoryBlock extends StatelessWidget {
  final String iconCategoryName;
  final String iconRarity;
  const IconCategoryBlock({
    super.key,
    required this.iconRarity,
    required this.iconCategoryName,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: tlThemeDataList[SettingData.shared.selectedThemeIndex]!
          .settingPanelColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(4.0),
            //   child: Text(
            //     iconRarity,
            //     style: const TextStyle(
            //         color: Colors.black45, fontWeight: FontWeight.bold),
            //   ),
            // ),
            Row(
              children: iconsForCheckBox[iconCategoryName]![iconRarity]!
                  .keys
                  .map((iconName) => IconCard(
                        isEarned: true,
                        // settingData.earnedIcons[iconCategoryName] != null &&
                        //     settingData.earnedIcons[iconCategoryName]!
                        //         .contains(iconName),
                        iconCategoryName: iconCategoryName,
                        selectedIconRarity: iconRarity,
                        iconName: iconName,
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
