import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:reorderables/reorderables.dart';
import 'package:today_list/model/widget_kit_setting/widget_kit_setting.dart';
import 'package:today_list/model/widget_kit_setting/wks_provider.dart';
import 'package:today_list/view/setting_page/set_ios_widget_page/wks_card_list/wks_card.dart';

class WKSCardList extends ConsumerWidget {
  const WKSCardList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<WidgetKitSetting> wksList = ref.watch(widgetKitSettingsProvider);
    return ReorderableColumn(
      children: [
        for (WidgetKitSetting w in wksList)
          WKSCard(
            key: ValueKey(w.id),
          ),
      ],
      onReorder: (oldIndex, newIndex) {
        reorderのチェック
        if (oldIndex < newIndex) {
          newIndex -= 1;
        }
        final WidgetKitSetting item = wksList.removeAt(oldIndex);
        wksList.insert(newIndex, item);
      },
    );
  }
}
