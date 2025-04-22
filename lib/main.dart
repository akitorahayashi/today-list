import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/service/tl_ads/tl_ads.dart';
import 'package:today_list/service/tl_vibration.dart';
import './app.dart';
import 'dart:async';

import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:app_links/app_links.dart';

bool kAdTestMode = true;
bool kNotToShowAd = true;

// URLスキームからのパラメータを保持する
String? initialWorkspaceId;

// URLスキームのリスナー用サブスクリプション
StreamSubscription<Uri?>? _linkSubscription;

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
  await TLAdsService.initializeTLAds();
  await TLVibrationService.initVibrate();

  final _appLinks = AppLinks();

  // URLスキームからの起動を処理
  try {
    // 初期リンクの取得（GoRouterが処理するため、ここでは値の保存のみ）
    final initialUri = await _appLinks.getInitialLink();
    if (initialUri != null) {
      if (initialUri.scheme == 'todaylist' &&
          initialUri.host == 'workspace' &&
          initialUri.queryParameters.containsKey('id')) {
        initialWorkspaceId = initialUri.queryParameters['id'];
      }
    }

    // アプリ実行中のリンク処理のためのリスナーを設定
    // GoRouterがリダイレクトを処理するため、ここでは値の保存のみ
    _linkSubscription = _appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        if (uri.scheme == 'todaylist' &&
            uri.host == 'workspace' &&
            uri.queryParameters.containsKey('id')) {
          initialWorkspaceId = uri.queryParameters['id'];
          print('Deep link received: $uri');
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
