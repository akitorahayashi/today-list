import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/design/tl_icon_data.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:today_list/resource/tl_icon_resource.dart';
import 'package:today_list/view_model/design/tl_icon_data_provider.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';

class TLCheckBox extends ConsumerWidget {
  final bool isChecked;
  final Color? iconColor;
  final double? iconSize;

  const TLCheckBox({
    super.key,
    required this.isChecked,
    this.iconColor,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeConfig tlThemeData = TLTheme.of(context);
    final TLIconData tlIconData = ref.watch(tlIconDataProvider);

    // このカテゴリーで指定されたアイコンがない場合、デフォルトのものを使う
    final thisIconData = (() {
      if (tlIconResource[tlIconData.category] != null &&
          tlIconResource[tlIconData.category]![tlIconData.rarity] != null &&
          tlIconResource[tlIconData.category]![tlIconData.rarity]![
                  tlIconData.name] !=
              null) {
        return tlIconResource[tlIconData.category]![tlIconData.rarity]![
            tlIconData.name]!;
      } else {
        return tlIconResource[TLIconCategory.defaultCategory]![
            TLIconRarity.common]![TLIconName.box]!;
      }
    }());

    // TLIconCategory.defaultCategoryかどうかでサイズを調整
    final double effectiveIconSize = iconSize ??
        (tlIconData.category == TLIconCategory.defaultCategory ? 17 : 19);

    return Icon(
      isChecked ? thisIconData.checkedIcon : thisIconData.notCheckedIcon,
      color: iconColor ??
          (isChecked
              ? tlThemeData.checkmarkColor
              : Colors.black.withOpacity(0.56)),
      size: effectiveIconSize,
    );
  }
}
