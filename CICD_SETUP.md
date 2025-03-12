# CI/CD セットアップガイド

このドキュメントでは、Today Listアプリのための継続的インテグレーション/継続的デリバリー(CI/CD)パイプラインのセットアップ方法について説明します。このプロジェクトでは、GitHub ActionsとFastlaneを組み合わせて自動化されたビルド、テスト、デプロイプロセスを実現しています。

## 目次

1. [概要](#概要)
2. [GitHub Actionsの設定](#github-actionsの設定)
3. [Fastlaneの設定](#fastlaneの設定)
4. [初めてのセットアップ手順](#初めてのセットアップ手順)
5. [シークレットの設定](#シークレットの設定)
6. [開発中の注意点](#開発中の注意点)
7. [トラブルシューティング](#トラブルシューティング)

## 概要

CI/CDパイプラインは以下のステップで構成されています：

1. **コードの検証**: Dartコードのフォーマットチェック、静的解析、ユニットテストの実行
2. **ビルド**: iOS/Androidアプリのビルド
3. **デプロイ**: TestFlight、Google Play内部テスト、またはFirebase App Distributionへのデプロイ

## GitHub Actionsの設定

GitHub Actionsは、リポジトリ内の`.github/workflows`ディレクトリにYAMLファイルを配置することで設定します。

### ワークフローファイルの構造

現在のワークフローファイル(`.github/workflows/ci_cd.yml`)は以下のジョブで構成されています：

1. **test**: Dartコードの検証
2. **build_ios**: iOSアプリのビルドとデプロイ
3. **build_android**: Androidアプリのビルドとデプロイ

### ワークフローのトリガー

ワークフローは以下の場合に実行されます：

- `main`または`develop`ブランチへのプッシュ
- `main`または`develop`ブランチへのプルリクエスト
- 手動実行（`workflow_dispatch`イベント）

### カスタマイズ方法

ワークフローファイルは以下のように変更できます：

- トリガーするブランチの変更: `on.push.branches`と`on.pull_request.branches`を編集
- Flutterバージョンの変更: `flutter-version`パラメータを編集
- ジョブの追加/削除: 新しいジョブを定義するか、既存のジョブをコメントアウト

## Fastlaneの設定

Fastlaneは、モバイルアプリのビルドとデプロイを自動化するためのツールです。

### ディレクトリ構造

```
├── android/
│   ├── fastlane/
│   │   ├── Appfile        # アプリの基本情報
│   │   ├── Fastfile       # 実行可能なレーン（タスク）の定義
│   │   └── Pluginfile     # 使用するプラグイン
│   └── Gemfile            # 必要なRubyライブラリ
└── ios/
    ├── fastlane/
    │   ├── Appfile        # アプリの基本情報
    │   ├── Fastfile       # 実行可能なレーン（タスク）の定義
    │   └── Pluginfile     # 使用するプラグイン
    └── Gemfile            # 必要なRubyライブラリ
```

### iOS用のレーン

現在のiOS用Fastfileには以下のレーンが定義されています：

- **sync_certificates**: 証明書とプロビジョニングプロファイルの同期
- **beta**: TestFlightへのベータ版デプロイ
- **release**: App Storeへのリリース

### Android用のレーン

現在のAndroid用Fastfileには以下のレーンが定義されています：

- **internal**: Google Play内部テスト版のデプロイ
- **beta**: Google Playベータ版のデプロイ
- **release**: Google Play本番リリース

### アプリストアにまだ公開していない場合

アプリをまだストアに公開していない場合は、以下の方法があります：

1. **デプロイ部分をコメントアウト**: 
   - iOS Fastfileの`upload_to_testflight`と`upload_to_app_store`をコメントアウト
   - Android Fastfileの`upload_to_play_store`をコメントアウト

2. **Firebase App Distributionを使用**:
   - Fastlaneプラグイン`fastlane-plugin-firebase_app_distribution`を使用して、Firebase App Distributionにデプロイするレーンを追加

例（iOS用Firebase App Distribution）:

```ruby
lane :firebase do
  # Flutterビルド
  sh("cd .. && flutter build ios --release --no-codesign")
  
  # 証明書とプロビジョニングプロファイルの更新
  sync_certificates
  
  # アプリのビルドとアーカイブ
  build_app(
    workspace: "Runner.xcworkspace",
    scheme: "Runner",
    export_method: "development",
    export_options: {
      provisioningProfiles: {
        "com.yourcompany.todaylist" => "match Development com.yourcompany.todaylist"
      }
    }
  )
  
  # Firebase App Distributionにアップロード
  firebase_app_distribution(
    app: ENV["FIREBASE_APP_ID_IOS"],
    groups: "testers",
    release_notes: "テスト版ビルド"
  )
end
```

## 初めてのセットアップ手順

### 1. GitHub Actionsの設定

1. リポジトリのルートに`.github/workflows`ディレクトリを作成
2. `ci_cd.yml`ファイルを作成し、ワークフロー設定を記述

### 2. Fastlaneのセットアップ

#### iOS

1. iOSディレクトリに移動: `cd ios`
2. Fastlaneをインストール: `gem install fastlane`
3. Fastlaneを初期化: `fastlane init`
4. 必要に応じてGemfileを編集
5. Fastlaneプラグインをインストール: `fastlane add_plugin firebase_app_distribution`など
6. Fastfileを編集して必要なレーンを追加

#### Android

1. Androidディレクトリに移動: `cd android`
2. Fastlaneをインストール: `gem install fastlane`
3. Fastlaneを初期化: `fastlane init`
4. 必要に応じてGemfileを編集
5. Fastlaneプラグインをインストール: `fastlane add_plugin firebase_app_distribution`など
6. Fastfileを編集して必要なレーンを追加

### 3. ローカルでのテスト

各レーンをローカルで実行してテスト：

```bash
# iOSの場合
cd ios
bundle install
bundle exec fastlane beta

# Androidの場合
cd android
bundle install
bundle exec fastlane beta
```

## シークレットの設定

GitHub Actionsで使用するシークレットは、GitHubリポジトリの設定で追加します：

1. リポジトリページで「Settings」→「Secrets and variables」→「Actions」を選択
2. 「New repository secret」ボタンをクリック
3. 必要なシークレットを追加

### 必要なシークレット

#### iOS関連

- `MATCH_PASSWORD`: match用のパスワード
- `APP_STORE_CONNECT_API_KEY_CONTENT`: App Store Connect APIキーの内容
- `APP_STORE_CONNECT_API_KEY_ID`: APIキーID
- `APP_STORE_CONNECT_ISSUER_ID`: 発行者ID
- `MATCH_GIT_BASIC_AUTHORIZATION`: 証明書リポジトリへのアクセス用
- `FASTLANE_PASSWORD`: Apple IDのパスワード
- `APPLE_ID`: Apple IDのメールアドレス
- `ITC_TEAM_ID`: App Store Connect Team ID
- `TEAM_ID`: Developer Portal Team ID

#### Android関連

- `ANDROID_KEYSTORE_BASE64`: Base64エンコードされたキーストア
- `ANDROID_KEY_PROPERTIES`: キーストアのプロパティ
- `GOOGLE_PLAY_SERVICE_ACCOUNT_JSON`: Google Play Console APIのJSONキー

#### Firebase関連（オプション）

- `FIREBASE_APP_ID_IOS`: Firebase iOSアプリID
- `FIREBASE_APP_ID_ANDROID`: Firebase AndroidアプリID
- `FIREBASE_TOKEN`: Firebaseデプロイ用トークン

## 開発中の注意点

### ブランチ戦略

- `develop`ブランチ: 開発版ビルド（TestFlightやGoogle Playベータ版）
- `main`ブランチ: 本番リリース

### バージョン管理

- iOS: `increment_build_number`を使用して自動的にビルド番号を増加
- Android: `increment_version_code`を使用して自動的にバージョンコードを増加

### 初めてのストア公開前の準備

1. App Store Connectでアプリを作成
2. Google Play Consoleでアプリを作成
3. 必要な証明書とプロビジョニングプロファイルを設定
4. 最初のバージョンは手動でアップロード
5. その後のバージョンはCI/CDパイプラインで自動化

## トラブルシューティング

### よくある問題と解決策

1. **証明書の問題**:
   - `match`コマンドを使用して証明書を再同期: `bundle exec fastlane match development`

2. **ビルドエラー**:
   - Flutterのクリーンビルド: `flutter clean && flutter pub get`

3. **デプロイエラー**:
   - APIキーや認証情報が正しく設定されているか確認
   - 環境変数が正しく設定されているか確認

4. **GitHub Actions実行エラー**:
   - ワークフローのログを確認
   - シークレットが正しく設定されているか確認

### サポートリソース

- [Fastlaneドキュメント](https://docs.fastlane.tools/)
- [GitHub Actionsドキュメント](https://docs.github.com/en/actions)
- [Flutter CI/CDガイド](https://flutter.dev/docs/deployment/cd) 