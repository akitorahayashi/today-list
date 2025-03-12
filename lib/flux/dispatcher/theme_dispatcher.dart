import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/flux/action/theme_action.dart';
import 'package:today_list/flux/store/theme_store.dart';

/// テーマ関連のディスパッチャー
class ThemeDispatcher {
  /// テーマ関連のアクションをディスパッチします
  static Future<void> dispatch(WidgetRef ref, ThemeAction action) async {
    await action.map(
      changeTheme: (action) async {
        await ref.read(themeProvider.notifier).changeTheme(action.newThemeType);
      },
      changeAccentColor: (action) async {
        await ref
            .read(themeProvider.notifier)
            .changeAccentColor(action.newAccentColor);
      },
    );
  }
}
