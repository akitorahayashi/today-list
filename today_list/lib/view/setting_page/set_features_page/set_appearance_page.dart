// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:today_list/main.dart';
import '../../../constants/theme.dart';
import '../../../constants/icon_for_checkbox.dart';
import '../../../components/for_ui/panel_with_title.dart';
import '../../../model/user/setting_data.dart';
import '../../../model/externals/tl_ads.dart';
import './set_icon/icon_category_panel.dart';
import './set_vibration_card.dart';
import './theme_panel/left_side_show_selecting_panel.dart';
import './theme_panel/right_side_theme_select_button.dart';
import 'show_limit_of_pass_card.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class SetAppearancePage extends StatefulWidget {
  const SetAppearancePage({
    super.key,
  });

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
      adUnitId: TLAds.setFeaturesBannerAdUnitId(isTestMode: adTestMode),
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
    List<String> unUsingTheme = theme.keys
        .where((themeName) => themeName != settingData.selectedTheme)
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
        child: PanelWithTitle(
            title: settingData.englishMode ? "THEME" : "テーマ",
            contents: [
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
                                themeName: unUsingTheme[0]),
                            // 3個目のテーマ
                            RightSideThemeSelectButton(
                                themeName: unUsingTheme[1]),
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
          title: settingData.englishMode ? "VIBRATION" : "バイブレーション",
          // ignore: prefer_const_literals_to_create_immutables
          contents: [SetVibrationCard()]),
      // ICONS選択カード
      PanelWithTitle(
        title: settingData.englishMode ? "ICONS" : "チェックマーク",
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
