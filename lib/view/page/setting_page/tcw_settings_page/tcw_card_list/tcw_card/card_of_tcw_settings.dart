import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/view/component/common_ui_part/tl_double_card.dart';
import 'package:today_list/view/component/dialog/common/tl_single_option_dialog.dart';
import 'package:today_list/view/component/dialog/common/tl_yes_no_dialog.dart';
import 'package:today_list/view/page/setting_page/tcw_settings_page/tcw_card_list/component/wks_body_text.dart';
import 'package:today_list/view/page/setting_page/tcw_settings_page/tcw_card_list/component/wks_header.dart';
import 'package:today_list/model/settings_data/todos_in_category_widget_settings.dart';
import 'package:today_list/view_model/settings/tcw_provider.dart';

class CardOfTCWSettings extends ConsumerWidget {
  final ToDosInCategoryWidgetSettings corrToDosInCategoryWidgetSettings;

  const CardOfTCWSettings(
      {super.key, required this.corrToDosInCategoryWidgetSettings});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => TLYesNoDialog(
          title: corrToDosInCategoryWidgetSettings.title,
          message: "Do you want to delete this setting?",
          yesAction: () {
            Navigator.pop(context);
            ref
                .read(toDosInCategoryWidgetSettingsProvider.notifier)
                .removeToDosInCategoryWidgetSettings(
                    id: corrToDosInCategoryWidgetSettings.id);
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
                _Title(
                    corrToDosInCategoryWidgetSettings:
                        corrToDosInCategoryWidgetSettings),
                _CategoryInfo(
                    corrToDosInCategoryWidgetSettings:
                        corrToDosInCategoryWidgetSettings),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// MARK: - タイトル
class _Title extends StatelessWidget {
  final ToDosInCategoryWidgetSettings corrToDosInCategoryWidgetSettings;

  const _Title({required this.corrToDosInCategoryWidgetSettings});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Text(
          corrToDosInCategoryWidgetSettings.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.black45,
          ),
        ),
      ),
    );
  }
}

// MARK: - カテゴリ情報
class _CategoryInfo extends StatelessWidget {
  final ToDosInCategoryWidgetSettings corrToDosInCategoryWidgetSettings;

  const _CategoryInfo({required this.corrToDosInCategoryWidgetSettings});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Workspace
        const Padding(
          padding: EdgeInsets.only(top: 4.0),
          child: TCWHeader(text: "Workspace"),
        ),
        TCWBodyText(text: corrToDosInCategoryWidgetSettings.workspace.name),

        // Big Category
        if (corrToDosInCategoryWidgetSettings.bigCategory != null) ...[
          const Padding(
            padding: EdgeInsets.only(top: 4.0),
            child: TCWHeader(text: "Big Category"),
          ),
          TCWBodyText(
              text: corrToDosInCategoryWidgetSettings.bigCategory!.name),
        ],

        // Small Category（存在する場合のみ）
        if (corrToDosInCategoryWidgetSettings.smallCategory != null) ...[
          const Padding(
            padding: EdgeInsets.only(top: 4.0),
            child: TCWHeader(text: "Small Category"),
          ),
          TCWBodyText(
              text: corrToDosInCategoryWidgetSettings.smallCategory!.name),
        ],
      ],
    );
  }
}
