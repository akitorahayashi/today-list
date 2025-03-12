import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/flux/store/theme_store.dart';
import 'package:today_list/flux/store/user_data_store.dart';
import 'package:today_list/router/app_router.dart';
import 'package:today_list/view/component/common_ui_part/tl_loading_indicator.dart';
import 'model/design/tl_theme.dart';
import 'model/design/tl_theme_config.dart';

class TodayListApp extends ConsumerWidget {
  const TodayListApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeAsync = ref.watch(themeProvider);
    final userDataAsync = ref.watch(userDataProvider);
    final router = ref.watch(routerProvider);

    return themeAsync.when(
      data: (selectedThemeType) {
        return userDataAsync.when(
          data: (userData) {
            // カスタムアクセントカラーがある場合は適用
            TLThemeConfig themeConfig = selectedThemeType.config;
            if (userData.customAccentColorValue != null) {
              final customAccentColor = Color(userData.customAccentColorValue!);
              themeConfig = themeConfig.copyWithCustomAccentColor(
                customAccentColor,
              );
            }

            return AnimatedTLTheme(
              data: themeConfig,
              duration: const Duration(milliseconds: 300),
              child: MaterialApp.router(
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
                routerConfig: router,
              ),
            );
          },
          loading: () => const Scaffold(body: TLLoadingIndicator()),
          error:
              (error, stackTrace) => MaterialApp(
                debugShowCheckedModeBanner: false,
                home: Scaffold(
                  body: Center(child: Text('ユーザーデータの読み込みに失敗しました: $error')),
                ),
              ),
        );
      },
      loading:
          () => const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(body: TLLoadingIndicator()),
          ),
      error:
          (error, stackTrace) => MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(child: Text('テーマの読み込みに失敗しました: $error')),
            ),
          ),
    );
  }
}
