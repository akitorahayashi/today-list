import 'package:flutter/material.dart';

/// このファイルには、アイコンに関連する列挙型やデータモデルを定義する。
/// アイコン情報のデータ構造を統一し、アプリ全体で再利用可能にすることを目的としている。

class TLIconData {
  final TLIconCategory category;
  final TLIconRarity rarity;
  final TLIconName name;

  TLIconData({
    required this.category,
    required this.rarity,
    required this.name,
  });

  Map<String, String> toJson() => {
        'category': category.name,
        'rarity': rarity.name,
        'name': name.name,
      };

  static TLIconData fromJson(Map<String, dynamic> json) => TLIconData(
        category: TLIconCategory.values.firstWhere(
            (e) => e.name == json['category'],
            orElse: () => TLIconCategory.defaultCategory),
        rarity: TLIconRarity.values.firstWhere((e) => e.name == json['rarity'],
            orElse: () => TLIconRarity.common),
        name: TLIconName.values.firstWhere((e) => e.name == json['name'],
            orElse: () => TLIconName.box),
      );
}

/// カテゴリー（大カテゴリー）
enum TLIconCategory { defaultCategory, unit1, unit2 }

/// レア度（小カテゴリー）
enum TLIconRarity { superRare, rare, common }

/// アイコン名（値）
enum TLIconName {
  box,
  circle,
  water,
  sun,
  star,
  fire,
  flower,
  tree,
  hill,
  moon,
  earth,
  bee,
  rocket,
  core,
  bell,
  ar,
  flare,
  code,
  limit,
  robot,
  game,
  music,
}

/// アイコンに関する具体的なデータのクラス
/// チェック状態に応じたアイコンの情報を格納する。
class TLIconForCheckBox {
  final IconData checkedIcon; // チェック状態のアイコン
  final IconData notCheckedIcon; // 非チェック状態のアイコン

  /// コンストラクタ
  /// チェック状態と非チェック状態のアイコンデータを初期化する。
  const TLIconForCheckBox({
    required this.checkedIcon,
    required this.notCheckedIcon,
  });
}
