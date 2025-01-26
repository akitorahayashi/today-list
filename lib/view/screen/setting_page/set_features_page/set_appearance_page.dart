import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/design/tl_icon_data.dart';
import 'package:today_list/resource/tl_icon_resource.dart';
import 'package:today_list/view/screen/setting_page/set_features_page/updaate_app_icon_card.dart';
import 'package:today_list/view_model/design/theme_idx_provider.dart';
import 'package:today_list/resource/tl_theme_data_list.dart';
import '../../../../main.dart';
import '../../../component/common_ui_part/panel_with_title.dart';
import '../../../../service/tl_ads.dart';
import 'set_todo_icon/icon_category_panel.dart';
import 'set_vibration_card.dart';
import 'theme_panel/left_side_show_selecting_panel.dart';
import 'theme_panel/right_side_theme_select_button.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class SetAppearancePage extends ConsumerStatefulWidget {
  const SetAppearancePage({super.key});

  @override
  SetAppearancePageState createState() => SetAppearancePageState();
}

class SetAppearancePageState extends ConsumerState<SetAppearancePage> {
  // 広告
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    TLAdsService.loadRewardedAd();
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
    final int selectedThemeIndex = ref.watch(selectedThemeIndexProvider);
    // テーマを表示させるための変数
    List<int> unUsingThemeIndices =
        List<int>.generate(tlThemeDataList.length, (index) => index)
            .where((index) => index != selectedThemeIndex)
            .toList();

    return ListView(padding: EdgeInsets.zero, children: [
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
      // THEME選択カード
      Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: PanelWithTitle(title: "THEME", contents: [
          // 現在の枚数を表示する
          // const ShowLimitOfPassCard(),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: [
                // テーマを表示する
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // 現在使っているテーマ
                      const LeftSideShowingSelectingPanel(),
                      // 2, 3個目のテーマ
                      SizedBox(
                        height: 320,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // 2個目のテーマ
                            RightSideThemeSelectButton(
                                corrIndex: unUsingThemeIndices[0]),
                            // 3個目のテーマ
                            RightSideThemeSelectButton(
                                corrIndex: unUsingThemeIndices[1]),
                          ],
                        ),
                      ),
                    ]),
                // テーマに合わせたアイコンに変更する
                UpdaateAppIconCard()
              ],
            ),
          ),
        ]),
      ),
      // VIBRATION設定カード
      const PanelWithTitle(
          title: "VIBRATION",
          // ignore: prefer_const_literals_to_create_immutables
          contents: [SetVibrationCard()]),
      // ICONS選択カード
      PanelWithTitle(
        title: "ICONS",
        contents: [
          for (TLIconCategory tlIconCategory in tlIconResource.keys)
            IconCategoryPanel(tlIconCategory: tlIconCategory),
        ],
      ),
      // スペーサー
      const SizedBox(
        height: 250,
      )
      // ]))
    ]);
  }
}
