# Flutter Golden Test ガイド

このドキュメントでは、Today Listプロジェクトにおけるgolden testの設定方法と使用方法について詳しく説明します。

## Golden Testとは

Golden Test（ゴールデンテスト）は、Flutterアプリケーションのユーザーインターフェイスを視覚的にテストする手法です。ウィジェットのスクリーンショットを撮影し、それを「ゴールデンファイル」と呼ばれる承認済みの参照画像と比較することで、意図しないUI変更を検出します。

Golden Testの主な利点：
- UIの視覚的な変更を自動的に検出できる
- デザインの一貫性を保つことができる
- 複数のデバイスサイズやテーマでUIをテストできる
- PRレビュー時に視覚的な変更を明確に確認できる

## セットアップ手順

### 1. 必要なパッケージの追加

`pubspec.yaml`ファイルに`alchemist`パッケージを追加します：

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  
  # Golden tests
  alchemist: ^0.7.0
```

追加後、依存関係をインストールします：

```bash
flutter pub get
```

### 2. dart_test.yamlの設定

プロジェクトのルートディレクトリに`dart_test.yaml`ファイルを作成し、以下の内容を追加します：

```yaml
tags:
  golden:
```

これにより、`--tags=golden`フラグを使用してgolden testのみを実行できるようになります。

### 3. サポートファイルの作成

Golden Testに必要なサポートファイルを作成します。

#### デバイス設定ファイル

`test/support/alchemist/device.dart`を作成します：

```dart
import 'package:flutter/material.dart';

/// This [Device] is a configuration for golden test.
class Device {
  /// This [Device] is a configuration for golden test.
  const Device({
    required this.size,
    required this.name,
    this.devicePixelRatio = 1.0,
    this.textScaleFactor = 1.0,
    this.brightness = Brightness.light,
    this.safeArea = EdgeInsets.zero,
  });

  /// [phoneLandscape] example of phone that in landscape mode
  static const Device phoneLandscape =
      Device(name: 'phone_landscape', size: Size(667, 375));

  /// [phonePortrait] example of phone that in portrait mode
  static const Device phonePortrait =
      Device(name: 'phone_portrait', size: Size(375, 667));

  /// [tabletLandscape] example of tablet that in landscape mode
  static const Device tabletLandscape =
      Device(name: 'tablet_landscape', size: Size(1366, 1024));

  /// [tabletPortrait] example of tablet that in portrait mode
  static const Device tabletPortrait =
      Device(name: 'tablet_portrait', size: Size(1024, 1366));

  static List<Device> all = [
    phonePortrait,
    phonePortrait.dark(),
    phoneLandscape,
    phoneLandscape.dark(),
    tabletPortrait,
    tabletPortrait.dark(),
    tabletLandscape,
    tabletLandscape.dark(),
  ];

  /// [name] specify device name. Ex: Phone, Tablet, Watch
  final String name;

  /// [size] specify device screen size. Ex: Size(1366, 1024))
  final Size size;

  /// [devicePixelRatio] specify device Pixel Ratio
  final double devicePixelRatio;

  /// [textScaleFactor] specify custom text scale factor
  final double textScaleFactor;

  /// [brightness] specify platform brightness
  final Brightness brightness;

  /// [safeArea] specify insets to define a safe area
  final EdgeInsets safeArea;

  /// [copyWith] convenience function for [Device] modification
  Device copyWith({
    Size? size,
    double? devicePixelRatio,
    String? name,
    double? textScale,
    Brightness? brightness,
    EdgeInsets? safeArea,
  }) {
    return Device(
      size: size ?? this.size,
      devicePixelRatio: devicePixelRatio ?? this.devicePixelRatio,
      name: name ?? this.name,
      textScaleFactor: textScale ?? textScaleFactor,
      brightness: brightness ?? this.brightness,
      safeArea: safeArea ?? this.safeArea,
    );
  }

  /// [dark] convenience method to copy the current device and apply dark theme
  Device dark() {
    return Device(
      size: size,
      devicePixelRatio: devicePixelRatio,
      textScaleFactor: textScaleFactor,
      brightness: Brightness.dark,
      safeArea: safeArea,
      name: '${name}_dark',
    );
  }

  @override
  String toString() {
    return 'Device: $name, '
        '${size.width}x${size.height} @ $devicePixelRatio, '
        'text: $textScaleFactor, $brightness, safe: $safeArea';
  }
}
```

#### テストシナリオファイル

`test/support/alchemist/golden_test_device_scenario.dart`を作成します：

```dart
import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';

import 'device.dart';
export 'device.dart';

class GoldenTestDeviceScenario extends StatelessWidget {
  const GoldenTestDeviceScenario({
    super.key,
    required this.name,
    required this.device,
    required this.builder,
  });

  final String name;
  final Device device;
  final ValueGetter<Widget> builder;

  @override
  Widget build(BuildContext context) {
    return GoldenTestScenario(
      name: '$name (${device.name})',
      child: ClipRect(
        child: MediaQuery(
          data: MediaQuery.of(context).copyWith(
            size: device.size,
            padding: device.safeArea,
            platformBrightness: device.brightness,
            devicePixelRatio: device.devicePixelRatio,
            textScaler: TextScaler.linear(device.textScaleFactor),
          ),
          child: SizedBox(
            height: device.size.height,
            width: device.size.width,
            child: builder(),
          ),
        ),
      ),
    );
  }
}
```

### 4. GitHub Actionsワークフローの設定

`.github/workflows/golden_test.yml`ファイルを作成して、CI/CDパイプラインでGolden Testを実行できるようにします：

```yaml
name: Flutter Golden Tests

on:
  pull_request:
    paths:
      - "lib/**"
      - "test/**"
      - "pubspec.yaml"

permissions:
  contents: write
  pull-requests: write

jobs:
  golden_tests:
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: "3.29.0"
          channel: "stable"
          cache: true

      - name: Install dependencies
        run: flutter pub get

      - name: Get changed files
        id: changed-files
        uses: tj-actions/changed-files@v42
        with:
          files: |
            lib/**/*.dart

      - name: Check for new views
        if: steps.changed-files.outputs.any_changed == 'true'
        id: check-new-views
        run: |
          has_new_views=false
          for file in ${{ steps.changed-files.outputs.all_changed_files }}; do
            if [[ $file == lib/* ]]; then
              component_name=$(basename ${file%.*})
              test_dir="test/views/${component_name}_test"
              if [ ! -d "$test_dir/goldens/ci" ]; then
                has_new_views=true
                echo "New view detected: $component_name"
                break
              fi
            fi
          done
          echo "has_new_views=$has_new_views" >> $GITHUB_OUTPUT

      - name: Initialize Golden images for new views
        if: steps.changed-files.outputs.any_changed == 'true' && steps.check-new-views.outputs.has_new_views == 'true'
        run: |
          git checkout -f ${{ github.head_ref }}
          flutter pub get
          for file in ${{ steps.changed-files.outputs.all_changed_files }}; do
            if [[ $file == lib/* ]]; then
              component_name=$(basename ${file%.*})
              test_path="test/views/${component_name}_test/${component_name}_test.dart"
              test_dir="test/views/${component_name}_test"
              if [ ! -d "$test_dir/goldens/ci" ] && [ -f "$test_path" ]; then
                echo "Initializing Golden Test for $component_name"
                mkdir -p "$test_dir/goldens/ci"
                mkdir -p "$test_dir/failures"
                flutter test --update-goldens "$test_path"
                # Find the actual generated golden file
                golden_file=$(find "$test_dir/goldens/ci" -type f -name "*.png" | head -n 1)
                if [ -n "$golden_file" ]; then
                  cp "$golden_file" "$test_dir/failures/my_app_default_masterImage.png"
                  cp "$golden_file" "$test_dir/failures/my_app_default_testImage.png"
                else
                  echo "No golden file found for $component_name"
                  exit 1
                fi
              fi
            fi
          done
          git config --global user.name "GitHub Actions Bot"
          git config --global user.email "actions@github.com"
          git add .
          git commit -m "Initialize Golden Test images for new views" || echo "No changes to commit"
          git push origin ${{ github.head_ref }}

      - name: Run Golden Tests
        id: run-golden-tests
        if: steps.changed-files.outputs.any_changed == 'true'
        run: |
          git checkout -f ${{ github.head_ref }}
          flutter pub get
          
          # Create a temporary directory for test results
          mkdir -p test_results
          
          # Run tests and capture if they fail
          set +e
          flutter test --tags=golden
          test_exit_code=$?
          set -e
          
          # Check if any tests failed
          if [ $test_exit_code -ne 0 ]; then
            echo "has_ui_changes=true" >> $GITHUB_OUTPUT
          else
            echo "has_ui_changes=false" >> $GITHUB_OUTPUT
          fi

      - name: Check for UI changes
        if: steps.changed-files.outputs.any_changed == 'true'
        id: check-ui-changes
        run: |
          has_ui_changes=false
          for file in ${{ steps.changed-files.outputs.all_changed_files }}; do
            if [[ $file == lib/* ]]; then
              component_name=$(basename ${file%.*})
              test_dir="test/views/${component_name}_test"
              if [ -d "$test_dir/failures" ]; then
                has_ui_changes=true
                echo "UI changes detected in: $component_name"
                break
              fi
            fi
          done
          echo "has_ui_changes=$has_ui_changes" >> $GITHUB_OUTPUT

      - name: Commit test failures
        if: steps.changed-files.outputs.any_changed == 'true' && (steps.check-ui-changes.outputs.has_ui_changes == 'true' || steps.run-golden-tests.outputs.has_ui_changes == 'true')
        run: |
          git config --global user.name "GitHub Actions Bot"
          git config --global user.email "actions@github.com"
          
          # Commit the failure images
          git add test/views/*/failures/*.png || echo "No failure images to add"
          git commit -m "Add Golden Test failure images" || echo "No changes to commit"
          git push origin ${{ github.head_ref }}

      - name: Generate markdown for PR
        if: steps.changed-files.outputs.any_changed == 'true' && (steps.check-ui-changes.outputs.has_ui_changes == 'true' || steps.run-golden-tests.outputs.has_ui_changes == 'true')
        id: generate-markdown
        run: |
          commit_sha=$(git rev-parse HEAD)
          markdown="## UI の変更\n\n"
          
          for file in ${{ steps.changed-files.outputs.all_changed_files }}; do
            if [[ $file == lib/* ]]; then
              component_name=$(basename ${file%.*})
              test_dir="test/views/${component_name}_test"
              if [ -d "$test_dir" ]; then
                markdown="${markdown}### ${component_name} の変更\n\n"
                markdown="${markdown}| 変更前 | 変更後 |\n"
                markdown="${markdown}|--------|--------|\n"
                markdown="${markdown}|![Before](https://github.com/${{ github.repository }}/blob/$commit_sha/$test_dir/failures/my_app_default_masterImage.png?raw=true)|![After](https://github.com/${{ github.repository }}/blob/$commit_sha/$test_dir/failures/my_app_default_testImage.png?raw=true)|\n\n"
              fi
            fi
          done

          echo "markdown<<EOF" >> $GITHUB_OUTPUT
          echo -e "$markdown" >> $GITHUB_OUTPUT
          echo "EOF" >> $GITHUB_OUTPUT

      - name: Update PR description
        if: steps.changed-files.outputs.any_changed == 'true' && (steps.check-ui-changes.outputs.has_ui_changes == 'true' || steps.run-golden-tests.outputs.has_ui_changes == 'true' || steps.check-new-views.outputs.has_new_views == 'true')
        env:
          GH_TOKEN: ${{ github.token }}
        run: |
          pr_body="# UI の変更確認
          以下のファイルのUI変更がありました：
          ${{ steps.changed-files.outputs.all_changed_files }}
          ${{ steps.generate-markdown.outputs.markdown }}

          変更内容を確認し、意図した通りの変更になっているかご確認ください。
          問題がなければ、\`flutter test --update-goldens --tags=golden\` を実行してGolden Imageを更新してください。"

          gh pr edit ${{ github.event.pull_request.number }} --body "$pr_body"

      - name: No UI changes detected
        if: steps.changed-files.outputs.any_changed == 'true' && steps.check-ui-changes.outputs.has_ui_changes != 'true' && steps.run-golden-tests.outputs.has_ui_changes != 'true' && steps.check-new-views.outputs.has_new_views != 'true'
        run: |
          echo "No UI changes were detected in the Golden Test images."
```

## Golden Testの作成方法

### ディレクトリ構造

Golden Testは以下のディレクトリ構造に従って作成します：

```
test/
  views/
    widget_name_test/
      widget_name_test.dart
      goldens/
        ci/
          my_app_default.png
      failures/
        my_app_default_masterImage.png
        my_app_default_testImage.png
```

### テストファイルの作成

1. テスト対象のウィジェットに対応するテストファイルを作成します。例えば、`lib/views/sample_widget.dart`というファイルをテストする場合、`test/views/sample_widget_test/sample_widget_test.dart`を作成します。

2. 以下のようなテストコードを記述します：

```dart
import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:today_list/views/sample_widget.dart';  // テスト対象のウィジェット

import '../../support/alchemist/golden_test_device_scenario.dart';

void main() {
  group('Sample Widget Golden Tests', () {
    goldenTest(
      'renders correctly',
      fileName: 'my_app_default',
      builder: () => GoldenTestGroup(
        children: [
          // スマートフォン縦向きでのテスト
          GoldenTestDeviceScenario(
            name: 'default',
            device: Device.phonePortrait,
            builder: () => MaterialApp(
              theme: ThemeData.light(),
              home: const SampleWidget(),  // テスト対象のウィジェット
            ),
          ),
          // ダークテーマでのテスト
          GoldenTestDeviceScenario(
            name: 'dark theme',
            device: Device.phonePortrait.dark(),
            builder: () => MaterialApp(
              theme: ThemeData.dark(),
              home: const SampleWidget(),  // テスト対象のウィジェット
            ),
          ),
          // タブレットサイズでのテスト
          GoldenTestDeviceScenario(
            name: 'tablet',
            device: Device.tabletPortrait,
            builder: () => MaterialApp(
              theme: ThemeData.light(),
              home: const SampleWidget(),  // テスト対象のウィジェット
            ),
          ),
        ],
      ),
    );
  });
}
```

### ゴールデンファイルの生成

テストファイルを作成したら、以下のコマンドを実行してゴールデンファイルを生成します：

```bash
flutter test --update-goldens test/views/sample_widget_test/sample_widget_test.dart
```

これにより、`test/views/sample_widget_test/goldens/ci/my_app_default.png`というファイルが生成されます。

## Golden Testの実行方法

### すべてのGolden Testを実行

```bash
flutter test --tags=golden
```

### 特定のGolden Testを実行

```bash
flutter test test/views/sample_widget_test/sample_widget_test.dart
```

### ゴールデンファイルの更新

UIに意図的な変更を加えた場合は、以下のコマンドでゴールデンファイルを更新します：

```bash
flutter test --update-goldens --tags=golden
```

または特定のテストのみ更新する場合：

```bash
flutter test --update-goldens test/views/sample_widget_test/sample_widget_test.dart
```

## GitHub Actionsでの自動テスト

GitHub Actionsワークフローは以下のように動作します：

1. PRが作成または更新され、`lib/`、`test/`、または`pubspec.yaml`に変更がある場合に実行されます
2. 変更されたファイルを検出し、対応するGolden Testを実行します
3. UIに変更がある場合：
   - 変更前後の画像をコミットします
   - PR説明に変更前後の画像を追加します
   - レビュアーに変更の確認を促します

## ベストプラクティス

1. **テスト対象を明確にする**：各Golden Testは特定のウィジェットに焦点を当て、そのウィジェットの視覚的な外観のみをテストします。

2. **複数のデバイスサイズとテーマでテストする**：レスポンシブデザインを確認するために、異なるデバイスサイズやテーマでウィジェットをテストします。

3. **テスト名を明確にする**：テスト名は何をテストしているのかを明確に示すようにします。

4. **UIの変更を意図的に行う場合**：
   - ローカルで`--update-goldens`フラグを使用してゴールデンファイルを更新します
   - 更新したゴールデンファイルをコミットしてプッシュします
   - PRの説明に変更内容を明記します

5. **テストの安定性を確保する**：
   - 日付や時間など、実行ごとに変わる可能性のある要素を固定値に置き換えます
   - アニメーションを無効にします
   - ランダムな要素を避けます

## トラブルシューティング

### テストが失敗する場合

1. **プラットフォームの違い**：macOSとLinuxでは微妙にレンダリング結果が異なる場合があります。CI環境と同じプラットフォームでテストを実行するか、プラットフォーム固有のゴールデンファイルを使用します。

2. **フォントの違い**：システムフォントが異なると、テキストのレンダリングが変わる場合があります。パッケージにフォントを含めて、すべての環境で同じフォントを使用するようにします。

3. **画像サイズの不一致**：デバイスのピクセル比率が異なると、画像サイズが変わる場合があります。`devicePixelRatio`を明示的に設定します。

### ゴールデンファイルの更新

意図的なUI変更を行った場合は、以下のコマンドでゴールデンファイルを更新します：

```bash
flutter test --update-goldens --tags=golden
```

## サンプルテスト

以下は、サンプルウィジェットのGolden Testの例です：

```dart
import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/alchemist/golden_test_device_scenario.dart';

void main() {
  group('Sample Widget Golden Tests', () {
    goldenTest(
      'renders correctly',
      fileName: 'my_app_default',
      builder: () => GoldenTestGroup(
        children: [
          // Test on phone portrait
          GoldenTestDeviceScenario(
            name: 'default',
            device: Device.phonePortrait,
            builder: () => MaterialApp(
              theme: ThemeData.light(),
              home: Scaffold(
                appBar: AppBar(
                  title: const Text('Sample Widget'),
                ),
                body: const Center(
                  child: Text('Hello, Golden Test!'),
                ),
              ),
            ),
          ),
          // Test on phone portrait with dark theme
          GoldenTestDeviceScenario(
            name: 'dark theme',
            device: Device.phonePortrait.dark(),
            builder: () => MaterialApp(
              theme: ThemeData.dark(),
              home: Scaffold(
                appBar: AppBar(
                  title: const Text('Sample Widget'),
                ),
                body: const Center(
                  child: Text('Hello, Golden Test!'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  });
}
```

## まとめ

Golden Testは、Flutterアプリケーションのユーザーインターフェイスを視覚的にテストするための強力なツールです。適切に設定し、定期的に実行することで、意図しないUI変更を早期に検出し、アプリケーションの品質を向上させることができます。

このガイドに従って、Today Listプロジェクトでのgolden testの設定と使用を行ってください。質問や問題がある場合は、チームメンバーに相談するか、issueを作成してください。 