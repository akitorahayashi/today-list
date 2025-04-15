import 'package:flutter/material.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/model/design/tl_theme_config.dart';
import 'package:today_list/resource/icon_resource_of_checkbox.dart';
import 'icon_separated_block/icon_separated_block.dart';

class IconCategoryPanel extends StatelessWidget {
  final TLIconCategory corrIconCategory;
  const IconCategoryPanel({super.key, required this.corrIconCategory});

  @override
  Widget build(BuildContext context) {
    final TLThemeConfig tlThemeConfig = TLTheme.of(context);
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          // カテゴリー名
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 3.0),
            child: Text(
              corrIconCategory.name,
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w800,
                color: tlThemeConfig.accentColor,
              ),
            ),
          ),
          // Default
          if (corrIconCategory.name == TLIconCategory.defaultCategory.name)
            IconSeparatedBlock(
              showIfNotEarned: true,
              tlIconCategory: corrIconCategory,
              icons: corrIconCategory.icons,
            ),
          // Others
          if (corrIconCategory.name != TLIconCategory.defaultCategory.name)
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: IconSeparatedBlock(
                        showIfNotEarned: true,
                        tlIconCategory: corrIconCategory,
                        icons: corrIconCategory.icons.sublist(0, 2),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: IconSeparatedBlock(
                        showIfNotEarned: false,
                        tlIconCategory: corrIconCategory,
                        icons: corrIconCategory.icons.sublist(2, 5),
                      ),
                    ),
                  ],
                ),
                // Common
                IconSeparatedBlock(
                  showIfNotEarned: false,
                  tlIconCategory: corrIconCategory,
                  icons: corrIconCategory.icons.sublist(5, 10),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
