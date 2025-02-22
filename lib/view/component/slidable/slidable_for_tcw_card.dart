import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:today_list/model/tl_app_state.dart';
import 'package:today_list/service/tl_vibration.dart';
import 'package:today_list/view_model/settings/tcw_provider.dart';
import '../../../model/design/tl_theme/tl_theme.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableForTCWCard extends ConsumerWidget {
  final String corrTCWSettingsID;
  final Widget child;
  const SlidableForTCWCard({
    super.key,
    required this.corrTCWSettingsID,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeConfig tlThemeData = TLTheme.of(context);
    final ToDosInCategoryWidgetSettingNotifier wksNotifier =
        ref.read(toDosInCategoryWidgetSettingsProvider.notifier);

    // MARK: - Colors
    final backgroundColor = tlThemeData.whiteBasedColor;
    final foregroundColor = tlThemeData.accentColor;

    return Slidable(
      endActionPane: // デフォルトワークスペースの時は編集できないようにする
          corrTCWSettingsID == noneID
              ? null
              : ActionPane(
                  motion: const ScrollMotion(),
                  extentRatio: 0.3,
                  children: [
                    // For deleting wks
                    SlidableAction(
                      autoClose: true,
                      backgroundColor: backgroundColor,
                      foregroundColor: foregroundColor,
                      onPressed: (BuildContext context) async {
                        wksNotifier.removeToDosInCategoryWidgetSettings(
                            id: corrTCWSettingsID);
                        TLVibrationService.vibrate();
                      },
                      icon: Icons.remove,
                      label: "Delete",
                    ),
                  ],
                ),
      child: Center(child: child),
    );
  }
}
