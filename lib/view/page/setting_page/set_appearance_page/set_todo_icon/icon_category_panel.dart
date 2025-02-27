import 'package:flutter/material.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:today_list/resource/tl_icon_resource.dart';
import 'icon_rarity_block/icon_rarity_block.dart';

class IconCategoryPanel extends StatelessWidget {
  final TLIconCategory tlIconCategory;
  const IconCategoryPanel({super.key, required this.tlIconCategory});

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
              tlIconCategory.name,
              style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                  color: tlThemeConfig.checkmarkColor),
            ),
          ),
          // Super Rare, Rare
          Row(
            children: [
              Expanded(
                flex: 2,
                child: TLIconBlock(
                  tlIconCategory: tlIconCategory,
                  icons: tlIconCategory.icons.sublist(0, 1),
                ),
              ),
              Expanded(
                flex: 3,
                child: TLIconBlock(
                  tlIconCategory: tlIconCategory,
                  icons: tlIconCategory.icons.sublist(2, 4),
                ),
              ),
            ],
          ),
          // Common
          TLIconBlock(
            tlIconCategory: tlIconCategory,
            icons: tlIconCategory.icons.sublist(5, 9),
          ),
        ],
      ),
    );
  }
}
