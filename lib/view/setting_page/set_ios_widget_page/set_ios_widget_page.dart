import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/view/setting_page/set_ios_widget_page/create_wk_settings_card/add_wks_button.dart';
import 'package:today_list/view/setting_page/set_ios_widget_page/create_wk_settings_card/create_wk_settings_card.dart';
import 'package:today_list/view/setting_page/set_ios_widget_page/wks_card_list/wks_card_list.dart';
import 'package:today_list/main.dart';
import 'package:today_list/model/external/tl_vibration.dart';
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
  // wks追加ボタンを表示するか
  bool _showAddWKSButton = true;

  @override
  void initState() {
    super.initState();
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
        // 設定済みのWidgetExtensionを表示
        const Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: WKSCardList(),
        ),
        // 新たにWidgetExtensionを追加
        Center(
          child: AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            // +マーク
            firstChild: AddWKSButton(onPressed: () {
              TLVibration.vibrate();
              setState(() {
                _showAddWKSButton = false;
              });
            }),
            secondChild: CreateWKSettingsCard(
              showAddWKSButtonAction: () {
                setState(() {
                  _showAddWKSButton = true;
                });
              },
            ),
            crossFadeState: _showAddWKSButton
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
          ),
        ),
        // スペーサー
        const SizedBox(height: 250),
      ],
    );
  }
}
