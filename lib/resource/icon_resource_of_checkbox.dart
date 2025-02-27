import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// カテゴリー（大カテゴリー）
enum TLIconCategory {
  defaultCategory('Default', [TLIconName.box, TLIconName.circle]),
  unit1('Unit 1', [
    TLIconName.water,
    TLIconName.sun,
    TLIconName.star,
    TLIconName.fire,
    TLIconName.flower,
    TLIconName.tree,
    TLIconName.hill,
    TLIconName.moon,
    TLIconName.earth,
    TLIconName.bee,
  ]),
  unit2('Unit 2', [
    TLIconName.rocket,
    TLIconName.core,
    TLIconName.bell,
    TLIconName.ar,
    TLIconName.flare,
    TLIconName.code,
    TLIconName.limit,
    TLIconName.robot,
    TLIconName.game,
    TLIconName.music,
  ]);

  final String name;
  final List<TLIconName> icons;
  const TLIconCategory(this.name, this.icons);
}

/// アイコン名（値）
enum TLIconName {
  box('Box'),
  circle('Circle'),
  // --
  water('Water'),
  sun('Sun'),
  star('Star'),
  fire('Fire'),
  flower('Flower'),
  tree('Tree'),
  hill('Hill'),
  moon('Moon'),
  earth('Earth'),
  bee('Bee'),
  // --
  rocket('Rocket'),
  core('Core'),
  bell('Bell'),
  ar('Ar'),
  flare('Flare'),
  code('Code'),
  limit('Limit'),
  robot('Robot'),
  game('Game'),
  music('Music');

  final String name;
  const TLIconName(this.name);
}

/// `TLIconModel` で使用されるデータとして、全てのアイコンの情報を管理する
Map<String, Map<String, TLIconDataSource>> iconResourceOfCheckBox = {
  TLIconCategory.defaultCategory.name: {
    TLIconName.box.name: const TLIconDataSource(
      checkedIcon: FontAwesomeIcons.solidSquareCheck,
      notCheckedIcon: FontAwesomeIcons.square,
    ),
    TLIconName.circle.name: const TLIconDataSource(
      checkedIcon: FontAwesomeIcons.solidCircleCheck,
      notCheckedIcon: FontAwesomeIcons.circle,
    ),
  },
  TLIconCategory.unit1.name: {
    TLIconName.water.name: const TLIconDataSource(
      checkedIcon: Icons.water_drop,
      notCheckedIcon: Icons.water_drop_outlined,
    ),
    TLIconName.sun.name: const TLIconDataSource(
      checkedIcon: Icons.brightness_7,
      notCheckedIcon: Icons.brightness_5,
    ),
    TLIconName.star.name: const TLIconDataSource(
      checkedIcon: Icons.star,
      notCheckedIcon: Icons.star_border,
    ),
    TLIconName.fire.name: const TLIconDataSource(
      checkedIcon: Icons.whatshot,
      notCheckedIcon: Icons.whatshot,
    ),
    TLIconName.flower.name: const TLIconDataSource(
      checkedIcon: Icons.local_florist,
      notCheckedIcon: Icons.local_florist_outlined,
    ),
    TLIconName.tree.name: const TLIconDataSource(
      checkedIcon: Icons.park,
      notCheckedIcon: Icons.park_outlined,
    ),
    TLIconName.hill.name: const TLIconDataSource(
      checkedIcon: Icons.terrain,
      notCheckedIcon: Icons.terrain_outlined,
    ),
    TLIconName.moon.name: const TLIconDataSource(
      checkedIcon: Icons.dark_mode,
      notCheckedIcon: Icons.dark_mode_outlined,
    ),
    TLIconName.earth.name: const TLIconDataSource(
      checkedIcon: Icons.public,
      notCheckedIcon: Icons.public_outlined,
    ),
    TLIconName.bee.name: const TLIconDataSource(
      checkedIcon: Icons.emoji_nature,
      notCheckedIcon: Icons.emoji_nature_outlined,
    ),
  },
  TLIconCategory.unit2.name: {
    TLIconName.rocket.name: const TLIconDataSource(
      checkedIcon: Icons.rocket_launch,
      notCheckedIcon: Icons.rocket_outlined,
    ),
    TLIconName.core.name: const TLIconDataSource(
      checkedIcon: Icons.token,
      notCheckedIcon: Icons.token_outlined,
    ),
    TLIconName.bell.name: const TLIconDataSource(
      checkedIcon: Icons.notifications_active,
      notCheckedIcon: Icons.notifications_outlined,
    ),
    TLIconName.ar.name: const TLIconDataSource(
      checkedIcon: Icons.view_in_ar,
      notCheckedIcon: Icons.view_in_ar_outlined,
    ),
    TLIconName.flare.name: const TLIconDataSource(
      checkedIcon: Icons.flare,
      notCheckedIcon: Icons.lens_blur_sharp,
    ),
    TLIconName.code.name: const TLIconDataSource(
      checkedIcon: Icons.qr_code_scanner,
      notCheckedIcon: Icons.qr_code,
    ),
    TLIconName.limit.name: const TLIconDataSource(
      checkedIcon: Icons.hourglass_full,
      notCheckedIcon: Icons.hourglass_empty,
    ),
    TLIconName.robot.name: const TLIconDataSource(
      checkedIcon: Icons.smart_toy,
      notCheckedIcon: Icons.smart_toy_outlined,
    ),
    TLIconName.game.name: const TLIconDataSource(
      checkedIcon: Icons.sports_esports,
      notCheckedIcon: Icons.sports_esports_outlined,
    ),
    TLIconName.music.name: const TLIconDataSource(
      checkedIcon: Icons.music_note,
      notCheckedIcon: Icons.music_note_outlined,
    ),
  },
};

/// アイコンに関する具体的なデータを提供するクラス
class TLIconDataSource {
  final IconData checkedIcon;
  final IconData notCheckedIcon;

  const TLIconDataSource({
    required this.checkedIcon,
    required this.notCheckedIcon,
  });
}
