import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/design/tl_theme_config.dart';
import 'package:today_list/model/settings_data/selected_check_box_icon_data.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/flux/store/user_data_store.dart';
import 'package:today_list/resource/icon_resource_of_checkbox.dart';

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
    final TLThemeConfig tlThemeConfig = TLTheme.of(context);
    final userDataAsync = ref.watch(userDataProvider);

    return userDataAsync.when(
      data: (userData) {
        final selectedCheckBoxIconData = userData.selectedCheckBoxIconData;

        // このカテゴリーで指定されたアイコンがない場合、デフォルトのものを使う
        final thisIconData = (() {
          if (iconResourceOfCheckBox[selectedCheckBoxIconData.iconCategory] !=
                  null &&
              iconResourceOfCheckBox[selectedCheckBoxIconData.iconCategory]![
                      selectedCheckBoxIconData.iconName] !=
                  null) {
            return iconResourceOfCheckBox[selectedCheckBoxIconData
                .iconCategory]![selectedCheckBoxIconData.iconName]!;
          } else {
            return iconResourceOfCheckBox[TLIconCategory.defaultCategory.name]![
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
                  ? tlThemeConfig.accentColor
                  : Colors.black.withOpacity(0.56)),
          size: effectiveIconSize,
        );
      },
      loading: () => SizedBox(
        width: iconSize ?? 19,
        height: iconSize ?? 19,
        child: const CircularProgressIndicator(strokeWidth: 2),
      ),
      error: (_, __) => Icon(
        Icons.check_box_outline_blank,
        color: iconColor ??
            (isChecked
                ? tlThemeConfig.accentColor
                : Colors.black.withOpacity(0.56)),
        size: iconSize ?? 17,
      ),
    );
  }
}
