import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/main.dart';
import '../../../model/external/tl_ads.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class SetIOSWidgetPage extends ConsumerStatefulWidget {
  const SetIOSWidgetPage({super.key});

  @override
  ConsumerState<SetIOSWidgetPage> createState() => _SetIOSWidgetPageState();
}

class _SetIOSWidgetPageState extends ConsumerState<SetIOSWidgetPage> {
  // 広告
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    TLAds.loadRewardedAd();
    // 広告を読み込む
    BannerAd(
      adUnitId: TLAds.setFeaturesBannerAdUnitId(isTestMode: kAdTestMode),
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          ad.dispose();
        },
      ),
    ).load();
  }

  @override
  void dispose() {
    TLAds.rewardedAd?.dispose();
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        // 広告
        if (_bannerAd != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: _bannerAd!.size.width.toDouble(),
                height: _bannerAd!.size.height.toDouble(),
                child: AdWidget(ad: _bannerAd!),
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text("SetIOSWidgetPage"),
        ),
        // スペーサー
        SizedBox(height: 250),
      ],
    );
  }
}
