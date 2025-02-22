import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/view/screen/setting_page/set_tcw_settings_page/create_tcw_settings_card/add_tcw_button.dart';
import 'package:today_list/view/screen/setting_page/set_tcw_settings_page/create_tcw_settings_card/create_tcw_settings_card.dart';
import 'package:today_list/view/screen/setting_page/set_tcw_settings_page/tcw_card_list/card_list_of_todos_in_category_settings.dart';
import 'package:today_list/main.dart';
import 'package:today_list/service/tl_vibration.dart';
import '../../../../service/tl_ads.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class SetTCWPage extends ConsumerStatefulWidget {
  final ValueNotifier<bool> showBottomNavBar;

  const SetTCWPage({super.key, required this.showBottomNavBar});

  @override
  ConsumerState<SetTCWPage> createState() => _SetIOSWidgetPageState();
}

class _SetIOSWidgetPageState extends ConsumerState<SetTCWPage> {
  // 広告
  BannerAd? _bannerAd;
  // tcw追加ボタンを表示するか
  bool _showAddWKSButton = true;

  @override
  void initState() {
    super.initState();
    // 広告を読み込む
    BannerAd(
      adUnitId: TLAdsService.setFeaturesBannerAdUnitId(isTestMode: kAdTestMode),
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
    TLAdsService.rewardedAd?.dispose();
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
          child: CardListOfToDosInCategoryWidgetSettings(),
        ),
        // 新たにWidgetExtensionを追加
        Center(
          child: AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            // +マーク
            firstChild: AddToDosInCategoryWidgetSettingsButton(onPressed: () {
              TLVibrationService.vibrate();
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
              showBottomNavBar: widget.showBottomNavBar,
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
