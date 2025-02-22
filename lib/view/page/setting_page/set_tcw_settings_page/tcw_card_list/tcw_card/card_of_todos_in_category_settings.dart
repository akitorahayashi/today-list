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
        color: tlThemeConfig.whiteBasedColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          width: deviceWidth - 50,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SlidableForTCWCard(
              corrTCWSettingsID: corrToDosInCategoryWidgetSettings.id,
              child: _CardContent(
                theme: tlThemeConfig,
                deviceWidth: deviceWidth,
                corrToDosInCategoryWidgetSettings:
                    corrToDosInCategoryWidgetSettings,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// MARK: - カードのコンテンツ
class _CardContent extends StatelessWidget {
  final TLThemeConfig theme;
  final double deviceWidth;
  final ToDosInCategoryWidgetSettings corrToDosInCategoryWidgetSettings;

  const _CardContent({
    required this.theme,
    required this.deviceWidth,
    required this.corrToDosInCategoryWidgetSettings,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: theme.whiteBasedColor,
        borderRadius: BorderRadius.circular(16),
      ),
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
        const Padding(
          padding: EdgeInsets.only(top: 4.0),
          child: TCWHeader(text: "Big Category"),
        ),
        TCWBodyText(text: corrToDosInCategoryWidgetSettings.bigCategory.name),

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
