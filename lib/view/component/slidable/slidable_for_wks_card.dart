import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/external/tl_vibration.dart';
import 'package:today_list/view_model/settings/wks_provider.dart';
import '../../../model/tl_theme.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableForWKSCard extends ConsumerWidget {
  final int indexInWKSList;
  final Widget child;
  const SlidableForWKSCard({
    super.key,
    required this.indexInWKSList,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeData tlThemeData = TLTheme.of(context);
    final WidgetKitSettingNotifier wksNotifier =
        ref.read(widgetKitSettingsProvider.notifier);
    return Slidable(
      endActionPane: // デフォルトワークスペースの時は編集できないようにする
          indexInWKSList == 0
              ? null
              : ActionPane(
                  motion: const ScrollMotion(),
                  extentRatio: 0.35,
                  children: [
                    // For deleting wks
                    SlidableAction(
                      autoClose: true,
                      spacing: 8,
                      backgroundColor: tlThemeData.backgroundColor,
                      foregroundColor: tlThemeData.accentColor,
                      onPressed: (BuildContext context) async {
                        wksNotifier.removeWidgetKitSettings(
                            index: indexInWKSList);
                        TLVibration.vibrate();
                      },
                      icon: Icons.remove,
                      label: "Remove",
                    ),
                  ],
                ),
      child: Center(child: child),
    );
  }
}
