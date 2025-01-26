import 'package:flutter/material.dart';
import 'package:today_list/model/design/tl_icon_data.dart';
import 'package:today_list/resource/tl_icon_resource.dart';
import '../../../../../../model/design/tl_theme.dart';
import 'icon_card.dart';

class IconCategoryBlock extends StatelessWidget {
  final TLIconCategory tlIconCategory;
  final TLIconRarity tlIconRarity;
  const IconCategoryBlock({
    super.key,
    required this.tlIconCategory,
    required this.tlIconRarity,
  });

  @override
  Widget build(BuildContext context) {
    final TLThemeData tlThemeData = TLTheme.of(context);
    return Card(
      color: tlThemeData.settingPanelColor,
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
              children: tlIconResource[tlIconCategory]![tlIconRarity]
                      ?.keys
                      .map((iconName) => IconCard(
                            isEarned: true,
                            // settingData.earnedIcons[iconCategoryName] != null &&
                            //     settingData.earnedIcons[iconCategoryName]!
                            //         .contains(iconName),
                            tlIconCategory: tlIconCategory,
                            tlIconRarity: tlIconRarity,
                            tlIconName: iconName,
                          ))
                      .toList() ??
                  [],
            ),
          ],
        ),
      ),
    );
  }
}
