# Widget Test Directory

このディレクトリには、Today Listアプリケーションの各UIコンポーネントに対するウィジェットテストが含まれています。テストは、アプリケーションの構造に合わせて整理されています。

## ディレクトリ構造

```
widget_test/
├── component/                  # 共通コンポーネントのテスト
│   ├── common_ui_part/         # 基本的なUI部品のテスト
│   │   └── tl_double_card_test.dart
│   └── todo_card/              # ToDoカード関連コンポーネントのテスト
│       ├── tl_checkbox_test.dart
│       ├── tl_todo_card_test.dart
│       ├── tl_step_card_test.dart
│       └── slidable_for_todo_card_test.dart
├── home_page/                  # ホームページのテスト
│   └── home_page_test.dart
├── page/                       # 各ページコンポーネントのテスト
│   ├── add_todo_page/          # ToDo追加ページのテスト
│   │   ├── already_exist_test.dart
│   │   └── model_of_todo_card_test.dart
│   └── home_page/              # ホームページの部品テスト
│       └── num_todos_card_test.dart
└── settings_page/              # 設定ページのテスト
    └── set_features_page_test.dart
```

## テスト概要

### コンポーネントテスト

#### 共通UI部品
- **TLDoubleCard**: 二重カードコンポーネントの表示テスト

#### ToDoカード関連
- **TLCheckbox**: チェックボックスの表示と状態変化のテスト
- **TLToDoCard**: ToDoカードの表示（ステップあり/なし）と状態変化のテスト
- **TLStepCard**: ステップカードの表示と状態変化のテスト
- **SlidableForToDoCard**: スライド可能なToDoカードの表示と機能テスト

### ページテスト

#### ホームページ
- **HomePage**: ホームページの基本構造と各コンポーネントの表示テスト
- **NumToDosCard**: ToDo数表示カードのテスト

#### ToDo追加ページ
- **AlreadyExist**: 既存のToDoリスト表示コンポーネントのテスト
- **ModelOfToDoCard**: ToDo追加ページでのToDoカードモデルのテスト

#### 設定ページ
- **SetFeaturesPage**: 機能設定ページの表示と各パネルのテスト

## テスト実行方法

特定のテストファイルを実行するには：

```bash
flutter test test/widget_test/[ディレクトリ]/[テストファイル]
```

例：
```bash
flutter test test/widget_test/component/todo_card/tl_todo_card_test.dart
```

すべてのウィジェットテストを実行するには：

```bash
flutter test test/widget_test/
```

## テスト作成のガイドライン

1. **テスト構造**: 各テストファイルは、テスト対象のウィジェットに対応する名前を持ち、`_test.dart`で終わります。
2. **モックデータ**: テストに必要なモックデータは各テストファイル内で定義します。
3. **ProviderScope**: Riverpodを使用するコンポーネントのテストでは、`ProviderScope`と`UncontrolledProviderScope`を使用してプロバイダーをモック化します。
4. **TLTheme**: テーマに依存するコンポーネントのテストでは、`TLTheme`ウィジェットでラップします。
5. **constの使用**: 可能な限り`const`キーワードを使用して、パフォーマンスとコード品質を向上させます。

## 注意事項

- テストは、コンポーネントの視覚的な表示だけでなく、機能的な振る舞いも検証します。
- 複雑なアニメーションや非同期処理を含むテストでは、`tester.pumpAndSettle()`を使用して、すべてのアニメーションが完了するのを待ちます。
- テスト環境では、実際のデータベースやネットワーク接続は使用せず、すべてモック化します。 