import 'package:flutter/material.dart';
import '../../resource/tl_icon_resource.dart';

/// このファイルには、アイコンに関連する列挙型やデータモデルを定義する。
/// アイコン情報のデータ構造を統一し、アプリ全体で再利用可能にすることを目的としている。

/// TLIconModelはアイコンのデータを管理するクラス
/// リソースファイルからデータを取得し、ヘルパー関数を提供する。
class TLIconModel {
  /// アイコンを取得する関数
  /// カテゴリー、レア度、名前に対応するアイコンデータを返す。
  /// リソースに定義された `tlIconsForCheckBox` を使用する。
  static TLIconForCheckBox? getIcon({
    required TLIconCategory category,
    required TLIconRarity rarity,
    required TLIconName name,
  }) {
    return tlIconsForCheckBox[category]?[rarity]?[name];
  }
}

/// カテゴリーの列挙型
/// アイコンの大カテゴリを定義する。
enum TLIconCategory { defaultCategory, unit1, unit2 }

/// レア度の列挙型
/// アイコンのレアリティ（希少性）を定義する。
enum TLIconRarity { superRare, rare, common }

/// アイコン名の列挙型
/// アイコンの具体的な名前を定義する。
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
