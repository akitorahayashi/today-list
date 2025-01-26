# TLIcon モジュール

このモジュールはアプリケーション内のアイコンデータを管理する。新しいアイコンを追加する場合は、以下の手順に従う。

## 新しいアイコンを追加する手順

1. **アイコン名の追加**
   - `model/tl_icon_model.dart` 内の列挙型 `TLIconName` に新しいアイコン名を追加する。
   - 例: 
     ```dart
     enum TLIconName {
       ...,
       newIcon, // 新しいアイコン名
     }
     ```

2. **アイコンデータの追加**
   - `resource/tl_icon_resource.dart` の適切なカテゴリー (`TLIconCategory`) とレア度 (`TLIconRarity`) にアイコンデータを追加する。
   - 例: 
    ```dart
    TLIconName.newIcon: TLIconForCheckBox(
    checkedIcon: Icons.new_label,
    notCheckedIcon: Icons.label_outline,
    ),
    ```
