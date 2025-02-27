import 'package:flutter/material.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:today_list/resource/tl_icon_resource.dart';
import 'icon_card.dart';

class TLIconBlock extends StatelessWidget {
  final TLIconCategory tlIconCategory;
  final List<TLIconName> icons;
  const TLIconBlock({
    super.key,
    required this.tlIconCategory,
    required this.icons,
  });

  @override
  Widget build(BuildContext context) {
    final TLThemeConfig tlThemeConfig = TLTheme.of(context);
    return Card(
      color: tlThemeConfig.settingPanelColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            Row(
              children: icons
                  .map((TLIconName iconName) => IconCard(
                        isEarned: true,
                        tlIconCategory: tlIconCategory,
                        tlIconName: iconName,
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
