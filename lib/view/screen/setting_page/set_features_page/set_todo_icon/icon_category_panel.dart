import 'package:today_list/model/design/tl_icon_data.dart';
import 'package:today_list/resource/tl_icon_resource.dart';
import '../../../../../model/design/tl_theme.dart';
import 'icon_rarity_block/icon_rarity_block.dart';
import 'package:flutter/material.dart';

class IconCategoryPanel extends StatelessWidget {
  final TLIconCategory tlIconCategory;
  const IconCategoryPanel({super.key, required this.tlIconCategory});

  @override
  Widget build(BuildContext context) {
    final TLThemeData tlThemeData = TLTheme.of(context);
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          // カテゴリー名
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 3.0),
            child: Text(
              tlIconCategory.rawValue,
              style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                  color: tlThemeData.checkmarkColor),
            ),
          ),
          // Super Rare, Rare
          if (tlIconResource[tlIconCategory]!
              .keys
              .toSet()
              .containsAll([TLIconRarity.superRare, TLIconRarity.rare]))
            Row(
              children: [
                if (tlIconResource[tlIconCategory]![TLIconRarity.superRare]
                        ?.isNotEmpty ??
                    true)
                  Expanded(
                      flex: 2,
                      child: IconCategoryBlock(
                        tlIconCategory: tlIconCategory,
                        tlIconRarity: TLIconRarity.superRare,
                      )),
                if (tlIconResource[tlIconCategory]![TLIconRarity.rare]
                        ?.isNotEmpty ??
                    true)
                  Expanded(
                      flex: 3,
                      child: IconCategoryBlock(
                        tlIconCategory: tlIconCategory,
                        tlIconRarity: TLIconRarity.rare,
                      )),
              ],
            ),
          // Common
          IconCategoryBlock(
            tlIconCategory: tlIconCategory,
            tlIconRarity: TLIconRarity.common,
          ),
        ],
      ),
    );
  }
}
