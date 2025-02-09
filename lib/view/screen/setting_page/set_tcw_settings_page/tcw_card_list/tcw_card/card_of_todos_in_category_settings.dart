import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/view/screen/setting_page/set_tcw_settings_page/component/wks_body_text.dart';
import 'package:today_list/view/screen/setting_page/set_tcw_settings_page/component/wks_header.dart';
import 'package:today_list/view/component/common_ui_part/tl_double_card.dart';
import 'package:today_list/view/component/slidable/slidable_for_tcw_card.dart';
import 'package:today_list/model/settings_data/todos_in_category_widget_settings.dart';
import 'package:today_list/model/todo/tl_category.dart';
import 'package:today_list/view_model/settings/tcw_provider.dart';
// import 'package:today_list/view/setting_page/set_ios_widget_page/wks_card_list/wks_card/medium_ios_widget_replica.dart';

class CardOfToDosInCategoryWidgetSettings extends ConsumerWidget {
  final ToDosInCategoryWidgetSettings corrToDosInCategoryWidgetSettings;
  const CardOfToDosInCategoryWidgetSettings(
      {super.key, required this.corrToDosInCategoryWidgetSettings});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceWidth = MediaQuery.of(context).size.width;
    // provider
    final tlAppState = ref.watch(tlAppStateProvider).tlWorkspaces;
    return SlidableForTCWCard(
      corrTCWSettingsID: corrToDosInCategoryWidgetSettings.id,
      child: TLDoubleCard(
        child: SizedBox(
          width: deviceWidth - 50,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // タイトル
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      corrToDosInCategoryWidgetSettings.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.black45),
                    ),
                  ),
                ),
                //  Workspace
                const Padding(
                  padding: EdgeInsets.only(top: 4.0),
                  child: WKSHeader(text: "Workspace"),
                ),
                WKSBodyText(
                  text: corrToDosInCategoryWidgetSettings.workspace.name,
                ),
                // Big category
                const Padding(
                  padding: EdgeInsets.only(top: 4.0),
                  child: WKSHeader(text: "Big Category"),
                ),
                WKSBodyText(
                  text: corrToDosInCategoryWidgetSettings.bigCategory.title,
                ),
                // Small category
                if (corrToDosInCategoryWidgetSettings.smallCategory !=
                    null) ...[
                  const Padding(
                    padding: EdgeInsets.only(top: 4.0),
                    child: WKSHeader(text: "Small Category"),
                  ),
                  WKSBodyText(
                    text:
                        corrToDosInCategoryWidgetSettings.smallCategory!.title,
                  ),
                ],
                // Center(
                //   child: const Padding(
                //     padding: EdgeInsets.only(top: 8.0),
                //     child: MediumiOSWidgetReplica(),
                //   ),
                // ),
                // 下の余白
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
