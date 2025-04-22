import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:today_list/main.dart';
import 'package:today_list/service/tl_ads/tl_ad_unit_type.dart';
import 'package:today_list/view/component/dialog/common/tl_single_option_dialog.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class TLAdsService {
  static RewardedAd? rewardedAd;
  static bool isLoadingRewardedAd = false;

  static Future<void> initializeTLAds() async {
    await MobileAds.instance.initialize();
  }

  static Future<void> showIconRewardedAd({
    required BuildContext context,
    required Function rewardAction,
  }) async {
    // まず ProgressHUD を表示
    ProgressHUD.of(context)?.show();

    // すでにロード済みの広告があれば表示
    if (rewardedAd != null) {
      await rewardedAd!.show(
        onUserEarnedReward: (_, reward) {
          rewardAction();
        },
      );
      // ユーザーが広告を閉じた直後に HUD を消す
      if (context.mounted) {
        ProgressHUD.of(context)?.dismiss();
      }
      return;
    }

    // ② まだロード中・ロードしていない場合は広告ロード
    if (isLoadingRewardedAd) {
      return;
    }
    final success = await loadIconRewardedAd();

    if (!success || rewardedAd == null) {
      // ロード失敗
      if (context.mounted) {
        const TLSingleOptionDialog(
          title: "Error",
          message: "The internet connection seems to be unstable...",
        ).show(context: context);
      }
      // ③ ロード失敗時に HUD を消す
      if (context.mounted) {
        ProgressHUD.of(context)?.dismiss();
      }
      return;
    }

    // ④ ロード成功したので広告を表示
    await rewardedAd!.show(
      onUserEarnedReward: (_, reward) {
        rewardAction();
      },
    );

    // 広告を閉じたら HUD を消す
    if (context.mounted) {
      ProgressHUD.of(context)?.dismiss();
    }
  }

  static Future<bool> loadIconRewardedAd() async {
    if (isLoadingRewardedAd) return false;
    isLoadingRewardedAd = true;

    final completer = Completer<bool>();

    RewardedAd.load(
      adUnitId: TLAdUnitType.iconRewarded.getAdUnitId(isTestMode: kAdTestMode),
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              rewardedAd = null;
            },
          );
          rewardedAd = ad;
          isLoadingRewardedAd = false;
          completer.complete(true);
        },
        onAdFailedToLoad: (err) {
          isLoadingRewardedAd = false;
          completer.complete(false);
        },
      ),
    );

    return completer.future;
  }
}
