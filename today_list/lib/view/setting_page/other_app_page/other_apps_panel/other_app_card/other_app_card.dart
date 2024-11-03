import 'package:flutter/material.dart';
import '../../../../../model/design/tl_theme.dart';
import '../other_apps_model.dart';
import './button_of_other_app_card.dart';

class NiceAppCard extends StatelessWidget {
  final bool isCurrentApp;
  final NiceApp niceAppOfThisCard;
  const NiceAppCard({
    super.key,
    required this.isCurrentApp,
    required this.niceAppOfThisCard,
  });

  @override
  Widget build(BuildContext context) {
    final TLThemeData _tlThemeData = TLTheme.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8.0, bottom: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Card(
          elevation: 3.5,
          child: DecoratedBox(
            decoration: BoxDecoration(
                border: Border.all(
                    color: _tlThemeData.niceAppsCardColor, width: 10)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 12, 5, 5),
              child: Column(
                children: [
                  // キャッチコピー
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          niceAppOfThisCard.catchCopy,
                          style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 3,
                              color: _tlThemeData.niceAppsCardColor),
                        )),
                  ),
                  // アイコンとアプリ名
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // アイコン
                        Padding(
                          padding: const EdgeInsets.only(left: 28.0, right: 15),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    width: 10,
                                    color: _tlThemeData.niceAppsCardColor
                                        .withOpacity(0.2))),
                            child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                        niceAppOfThisCard.appIconPath))),
                          ),
                        ),
                        // アプリ名
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            niceAppOfThisCard.appName,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: _tlThemeData.niceAppsCardColor,
                                fontSize: 30),
                          ),
                        )
                      ],
                    ),
                  ),
                  // ストアに飛ぶボタン
                  OverflowBar(
                    alignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ButtonInNiceAppCard(
                        isCurrentApp: isCurrentApp,
                        isStoreUrl: false,
                        niceAppInThisCard: niceAppOfThisCard,
                      ),
                      ButtonInNiceAppCard(
                        isCurrentApp: isCurrentApp,
                        isStoreUrl: true,
                        niceAppInThisCard: niceAppOfThisCard,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
