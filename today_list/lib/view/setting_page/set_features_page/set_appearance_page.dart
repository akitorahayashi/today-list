// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:today_list/main.dart';
import '../../../model/tl_theme.dart';
import '../../../constants/icon_for_checkbox_data.dart';
import '../../../components/common/panel_with_title.dart';
import '../../../model/user/setting_data.dart';
import '../../../model/external/tl_ads.dart';
import './set_icon/icon_category_panel.dart';
import './set_vibration_card.dart';
import './theme_panel/left_side_show_selecting_panel.dart';
import './theme_panel/right_side_theme_select_button.dart';
import 'show_limit_of_pass_card.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class SetAppearancePage extends StatefulWidget {
  const SetAppearancePage({Key? key}) : super(key: key);

  @override
  SetAppearancePageState createState() => SetAppearancePageState();
}

class SetAppearancePageState extends State<SetAppearancePage> {
  // 広告
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    TLAds.loadRewardedAd();
    // 広告を読み込む
    BannerAd(
      adUnitId: TLAds.setFeaturesBannerAdUnitId(isTestMode: kAdTestMode),
      request: AdRequest(),
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
    double deviceWidth = MediaQuery.of(context).size.width;
    // テーマを表示させるための変数
    List<int> unUsingThemeIndices =
        List<int>.generate(tlThemeDataList.length, (index) => index)
            .where((index) => index != SettingData.shared.selectedThemeIndex)
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
          ShowLimitOfPassCard(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // 現在使っているテーマ
                  LeftSideShowingSelectingPanel(deviceWidth: deviceWidth),
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
          ),
        ]),
      ),
      // VIBRATION設定カード
      // ignore: prefer_const_literals_to_create_immutables
      PanelWithTitle(
          title: "VIBRATION",
          // ignore: prefer_const_literals_to_create_immutables
          contents: [SetVibrationCard()]),
      // ICONS選択カード
      PanelWithTitle(
        title: "ICONS",
        contents: [
          for (String iconCategoryName in iconsForCheckBox.keys)
            IconCategoryPanel(iconCategoryName: iconCategoryName),
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
