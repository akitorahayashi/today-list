import 'package:flutter/material.dart';
import '../../../component/dialog/common/tl_yes_no_dialog.dart';
import '../../../component/dialog/common/tl_single_option_dialog.dart';
import '../../../../service/tl_ads.dart';
import '../../../../model/design/tl_theme/tl_theme.dart';

class ShowLimitOfPassCard extends StatelessWidget {
  const ShowLimitOfPassCard({super.key});

  @override
  Widget build(BuildContext context) {
    final TLThemeConfig tlThemeData = TLTheme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: InkWell(
        onTap: () => showDialog(
          context: context,
          builder: (context) => TLYesNoDialog(
            title: "PASSを獲得しよう!",
            message:
                "\n・広告を見てPASSの期間を増やすことでチェックボックスのアイコンやカラーテーマを変更することができます!\n\n・1回の動画広告で3日分獲得できます",
            yesAction: () => TLAdsService.showRewardedAd(
              context: context,
              rewardAction: () {
                TLAdsService.extendLimitOfPassReward(howManyDays: 3);
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
          color: tlThemeData.settingPanelColor,
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
                          color: tlThemeData.accentColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        TLAdsService.isPassActive
                            ? TLAdsService.limitOfPass
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
