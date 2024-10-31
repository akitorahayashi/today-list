import 'package:flutter/material.dart';
import 'model/user/setting_data.dart';
import 'view/home_page/home_page.dart';
import 'model/tl_theme.dart';

// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';

class TodayListApp extends StatefulWidget {
  const TodayListApp({Key? key}) : super(key: key);

  @override
  State<TodayListApp> createState() => _TodayListAppState();
}

class _TodayListAppState extends State<TodayListApp> {
  @override
  Widget build(BuildContext context) {
    return TLTheme(
      data: tlThemeDataList[SettingData.shared.selectedThemeIndex],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Today List",
          // ライト用テーマ
          theme: ThemeData(
            primarySwatch:
                tlThemeDataList[SettingData.shared.selectedThemeIndex]
                    .accentColor,
          ),
          home: HomePage()),
    );
  }
}
