import 'package:flutter/material.dart';
import 'model/user/setting_data.dart';
import 'view/home_page/home_page.dart';
import './constants/global_keys.dart';
import './constants/theme.dart';

// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';

class TodayList extends StatefulWidget {
  const TodayList({required Key key}) : super(key: key);

  @override
  State<TodayList> createState() => _TodayListState();
}

class _TodayListState extends State<TodayList> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Today List",
        localizationsDelegates: const [
          // GlobalMaterialLocalizations.delegate,
          // GlobalWidgetsLocalizations.delegate,
          // GlobalCupertinoLocalizations.delegate,
        ],
        // supportedLocales: const [
        //   Locale('ja', ''), //日本語
        //   Locale('en', ''), //英語
        // ],
        // ライト用テーマ
        theme: ThemeData(
          primarySwatch: theme[settingData.selectedTheme]!.accentColor,
        ),
        home: HomePage(key: homePageKey)
        // FutureBuilder(
        //   future: todayListUser.initializeFirebase(),
        //   builder: (context, snapshot) {
        //     if (snapshot.hasError) {
        //       // スプラッシュ画面を閉じる
        //       FlutterNativeSplash.remove();
        //       return const ErrorPage();
        //     } else if (snapshot.hasData) {
        //       return HomePage(key: homePageKey);
        //     } else {
        //       return Container();
        //     }
        //   },
        // ),
        );
  }
}
