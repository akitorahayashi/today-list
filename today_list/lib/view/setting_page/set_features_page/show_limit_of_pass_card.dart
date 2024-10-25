import 'package:flutter/material.dart';
import '../../../alerts/yes_no_alert.dart';
import '../../../alerts/simple_alert.dart';
import '../../../model/externals/tl_ads.dart';
import '../../../model/user/setting_data.dart';
import '../../../constants/global_keys.dart';
import '../../../constants/theme.dart';

class ShowLimitOfPassCard extends StatelessWidget {
  const ShowLimitOfPassCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: InkWell(
        onTap: () => yesNoAlert(
          context: context,
          title: "PASSを獲得しよう!",
          message:
              "\n・広告を見てPASSの期間を増やすことでチェックボックスのアイコンやカラーテーマを変更することができます!\n\n・1回の動画広告で3日分獲得できます",
          yesAction: () => TLAds.showRewardedAd(
            context: context,
            rewardAction: () {
              TLAds.extendLimitOfPassReward(howManyDays: 3);
              simpleAlert(
                  context: context,
                  title: "PASSが延長されました!",
                  message: "3日分のPASSを獲得しました",
                  buttonText: "OK");
              // ignore: invalid_use_of_protected_member
              setAppearancePageKey.currentState?.setState(() {});
            },
          ),
        ),
        child: Card(
          color: tlThemeDataList[SettingData.shared.selectedThemeIndex]!
              .settingPanelColor,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "PASSの期限",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: tlThemeDataList[
                                  SettingData.shared.selectedThemeIndex]!
                              .accentColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        TLAds.isPassActive
                            ? TLAds.limitOfPass
                            : "---- / -- / --",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
