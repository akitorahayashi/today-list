import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/settings_data/tl_user_data.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/resource/tl_theme_type.dart';
import 'view/page/home_page/home_page.dart';
import 'model/design/tl_theme.dart';
import 'model/design/tl_theme_config.dart';

class TodayListApp extends ConsumerWidget {
  const TodayListApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeType selectedThemeType = ref
        .watch(tlAppStateProvider.select((state) => state.selectedThemeType));

    // ユーザーデータからカスタムアクセントカラーを取得
    final TLUserData userData =
        ref.watch(tlAppStateProvider.select((state) => state.tlUserData));

    // カスタムアクセントカラーがある場合は適用
    TLThemeConfig themeConfig = selectedThemeType.config;
    if (userData.customAccentColorValue != null) {
      final customAccentColor = Color(userData.customAccentColorValue!);
      themeConfig = themeConfig.copyWithCustomAccentColor(customAccentColor);
    }

    // final Brightness brightness = MediaQuery.of(context).platformBrightness;
    // final bool isDarkMode = brightness == Brightness.dark;

    return AnimatedTLTheme(
      data: themeConfig,
      duration: const Duration(milliseconds: 300),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Today List",
        theme: ThemeData(
          useMaterial3: true,
          primaryColor: themeConfig.accentColor,
          colorScheme: ColorScheme.fromSeed(
            primary: themeConfig.accentColor,
            seedColor: themeConfig.accentColor,
          ),
          splashFactory: NoSplash.splashFactory,
        ),
        home: HomePage(),
      ),
    );
  }
}
