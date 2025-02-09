import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/settings_data/todos_in_category_widget_settings.dart';
import 'package:today_list/view_model/settings/wks_provider.dart';
import 'package:today_list/view/screen/setting_page/set_ios_widget_page/wks_card_list/wks_card/card_of_todos_in_category_settings.dart';

class CardListOfToDosInCategoryWidgetSettings extends ConsumerWidget {
  const CardListOfToDosInCategoryWidgetSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<ToDosInCategoryWidgetSettings> wksList =
        ref.watch(widgetKitSettingsProvider);
    return Column(
      children: [
        for (int i = 0; i < wksList.length; i++)
          CardOfToDosInCategoryWidgetSettings(
            key: ValueKey(wksList[i].id),
            corrToDosInCategoryWidgetSettings: wksList[i],
          ),
      ],
    );
  }
}
