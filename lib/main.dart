import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/external/tl_ads.dart';
import 'package:today_list/service/tl_vibration.dart';
import './app.dart';

import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:uni_links/uni_links.dart';
import 'dart:async';

bool kAdTestMode = true;
bool kNotToShowAd = true;

// URLスキームからのパラメータを保持するグローバル変数
// 後方互換性のために残しておく
String? initialWorkspaceId;

// URLスキームのリスナー用サブスクリプション
StreamSubscription<String?>? _linkSubscription;

// アプリのライフサイクルを監視するクラス
class AppLifecycleObserver extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      // アプリが終了する際にサブスクリプションをキャンセル
      _linkSubscription?.cancel();
    }
  }
}

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await dotenv.load(fileName: ".env");
  await TLAds.initializeTLAds();
  await TLVibrationService.initVibrate();

  // URLスキームからの起動を処理
  try {
    // 初期リンクの取得（GoRouterが処理するため、ここでは値の保存のみ）
    final initialLink = await getInitialLink();
    if (initialLink != null) {
      final uri = Uri.parse(initialLink);
      if (uri.scheme == 'todaylist' &&
          uri.host == 'workspace' &&
          uri.queryParameters.containsKey('id')) {
        initialWorkspaceId = uri.queryParameters['id'];
      }
    }

    // アプリ実行中のリンク処理のためのリスナーを設定
    // GoRouterがリダイレクトを処理するため、ここでは値の保存のみ
    _linkSubscription = linkStream.listen((String? link) {
      if (link != null) {
        final uri = Uri.parse(link);
        if (uri.scheme == 'todaylist' &&
            uri.host == 'workspace' &&
            uri.queryParameters.containsKey('id')) {
          initialWorkspaceId = uri.queryParameters['id'];
          print('Deep link received: $link');
        }
      }
    });

    // アプリ終了時にサブスクリプションをキャンセル
    WidgetsBinding.instance.addObserver(AppLifecycleObserver());
  } catch (e) {
    print('Error handling deep links: $e');
  }

  // アプリの起動
  runApp(const ProviderScope(child: TodayListApp()));
}
