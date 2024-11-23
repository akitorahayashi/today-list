import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/component/common_ui_part/tl_double_card.dart';
import 'package:today_list/model/widget_kit_setting/widget_kit_setting.dart';
import 'package:today_list/model/widget_kit_setting/wks_provider.dart';
import 'package:today_list/model/workspace/provider/tl_workspaces_provider.dart';
import 'package:today_list/view/setting_page/set_ios_widget_page/component/wks_body_text.dart';
import 'package:today_list/view/setting_page/set_ios_widget_page/component/wks_header.dart';
import 'package:today_list/view/setting_page/set_ios_widget_page/wks_card_list/wks_card/ios_widget_replica.dart';

class WKSCard extends ConsumerWidget {
  final int idx;
  const WKSCard({super.key, required this.idx});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // provider
    final tlWorkspace = ref.watch(tlWorkspacesProvider);
    final wksList = ref.watch(widgetKitSettingsProvider);
    final WidgetKitSetting wksInThisCard = wksList[idx];
    final deviceWidth = MediaQuery.of(context).size.width;
    return TlDoubleCard(
      child: SizedBox(
        width: deviceWidth - 50,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 何番目のWidgetか
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    "Widget ${idx + 1}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.black45),
                  ),
                ),
              ),
              // Title
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: WKSHeader(text: "Title"),
              ),
              WKSBodyText(text: wksInThisCard.title),
              //  Workspace
              const Padding(
                padding: EdgeInsets.only(top: 4.0),
                child: WKSHeader(text: "Workspace"),
              ),
              WKSBodyText(
                text: tlWorkspace[wksInThisCard.workspaceIdx].name,
              ),
              // Big category
              const Padding(
                padding: EdgeInsets.only(top: 4.0),
                child: WKSHeader(text: "Big Category"),
              ),
              WKSBodyText(
                text: wksInThisCard.selectedBigCategory.title,
              ),
              // Small category
              if (wksInThisCard.selectedSmallCategory != null) ...[
                const Padding(
                  padding: EdgeInsets.only(top: 4.0),
                  child: WKSHeader(text: "Small Category"),
                ),
                WKSBodyText(
                  text: wksInThisCard.selectedSmallCategory!.title,
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
    );
  }
}
