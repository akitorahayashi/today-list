import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/resource/tl_theme_type.dart';
import 'view/screen/home_page/home_page.dart';
import 'model/design/tl_theme/tl_theme.dart';

class TodayListApp extends ConsumerWidget {
  const TodayListApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeType selectedThemeType = ref
        .watch(tlAppStateProvider.select((state) => state.selectedThemeType));

    // final Brightness brightness = MediaQuery.of(context).platformBrightness;
    // final bool isDarkMode = brightness == Brightness.dark;

    return TLTheme(
      data:
          // isDarkMode ? selectedThemeType.darkConfig :
          selectedThemeType.config,
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Today List",
        home: HomePage(),
      ),
    );
  }
}
