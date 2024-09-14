import 'package:flutter/material.dart';
import './sign_in_card/sign_in_card.dart';

class MyPage extends StatefulWidget {
  const MyPage({required Key key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: const [
        SizedBox(height: 10),
        // ignore: prefer_const_constructors
        // ShowLevelPanel(),
        // ignore: prefer_const_constructors
        // ShowLogInStatusPanel(),
        SignInCard(),
        // Card(
        //   color: theme[settingData.selectedTheme]!.settingPanelColor,
        //   shape:
        //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        //   child: AnimatedCrossFade(
        //       duration: const Duration(milliseconds: 600),
        //       crossFadeState: todayListUser.accontSignedInWithGoogle == null
        //           ? CrossFadeState.showFirst
        //           : CrossFadeState.showSecond,
        //       // ignore: prefer_const_constructors
        //       firstChild: SignInCard(),
        //       // ignore: prefer_const_constructors
        //       secondChild: UserIntroductionCard()),
        // ),
        // SelectTipsPanel(),
        SizedBox(height: 250)
      ],
    );
  }
}
