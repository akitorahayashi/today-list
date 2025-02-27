import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/redux/action/tcw_action.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/view/component/common_ui_part/tl_double_card.dart';
import 'package:today_list/view/component/dialog/common/tl_single_option_dialog.dart';
import 'package:today_list/view/component/dialog/common/tl_yes_no_dialog.dart';
import 'package:today_list/view/page/setting_page/tcw_settings_page/tcw_card_list/component/wks_body_text.dart';
import 'package:today_list/view/page/setting_page/tcw_settings_page/tcw_card_list/component/wks_header.dart';
import 'package:today_list/model/settings_data/tcw_settings.dart';

class CardOfTCWSettings extends ConsumerWidget {
  final TCWSettings corrTCWSettings;

  const CardOfTCWSettings({super.key, required this.corrTCWSettings});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => TLYesNoDialog(
          title: corrTCWSettings.title,
          message: "Do you want to delete this setting?",
          yesAction: () {
            // MARK: 削除するか聞く
            Navigator.pop(context);
            ref.read(tlAppStateProvider.notifier).updateState(
                TCWSettingsAction.removeTCWSetting(id: corrTCWSettings.id));
            const TLSingleOptionDialog(
              title: "Successfully deleted!",
            ).show(context: context);
          }).show(context: context),
      child: TLDoubleCard(
        child: SizedBox(
          width: deviceWidth - 50,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  // MARK: Settings Name
                  child: Center(
                    child: Text(
                      corrTCWSettings.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.black45,
                      ),
                    ),
                  ),
                ),
                // MARK: Workspace
                const Padding(
                  padding: EdgeInsets.only(top: 12.0, bottom: .5),
                  child: TCWHeader(text: "Workspace"),
                ),
                TCWBodyText(text: corrTCWSettings.workspace.name),

                // MARK: Big Category
                if (corrTCWSettings.bigCategory != null) ...[
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0, bottom: .5),
                    child: TCWHeader(text: "Big Category"),
                  ),
                  TCWBodyText(text: corrTCWSettings.bigCategory!.name),
                ],

                // MARK: Small Category
                if (corrTCWSettings.smallCategory != null) ...[
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0, bottom: .5),
                    child: TCWHeader(text: "Small Category"),
                  ),
                  TCWBodyText(text: corrTCWSettings.smallCategory!.name),
                ],
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
