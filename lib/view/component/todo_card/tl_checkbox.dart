import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/design/tl_theme_config.dart';
import 'package:today_list/model/settings_data/selected_check_box_icon_data.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/resource/tl_icon_resource.dart';

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
    final SelectedCheckBoxIconData selectedCheckBoxIconData = ref.watch(
        tlAppStateProvider
            .select((state) => state.tlUserData.selectedCheckBoxIconData));

    // このカテゴリーで指定されたアイコンがない場合、デフォルトのものを使う
    final thisIconData = (() {
      if (tlIconResource[selectedCheckBoxIconData.iconCategory] != null &&
          tlIconResource[selectedCheckBoxIconData.iconCategory]![
                  selectedCheckBoxIconData.iconName] !=
              null) {
        return tlIconResource[selectedCheckBoxIconData.iconCategory]![
            selectedCheckBoxIconData.iconName]!;
      } else {
        return tlIconResource[TLIconCategory.defaultCategory.name]![
            TLIconName.box.name]!;
      }
    }());

    // TLIconCategory.defaultCategoryかどうかでサイズを調整
    final double effectiveIconSize = iconSize ??
        (selectedCheckBoxIconData.iconCategory ==
                TLIconCategory.defaultCategory.name
            ? 17
            : 19);

    return Icon(
      isChecked ? thisIconData.checkedIcon : thisIconData.notCheckedIcon,
      color: iconColor ??
          (isChecked
              ? tlThemeData.checkmarkColor
              : Colors.black.withValues(alpha: 0.56)),
      size: effectiveIconSize,
    );
  }
}
