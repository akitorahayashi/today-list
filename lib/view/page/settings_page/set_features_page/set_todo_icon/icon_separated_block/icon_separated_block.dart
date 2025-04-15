import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/model/design/tl_theme_config.dart';
import 'package:today_list/resource/icon_resource_of_checkbox.dart';
import 'icon_card.dart';

class IconSeparatedBlock extends ConsumerWidget {
  final bool showIfNotEarned;
  final TLIconCategory tlIconCategory;
  final List<TLIconName> icons;
  const IconSeparatedBlock({
    super.key,
    required this.showIfNotEarned,
    required this.tlIconCategory,
    required this.icons,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeConfig tlThemeConfig = TLTheme.of(context);
    return Card(
      color: tlThemeConfig.settingPanelColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            Row(
              children:
                  icons
                      .map(
                        (TLIconName iconName) => IconCard(
                          showIfNotEarned: showIfNotEarned,
                          tlIconCategory: tlIconCategory,
                          tlIconName: iconName,
                        ),
                      )
                      .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
