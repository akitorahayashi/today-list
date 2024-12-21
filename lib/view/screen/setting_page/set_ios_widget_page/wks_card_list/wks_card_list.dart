import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/setting_data/widget_kit_setting.dart';
import 'package:today_list/view_model/settings/wks_provider.dart';
import 'package:today_list/view/screen/setting_page/set_ios_widget_page/wks_card_list/wks_card/wks_card.dart';

class WKSCardList extends ConsumerWidget {
  const WKSCardList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<WidgetKitSetting> wksList = ref.watch(widgetKitSettingsProvider);
    return Column(
      children: [
        for (int i = 0; i < wksList.length; i++)
          WKSCard(
            key: ValueKey(wksList[i].id),
            idx: i,
          ),
      ],
    );
  }
}
