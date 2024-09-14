import 'package:flutter/material.dart';
import '../../../constants/theme.dart';
import '../../../model/user/setting_data.dart';
import '../../../model/externals/tl_vibration.dart';

class SetVibrationCard extends StatefulWidget {
  const SetVibrationCard({super.key});

  @override
  State<SetVibrationCard> createState() => _SetVibrationCardState();
}

class _SetVibrationCardState extends State<SetVibrationCard> {
  @override
  Widget build(BuildContext context) {
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
            activeColor: theme[settingData.selectedTheme]!.accentColor,
            value: TLVibration.vibrationStrength,
            onChanged: (sliderValue) {
              TLVibration.vibrationStrength = sliderValue;
              setState(() {});
            },
            onChangeEnd: (sliderValue) {
              TLVibration.vibrate();
              TLVibration.saveVibrationStrength();
            },
          ),
        ],
      ),
    );
  }
}
