import 'package:flutter/material.dart';
import '../../../components/dialog/common/tl_yes_no_dialog.dart';
import '../../../components/dialog/common/tl_single_option_dialog.dart';
import '../../../model/external/tl_ads.dart';
import '../../../model/design/tl_theme.dart';

class ShowLimitOfPassCard extends StatelessWidget {
  const ShowLimitOfPassCard({super.key});

  @override
  Widget build(BuildContext context) {
    final TLThemeData _tlThemeData = TLTheme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: InkWell(
        onTap: () => showDialog(
          context: context,
          builder: (context) => TLYesNoDialog(
            title: "PASSを獲得しよう!",
            message:
                "\n・広告を見てPASSの期間を増やすことでチェックボックスのアイコンやカラーテーマを変更することができます!\n\n・1回の動画広告で3日分獲得できます",
            yesAction: () => TLAds.showRewardedAd(
              context: context,
              rewardAction: () {
                TLAds.extendLimitOfPassReward(howManyDays: 3);
                showDialog(
                  context: context,
                  builder: ((context) => TLSingleOptionDialog(
                        title: "PASSが延長されました!",
                        message: "3日分のPASSを獲得しました",
                      )),
                );
              },
            ),
          ),
        ),
        child: Card(
          color: _tlThemeData.settingPanelColor,
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
                          color: _tlThemeData.accentColor,
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
