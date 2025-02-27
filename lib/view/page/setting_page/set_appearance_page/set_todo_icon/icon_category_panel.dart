import 'package:flutter/material.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/model/design/tl_theme_config.dart';
import 'package:today_list/resource/tl_icon_resource.dart';
import 'icon_rarity_block/icon_rarity_block.dart';

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
                  color: tlThemeConfig.checkmarkColor),
            ),
          ),
          // Default
          if (corrIconCategory.name == TLIconCategory.defaultCategory.name)
            TLIconBlock(
                tlIconCategory: corrIconCategory,
                icons: corrIconCategory.icons),
          // Others
          if (corrIconCategory.name != TLIconCategory.defaultCategory.name)
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TLIconBlock(
                        tlIconCategory: corrIconCategory,
                        icons: corrIconCategory.icons.sublist(0, 2),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: TLIconBlock(
                        tlIconCategory: corrIconCategory,
                        icons: corrIconCategory.icons.sublist(2, 5),
                      ),
                    ),
                  ],
                ),
                // Common
                TLIconBlock(
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
