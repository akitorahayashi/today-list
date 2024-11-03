import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final List<String> fontawesomeCategories = ["Default"];

class IconForCheckBoxData {
  final IconData checkedIcon;
  final IconData notCheckedIcon;

  // コンストラクタ
  IconForCheckBoxData({
    required this.checkedIcon,
    required this.notCheckedIcon,
  });
}

// カテゴリー, レア度, 名前
Map<String, Map<String, Map<String, IconForCheckBoxData>>> iconsForCheckBox = {
  "Default": {
    "Super Rare": {},
    "Rare": {},
    "Common": {
      "box": IconForCheckBoxData(
          checkedIcon: FontAwesomeIcons.solidSquareCheck,
          notCheckedIcon: FontAwesomeIcons.square),
      "circle": IconForCheckBoxData(
          checkedIcon: FontAwesomeIcons.solidCircleCheck,
          notCheckedIcon: FontAwesomeIcons.circle)
    }
  },
  "Unit 1": {
    "Super Rare": {
      "water": IconForCheckBoxData(
          checkedIcon: Icons.water_drop,
          notCheckedIcon: Icons.water_drop_outlined),
      "sun": IconForCheckBoxData(
          checkedIcon: Icons.brightness_7, notCheckedIcon: Icons.brightness_5),
    },
    "Rare": {
      "star": IconForCheckBoxData(
          checkedIcon: Icons.star, notCheckedIcon: Icons.star_border),
      "fire": IconForCheckBoxData(
          checkedIcon: Icons.whatshot, notCheckedIcon: Icons.whatshot),
      "flower": IconForCheckBoxData(
          checkedIcon: Icons.local_florist,
          notCheckedIcon: Icons.local_florist_outlined),
    },
    "Common": {
      "tree": IconForCheckBoxData(
          checkedIcon: Icons.park, notCheckedIcon: Icons.park_outlined),
      "hill": IconForCheckBoxData(
          checkedIcon: Icons.terrain, notCheckedIcon: Icons.terrain_outlined),
      "moon": IconForCheckBoxData(
          checkedIcon: Icons.dark_mode,
          notCheckedIcon: Icons.dark_mode_outlined),
      "earth": IconForCheckBoxData(
          checkedIcon: Icons.public, notCheckedIcon: Icons.public_outlined),
      "bee": IconForCheckBoxData(
          checkedIcon: Icons.emoji_nature,
          notCheckedIcon: Icons.emoji_nature_outlined),
    }
  },
  "Unit 2": {
    "Super Rare": {
      "rocket": IconForCheckBoxData(
          checkedIcon: Icons.rocket_launch,
          notCheckedIcon: Icons.rocket_outlined),
      "core": IconForCheckBoxData(
          checkedIcon: Icons.token, notCheckedIcon: Icons.token_outlined),
    },
    "Rare": {
      "bell": IconForCheckBoxData(
          checkedIcon: Icons.notifications_active,
          notCheckedIcon: Icons.notifications_outlined),
      "ar": IconForCheckBoxData(
          checkedIcon: Icons.view_in_ar,
          notCheckedIcon: Icons.view_in_ar_outlined),
      "flare": IconForCheckBoxData(
          checkedIcon: Icons.flare, notCheckedIcon: Icons.lens_blur_sharp),
    },
    "Common": {
      "code": IconForCheckBoxData(
          checkedIcon: Icons.qr_code_scanner, notCheckedIcon: Icons.qr_code),
      "limit": IconForCheckBoxData(
          checkedIcon: Icons.hourglass_full,
          notCheckedIcon: Icons.hourglass_empty),
      "robot": IconForCheckBoxData(
          checkedIcon: Icons.smart_toy,
          notCheckedIcon: Icons.smart_toy_outlined),
      "game": IconForCheckBoxData(
          checkedIcon: Icons.sports_esports,
          notCheckedIcon: Icons.sports_esports_outlined),
      "music": IconForCheckBoxData(
          checkedIcon: Icons.music_note,
          notCheckedIcon: Icons.music_note_outlined),
    }
  },
  // "Unit 3": {
  //   "Super Rare": {
  //     "mosque": IconForCheckBox(
  //         checkedIcon: Icons.mosque, notCheckedIcon: Icons.handyman),
  //     "city": IconForCheckBox(
  //         checkedIcon: Icons.location_city, notCheckedIcon: Icons.handyman),
  //   },
  //   "Rare": {
  //     "temple": IconForCheckBox(
  //         checkedIcon: Icons.temple_buddhist, notCheckedIcon: Icons.handyman),
  //     "tower": IconForCheckBox(
  //         checkedIcon: Icons.temple_hindu, notCheckedIcon: Icons.handyman),
  //     "church": IconForCheckBox(
  //         checkedIcon: Icons.synagogue, notCheckedIcon: Icons.handyman),
  //   },
  //   "Common": {
  //     "castle": IconForCheckBox(
  //         checkedIcon: Icons.castle, notCheckedIcon: Icons.handyman),
  //     "fort": IconForCheckBox(
  //         checkedIcon: Icons.fort, notCheckedIcon: Icons.handyman),
  //     "festival": IconForCheckBox(
  //         checkedIcon: Icons.festival, notCheckedIcon: Icons.handyman),
  //     "factory": IconForCheckBox(
  //         checkedIcon: Icons.factory, notCheckedIcon: Icons.handyman),
  //     "store": IconForCheckBox(
  //         checkedIcon: Icons.apartment, notCheckedIcon: Icons.handyman),
  //   }
  // },
};
