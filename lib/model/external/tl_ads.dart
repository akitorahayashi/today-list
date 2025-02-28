import 'package:flutter/material.dart';
import 'package:today_list/main.dart';
import 'package:today_list/model/external/tl_ad_unit_type.dart';
import 'package:today_list/view/component/dialog/common/tl_single_option_dialog.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class TLAds {
  static RewardedAd? rewardedAd;

  static Future<void> initializeTLAds() async {
    await MobileAds.instance.initialize();
  }

  static Future<void> showIconRewardedAd(
      {required BuildContext context, required Function rewardAction}) async {
    if (rewardedAd != null) {
      await rewardedAd!.show(onUserEarnedReward: (_, reward) {
        rewardAction();
      });
    } else {
      // 広告がロードされていない場合は再ロード
      await loadIconRewardedAd();
      if (rewardedAd != null) {
        await rewardedAd!.show(onUserEarnedReward: (_, reward) {
          rewardAction();
        });
      } else {
        // 広告がロードできなかった場合のエラーダイアログ
        if (context.mounted) {
          const TLSingleOptionDialog(
                  title: "Error",
                  message: "The internet connection seems to be unstable...")
              .show(context: context);
        }
      }
    }
  }

  static Future<void> loadIconRewardedAd() async {
    return RewardedAd.load(
      adUnitId: TLAdUnitType.iconRewarded.getAdUnitId(isTestMode: kAdTestMode),
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              rewardedAd = null;
              loadIconRewardedAd();
            },
          );

          rewardedAd = ad;
        },
        onAdFailedToLoad: (err) {
          print('Failed to load a rewarded ad: ${err.message}');
        },
      ),
    );
  }
}
