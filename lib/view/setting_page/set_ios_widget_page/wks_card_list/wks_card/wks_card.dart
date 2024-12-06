import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/setting_data/widget_kit_setting.dart';
import 'package:today_list/view/component/common_ui_part/tl_double_card.dart';
import 'package:today_list/view/component/slidable/slidable_for_wks_card.dart';
import 'package:today_list/model/todo/tl_category.dart';
import 'package:today_list/view_model/settings/wks_provider.dart';
import 'package:today_list/view_model/todo/tl_workspaces_state.dart';
import 'package:today_list/view/setting_page/set_ios_widget_page/component/wks_body_text.dart';
import 'package:today_list/view/setting_page/set_ios_widget_page/component/wks_header.dart';
// import 'package:today_list/view/setting_page/set_ios_widget_page/wks_card_list/wks_card/medium_ios_widget_replica.dart';

class WKSCard extends ConsumerWidget {
  final int idx;
  const WKSCard({super.key, required this.idx});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // provider
    final tlWorkspaces = ref.watch(tlWorkspacesStateProvider).tlWorkspaces;
    final wksList = ref.watch(widgetKitSettingsProvider);
    final WidgetKitSetting wksInThisCard = wksList[idx];
    final deviceWidth = MediaQuery.of(context).size.width;
    final TLCategory bc = tlWorkspaces[wksInThisCard.workspaceIdx]
        .bigCategories[wksInThisCard.bcIdx];
    return SlidableForWKSCard(
      indexInWKSList: idx,
      child: TlDoubleCard(
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
                      wksInThisCard.title,
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
                  text: tlWorkspaces[wksInThisCard.workspaceIdx].name,
                ),
                // Big category
                const Padding(
                  padding: EdgeInsets.only(top: 4.0),
                  child: WKSHeader(text: "Big Category"),
                ),
                WKSBodyText(
                  text: bc.title,
                ),
                // Small category
                if (wksInThisCard.scIdx != null) ...[
                  const Padding(
                    padding: EdgeInsets.only(top: 4.0),
                    child: WKSHeader(text: "Small Category"),
                  ),
                  WKSBodyText(
                    text: tlWorkspaces[wksInThisCard.workspaceIdx]
                        .smallCategories[bc.id]![wksInThisCard.scIdx!]
                        .title,
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
