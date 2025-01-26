import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../model/design/tl_icon/tl_icon_data.dart';

/// このファイルには、具体的なアイコンデータの定義が含まれている。
/// `TLIconModel` で使用されるデータとして、全てのアイコン情報を一元管理する役割を持つ。
const Map<TLIconCategory, Map<TLIconRarity, Map<TLIconName, TLIconForCheckBox>>>
    tlIconsForCheckBox = {
  TLIconCategory.defaultCategory: {
    TLIconRarity.common: {
      TLIconName.box: TLIconForCheckBox(
        checkedIcon: FontAwesomeIcons.solidSquareCheck,
        notCheckedIcon: FontAwesomeIcons.square,
      ),
      TLIconName.circle: TLIconForCheckBox(
        checkedIcon: FontAwesomeIcons.solidCircleCheck,
        notCheckedIcon: FontAwesomeIcons.circle,
      ),
    },
  },
  TLIconCategory.unit1: {
    TLIconRarity.superRare: {
      TLIconName.water: TLIconForCheckBox(
        checkedIcon: Icons.water_drop,
        notCheckedIcon: Icons.water_drop_outlined,
      ),
      TLIconName.sun: TLIconForCheckBox(
        checkedIcon: Icons.brightness_7,
        notCheckedIcon: Icons.brightness_5,
      ),
    },
    TLIconRarity.rare: {
      TLIconName.star: TLIconForCheckBox(
        checkedIcon: Icons.star,
        notCheckedIcon: Icons.star_border,
      ),
      TLIconName.fire: TLIconForCheckBox(
        checkedIcon: Icons.whatshot,
        notCheckedIcon: Icons.whatshot,
      ),
      TLIconName.flower: TLIconForCheckBox(
        checkedIcon: Icons.local_florist,
        notCheckedIcon: Icons.local_florist_outlined,
      ),
    },
    TLIconRarity.common: {
      TLIconName.tree: TLIconForCheckBox(
        checkedIcon: Icons.park,
        notCheckedIcon: Icons.park_outlined,
      ),
      TLIconName.hill: TLIconForCheckBox(
        checkedIcon: Icons.terrain,
        notCheckedIcon: Icons.terrain_outlined,
      ),
      TLIconName.moon: TLIconForCheckBox(
        checkedIcon: Icons.dark_mode,
        notCheckedIcon: Icons.dark_mode_outlined,
      ),
      TLIconName.earth: TLIconForCheckBox(
        checkedIcon: Icons.public,
        notCheckedIcon: Icons.public_outlined,
      ),
      TLIconName.bee: TLIconForCheckBox(
        checkedIcon: Icons.emoji_nature,
        notCheckedIcon: Icons.emoji_nature_outlined,
      ),
    },
  },
  TLIconCategory.unit2: {
    TLIconRarity.superRare: {
      TLIconName.rocket: TLIconForCheckBox(
        checkedIcon: Icons.rocket_launch,
        notCheckedIcon: Icons.rocket_outlined,
      ),
      TLIconName.core: TLIconForCheckBox(
        checkedIcon: Icons.token,
        notCheckedIcon: Icons.token_outlined,
      ),
    },
    TLIconRarity.rare: {
      TLIconName.bell: TLIconForCheckBox(
        checkedIcon: Icons.notifications_active,
        notCheckedIcon: Icons.notifications_outlined,
      ),
      TLIconName.ar: TLIconForCheckBox(
        checkedIcon: Icons.view_in_ar,
        notCheckedIcon: Icons.view_in_ar_outlined,
      ),
      TLIconName.flare: TLIconForCheckBox(
        checkedIcon: Icons.flare,
        notCheckedIcon: Icons.lens_blur_sharp,
      ),
    },
    TLIconRarity.common: {
      TLIconName.code: TLIconForCheckBox(
        checkedIcon: Icons.qr_code_scanner,
        notCheckedIcon: Icons.qr_code,
      ),
      TLIconName.limit: TLIconForCheckBox(
        checkedIcon: Icons.hourglass_full,
        notCheckedIcon: Icons.hourglass_empty,
      ),
      TLIconName.robot: TLIconForCheckBox(
        checkedIcon: Icons.smart_toy,
        notCheckedIcon: Icons.smart_toy_outlined,
      ),
      TLIconName.game: TLIconForCheckBox(
        checkedIcon: Icons.sports_esports,
        notCheckedIcon: Icons.sports_esports_outlined,
      ),
      TLIconName.music: TLIconForCheckBox(
        checkedIcon: Icons.music_note,
        notCheckedIcon: Icons.music_note_outlined,
      ),
    },
  },
};
