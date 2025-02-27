import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/settings_data/tcw_settings.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/view/page/setting_page/tcw_settings_page/tcw_card_list/tcw_card/card_of_tcw_settings.dart';

class CardListOfToDosInCategoryWidgetSettings extends ConsumerWidget {
  const CardListOfToDosInCategoryWidgetSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<TCWSettings> wksList =
        ref.watch(tlAppStateProvider.select((state) => state.tcwSettings));
    return Column(
      children: [
        for (int i = 0; i < wksList.length; i++)
          CardOfTCWSettings(
            key: ValueKey(wksList[i].id),
            corrTCWSettings: wksList[i],
          ),
      ],
    );
  }
}
