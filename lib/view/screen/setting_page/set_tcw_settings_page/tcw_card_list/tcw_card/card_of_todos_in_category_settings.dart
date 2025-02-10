import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:today_list/view/screen/setting_page/set_tcw_settings_page/tcw_card_list/component/wks_body_text.dart';
import 'package:today_list/view/screen/setting_page/set_tcw_settings_page/tcw_card_list/component/wks_header.dart';
import 'package:today_list/view/component/slidable/slidable_for_tcw_card.dart';
import 'package:today_list/model/settings_data/todos_in_category_widget_settings.dart';

// MARK: - 設定カードウィジェット
class CardOfToDosInCategoryWidgetSettings extends ConsumerWidget {
  final ToDosInCategoryWidgetSettings corrToDosInCategoryWidgetSettings;

  const CardOfToDosInCategoryWidgetSettings(
      {super.key, required this.corrToDosInCategoryWidgetSettings});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeConfig tlThemeConfig = TLTheme.of(context);
    final deviceWidth = MediaQuery.of(context).size.width;

    return Card(
      color: tlThemeConfig.tlDoubleCardBorderColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Card(
        color: tlThemeConfig.whiteBasedCardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          width: deviceWidth - 50,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SlidableForTCWCard(
              corrTCWSettingsID: corrToDosInCategoryWidgetSettings.id,
              child: _buildCardContent(tlThemeConfig, deviceWidth),
            ),
          ),
        ),
      ),
    );
  }

  // MARK: - カードのコンテンツ
  Widget _buildCardContent(TLThemeConfig theme, double deviceWidth) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: theme.whiteBasedCardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(),
            _buildCategoryInfo(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // MARK: - タイトル
  Widget _buildTitle() {
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

  // MARK: - カテゴリ情報
  Widget _buildCategoryInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Workspace
        const Padding(
          padding: EdgeInsets.only(top: 4.0),
          child: WKSHeader(text: "Workspace"),
        ),
        WKSBodyText(text: corrToDosInCategoryWidgetSettings.workspace.name),

        // Big Category
        const Padding(
          padding: EdgeInsets.only(top: 4.0),
          child: WKSHeader(text: "Big Category"),
        ),
        WKSBodyText(text: corrToDosInCategoryWidgetSettings.bigCategory.title),

        // Small Category（存在する場合のみ）
        if (corrToDosInCategoryWidgetSettings.smallCategory != null) ...[
          const Padding(
            padding: EdgeInsets.only(top: 4.0),
            child: WKSHeader(text: "Small Category"),
          ),
          WKSBodyText(
              text: corrToDosInCategoryWidgetSettings.smallCategory!.title),
        ],
      ],
    );
  }
}
