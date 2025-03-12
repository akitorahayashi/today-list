# CI/CD セットアップ手順書

このドキュメントでは、Today Listアプリのための継続的インテグレーション/継続的デリバリー(CI/CD)環境を一から構築する手順を説明します。

## 目次

1. [前提条件](#前提条件)
2. [GitHub Actionsのセットアップ](#github-actionsのセットアップ)
3. [Fastlaneのセットアップ](#fastlaneのセットアップ)
4. [Firebase App Distributionのセットアップ](#firebase-app-distributionのセットアップ)
5. [シークレットの設定](#シークレットの設定)
6. [ローカルでのテスト](#ローカルでのテスト)
7. [トラブルシューティング](#トラブルシューティング)

## 前提条件

- GitHubアカウント
- Flutterプロジェクト
- macOS（iOSビルド用）
- Ruby 2.6以上
- Firebase プロジェクト（App Distributionを使用する場合）

## GitHub Actionsのセットアップ

### 1. ワークフローディレクトリの作成

リポジトリのルートに`.github/workflows`ディレクトリを作成します：

```bash
mkdir -p .github/workflows
```

### 2. ワークフローファイルの作成

`.github/workflows/ci_cd.yml`ファイルを作成し、以下の内容を記述します：

```yaml
name: Flutter CI/CD

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main, develop ]
  workflow_dispatch:  # 手動実行用

jobs:
  # Dartコードの静的解析とテスト
  test:
    name: Test and Analyze
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.19.0'
          channel: 'stable'
          cache: true
      
      - name: Install dependencies
        run: flutter pub get
      
      - name: Verify formatting
        run: dart format --output=none --set-exit-if-changed .
      
      - name: Analyze project source
        run: flutter analyze
      
      - name: Run tests
        run: flutter test

  # iOSビルドとデプロイ
  build_ios:
    name: Build iOS and Deploy
    needs: test
    runs-on: macos-latest
    steps:
      # ... (詳細はci_cd.ymlファイルを参照)

  # Androidビルドとデプロイ
  build_android:
    name: Build Android and Deploy
    needs: test
    runs-on: ubuntu-latest
    steps:
      # ... (詳細はci_cd.ymlファイルを参照)
```

## Fastlaneのセットアップ

### 1. iOS用Fastlaneのセットアップ

#### 1.1 Gemfileの作成

`ios`ディレクトリに移動し、Gemfileを作成します：

```bash
cd ios
touch Gemfile
```

Gemfileに以下の内容を記述します：

```ruby
source "https://rubygems.org"

gem "fastlane"
gem "cocoapods"

plugins_path = File.join(File.dirname(__FILE__), 'fastlane', 'Pluginfile')
eval_gemfile(plugins_path) if File.exist?(plugins_path)
```

#### 1.2 Fastlaneの初期化

Fastlaneを初期化します：

```bash
bundle install
bundle exec fastlane init
```

質問に答えて初期設定を完了します。

#### 1.3 Pluginfileの作成

`fastlane`ディレクトリに`Pluginfile`を作成します：

```bash
mkdir -p fastlane
touch fastlane/Pluginfile
```

Pluginfileに以下の内容を記述します：

```ruby
gem 'fastlane-plugin-firebase_app_distribution'
gem 'fastlane-plugin-increment_version_code'
gem 'fastlane-plugin-versioning'
```

プラグインをインストールします：

```bash
bundle exec fastlane add_plugin firebase_app_distribution
```

#### 1.4 Appfileの作成

`fastlane`ディレクトリに`Appfile`を作成します：

```bash
touch fastlane/Appfile
```

Appfileに以下の内容を記述します：

```ruby
app_identifier("com.yourcompany.todaylist") # アプリのバンドルID
apple_id(ENV["APPLE_ID"] || "your_apple_id@example.com") # Apple IDのメールアドレス
itc_team_id(ENV["ITC_TEAM_ID"] || "123456789") # App Store Connect Team ID
team_id(ENV["TEAM_ID"] || "ABCDEF1234") # Developer Portal Team ID
```

#### 1.5 Fastfileの作成

`fastlane`ディレクトリに`Fastfile`を作成します：

```bash
touch fastlane/Fastfile
```

Fastfileに以下の内容を記述します（詳細は`ios/fastlane/Fastfile`を参照）：

```ruby
default_platform(:ios)

platform :ios do
  # 共通の前処理
  before_all do
    setup_ci if ENV['CI']
  end

  # 証明書とプロビジョニングプロファイルの同期
  desc "証明書とプロビジョニングプロファイルを同期"
  lane :sync_certificates do
    # ... (詳細はFastfileを参照)
  end

  # Firebase App Distributionへのデプロイ
  desc "Firebase App Distributionにデプロイ"
  lane :firebase do
    # ... (詳細はFastfileを参照)
  end

  # その他のレーン
  # ...
end
```

### 2. Android用Fastlaneのセットアップ

#### 2.1 Gemfileの作成

`android`ディレクトリに移動し、Gemfileを作成します：

```bash
cd android
touch Gemfile
```

Gemfileに以下の内容を記述します：

```ruby
source "https://rubygems.org"

gem "fastlane"

plugins_path = File.join(File.dirname(__FILE__), 'fastlane', 'Pluginfile')
eval_gemfile(plugins_path) if File.exist?(plugins_path)
```

#### 2.2 Fastlaneの初期化

Fastlaneを初期化します：

```bash
bundle install
bundle exec fastlane init
```

質問に答えて初期設定を完了します。

#### 2.3 Pluginfileの作成

`fastlane`ディレクトリに`Pluginfile`を作成します：

```bash
mkdir -p fastlane
touch fastlane/Pluginfile
```

Pluginfileに以下の内容を記述します：

```ruby
gem 'fastlane-plugin-firebase_app_distribution'
gem 'fastlane-plugin-increment_version_code'
```

プラグインをインストールします：

```bash
bundle exec fastlane add_plugin firebase_app_distribution
bundle exec fastlane add_plugin increment_version_code
```

#### 2.4 Appfileの作成

`fastlane`ディレクトリに`Appfile`を作成します：

```bash
touch fastlane/Appfile
```

Appfileに以下の内容を記述します：

```ruby
json_key_file(ENV["SUPPLY_JSON_KEY"] || "path/to/your/play-store-key.json") # Google Play Console APIのJSONキーファイルへのパス
package_name("com.yourcompany.todaylist") # アプリのパッケージ名
```

#### 2.5 Fastfileの作成

`fastlane`ディレクトリに`Fastfile`を作成します：

```bash
touch fastlane/Fastfile
```

Fastfileに以下の内容を記述します（詳細は`android/fastlane/Fastfile`を参照）：

```ruby
default_platform(:android)

platform :android do
  # 共通の前処理
  before_all do
    setup_ci if ENV['CI']
  end

  # Firebase App Distributionへのデプロイ
  desc "Firebase App Distributionにデプロイ"
  lane :firebase do
    # ... (詳細はFastfileを参照)
  end

  # その他のレーン
  # ...
end
```

## Firebase App Distributionのセットアップ

### 1. Firebaseプロジェクトの作成

1. [Firebase Console](https://console.firebase.google.com/)にアクセス
2. 「プロジェクトを追加」をクリック
3. プロジェクト名を入力し、指示に従ってプロジェクトを作成

### 2. iOSアプリの追加

1. Firebaseプロジェクトのダッシュボードで「iOS」アイコンをクリック
2. バンドルIDを入力（例：`com.yourcompany.todaylist`）
3. アプリ名を入力
4. App Store IDを入力（オプション）
5. 「アプリを登録」をクリック
6. `GoogleService-Info.plist`をダウンロードし、Xcodeプロジェクトに追加

### 3. Androidアプリの追加

1. Firebaseプロジェクトのダッシュボードで「Android」アイコンをクリック
2. パッケージ名を入力（例：`com.yourcompany.todaylist`）
3. アプリ名を入力
4. デバッグ署名証明書のSHA-1を入力（オプション）
5. 「アプリを登録」をクリック
6. `google-services.json`をダウンロードし、Androidプロジェクトの`app`ディレクトリに追加

### 4. App Distributionの有効化

1. Firebaseプロジェクトのダッシュボードで「App Distribution」を選択
2. 「開始する」をクリック
3. テスターグループを作成

### 5. Firebase CLIのインストールとトークンの取得

```bash
npm install -g firebase-tools
firebase login:ci
```

表示されたトークンをコピーし、GitHub Secretsに`FIREBASE_TOKEN`として保存します。

## シークレットの設定

GitHub Actionsで使用するシークレットを設定します：

1. GitHubリポジトリページで「Settings」→「Secrets and variables」→「Actions」を選択
2. 「New repository secret」ボタンをクリック
3. 以下のシークレットを追加：

### iOS関連

- `MATCH_PASSWORD`: match用のパスワード
- `APP_STORE_CONNECT_API_KEY_CONTENT`: App Store Connect APIキーの内容
- `APP_STORE_CONNECT_API_KEY_ID`: APIキーID
- `APP_STORE_CONNECT_ISSUER_ID`: 発行者ID
- `MATCH_GIT_BASIC_AUTHORIZATION`: 証明書リポジトリへのアクセス用
- `FASTLANE_PASSWORD`: Apple IDのパスワード
- `APPLE_ID`: Apple IDのメールアドレス
- `ITC_TEAM_ID`: App Store Connect Team ID
- `TEAM_ID`: Developer Portal Team ID

### Android関連

- `ANDROID_KEYSTORE_BASE64`: Base64エンコードされたキーストア
- `ANDROID_KEY_PROPERTIES`: キーストアのプロパティ
- `GOOGLE_PLAY_SERVICE_ACCOUNT_JSON`: Google Play Console APIのJSONキー

### Firebase関連

- `FIREBASE_APP_ID_IOS`: Firebase iOSアプリID
- `FIREBASE_APP_ID_ANDROID`: Firebase AndroidアプリID
- `FIREBASE_TOKEN`: Firebaseデプロイ用トークン

## ローカルでのテスト

### iOSのテスト

```bash
cd ios
bundle install
bundle exec fastlane firebase
```

### Androidのテスト

```bash
cd android
bundle install
bundle exec fastlane firebase
```

## トラブルシューティング

### よくある問題と解決策

#### 1. Fastlaneのインストールエラー

```bash
gem install fastlane -NV
```

#### 2. 証明書の問題

```bash
bundle exec fastlane match development
bundle exec fastlane match appstore
```

#### 3. ビルドエラー

```bash
flutter clean
flutter pub get
```

#### 4. Firebase App Distributionのエラー

```bash
firebase logout
firebase login:ci
```

新しいトークンを取得し、GitHub Secretsを更新します。

#### 5. GitHub Actions実行エラー

- ワークフローのログを確認
- シークレットが正しく設定されているか確認
- ローカルでコマンドを実行してテスト 