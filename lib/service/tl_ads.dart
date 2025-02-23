import 'package:flutter/material.dart';
import 'package:today_list/main.dart';
import 'package:today_list/view/component/dialog/common/tl_single_option_dialog.dart';
import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TLAdsService {
  static RewardedAd? rewardedAd;

  static Future<void> initializeTLAds() async {
    await MobileAds.instance.initialize();
  }

  static Future<void> showRewardedAd(
      {required BuildContext context, required Function rewardAction}) async {
    if (TLAdsService.rewardedAd != null) {
      await TLAdsService.rewardedAd!.show(onUserEarnedReward: (_, reward) {
        rewardAction();
      });
    } else {
      // ロードできてなかった時再ロード
      loadRewardedAd().then((_) async {
        if (TLAdsService.rewardedAd != null) {
          await TLAdsService.rewardedAd!.show(onUserEarnedReward: (_, reward) {
            rewardAction(_, reward);
          });
        } else {
          // それでも無理だったらエラーを出す
          showDialog(
              context: context,
              builder: ((context) {
                return TLSingleOptionDialog(
                  title: "エラー",
                  message: "インターネット環境の調子が悪いようです...",
                );
              }));
        }
      });
    }
  }

  static Future<void> loadRewardedAd() async {
    return RewardedAd.load(
      adUnitId: TLAdsService.rewardedAdUnitId(isTestMode: kAdTestMode),
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              TLAdsService.rewardedAd = null;
              loadRewardedAd();
            },
          );

          TLAdsService.rewardedAd = ad;
        },
        onAdFailedToLoad: (err) {
          print('Failed to load a rewarded ad: ${err.message}');
        },
      ),
    );
  }

  // ad unit id
  static String editPageBannerAdUnitId({required bool isTestMode}) {
    if (isTestMode) {
      return Platform.isIOS
          ? dotenv.env['IOS_BANNER_AD_UNIT_ID_TEST']!
          : dotenv.env['ANDROID_BANNER_AD_UNIT_ID_TEST']!;
    } else {
      return Platform.isIOS
          ? dotenv.env['IOS_BANNER_AD_UNIT_ID_TEST']!
          : dotenv.env['ANDROID_BANNER_AD_UNIT_ID_TEST']!;
    }
  }

  static String setFeaturesBannerAdUnitId({required bool isTestMode}) {
    if (isTestMode) {
      return Platform.isIOS
          ? dotenv.env['IOS_BANNER_AD_UNIT_ID_TEST']!
          : dotenv.env['ANDROID_BANNER_AD_UNIT_ID_TEST']!;
    } else {
      return Platform.isIOS
          ? dotenv.env['IOS_BANNER_AD_UNIT_ID_TEST']!
          : dotenv.env['ANDROID_BANNER_AD_UNIT_ID_TEST']!;
    }
  }

  static String rewardedAdUnitId({required bool isTestMode}) {
    if (isTestMode) {
      return Platform.isIOS
          ? dotenv.env['IOS_REWARDED_AD_UNIT_ID_TEST']!
          : dotenv.env['ANDROID_REWARDED_AD_UNIT_ID_TEST']!;
    } else {
      return Platform.isIOS
          ? dotenv.env['IOS_REWARDED_AD_UNIT_ID_TEST']!
          : dotenv.env['ANDROID_REWARDED_AD_UNIT_ID_TEST']!;
    }
  }
}
