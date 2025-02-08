import 'package:flutter/material.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:today_list/service/tl_vibration.dart';

class SetVibrationCard extends StatefulWidget {
  const SetVibrationCard({super.key});

  @override
  State<SetVibrationCard> createState() => _SetVibrationCardState();
}

class _SetVibrationCardState extends State<SetVibrationCard> {
  @override
  Widget build(BuildContext context) {
    final TLThemeConfig tlThemeConfig = TLTheme.of(context);
    final double deviceWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: deviceWidth,
      height: 100,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: Text(
                    "なし",
                    style: TextStyle(
                      color: Colors.black45,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 25.0),
                  child: Text(
                    "最大",
                    style: TextStyle(
                      color: Colors.black45,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 強さを調節するスライダー
          Slider(
            min: 0,
            max: 4,
            divisions: 4,
            activeColor: tlThemeConfig.accentColor,
            value: TLVibrationService.vibrationStrength,
            onChanged: (sliderValue) {
              TLVibrationService.vibrationStrength = sliderValue;
              setState(() {});
            },
            onChangeEnd: (sliderValue) {
              TLVibrationService.vibrate();
              TLVibrationService.saveVibrationStrength();
            },
          ),
        ],
      ),
    );
  }
}
