import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:today_list/view/screen/setting_page/set_tcw_settings_page/set_tcw_page.dart';
import 'package:today_list/view/component/common_ui_part/tl_appbar.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'set_features_page/set_appearance_page.dart';
import 'dart:io';

import 'package:flutter_progress_hud/flutter_progress_hud.dart';

// MARK: - SettingsPage
class SettingsPage extends HookWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TLThemeConfig tlThemeData = TLTheme.of(context);

    // MARK: - Hooks for state management
    final selectedPageIndex = useState<int>(Platform.isIOS ? 1 : 0);
    final pageController =
        usePageController(initialPage: selectedPageIndex.value);
    final showBottomNavBar = useState<bool>(true);

    final List<Widget> contentsInSettingPage = [
      if (Platform.isIOS) SetTCWPage(showBottomNavBar: showBottomNavBar),
      const SetAppearancePage(),
    ];

    final List<dynamic> iconDataOfSettingPageContents = [
      [Icons.widgets, "Widgets"],
      [Icons.phone_android, "Features"],
    ];

    return ProgressHUD(
      barrierEnabled: true,
      indicatorColor: Colors.white,
      textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        decoration: TextDecoration.none,
      ),
      child: Scaffold(
        appBar: _AppBar(),
        body: Stack(
          children: [
            Container(color: tlThemeData.backgroundColor),
            _PageViewWidget(
                pageController: pageController,
                contents: contentsInSettingPage),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: showBottomNavBar.value
                  ? Align(
                      alignment: Alignment.bottomCenter,
                      child: _BottomNavBar(
                        tlThemeConfig: tlThemeData,
                        selectedPageIndex: selectedPageIndex,
                        pageController: pageController,
                        iconDataOfSettingPageContents:
                            iconDataOfSettingPageContents,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}

// MARK: - AppBar Widget
class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return TLAppBar(
      context: context,
      pageTitle: "Settings",
      leadingButtonOnPressed: () => Navigator.pop(context),
      leadingIcon: const Icon(Icons.arrow_back_ios, color: Colors.white),
      trailingButtonOnPressed: null,
      trailingIcon: null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// MARK: - PageView Widget
class _PageViewWidget extends StatelessWidget {
  final PageController pageController;
  final List<Widget> contents;

  const _PageViewWidget({
    required this.pageController,
    required this.contents,
  });

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => contents[index],
      itemCount: contents.length,
      controller: pageController,
    );
  }
}

// MARK: - Bottom Navigation Bar Widget
class _BottomNavBar extends StatelessWidget {
  final TLThemeConfig tlThemeConfig;
  final ValueNotifier<int> selectedPageIndex;
  final PageController pageController;
  final List<dynamic> iconDataOfSettingPageContents;

  const _BottomNavBar({
    required this.tlThemeConfig,
    required this.selectedPageIndex,
    required this.pageController,
    required this.iconDataOfSettingPageContents,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: (100 * MediaQuery.of(context).size.height / 896),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: tlThemeConfig.whiteBasedColor,
            boxShadow: const [BoxShadow(color: Colors.black45, blurRadius: 8)],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (int index = 0;
                  index < iconDataOfSettingPageContents.length;
                  index++)
                _BottomNavItem(
                  index: index,
                  selectedPageIndex: selectedPageIndex,
                  pageController: pageController,
                  tlThemeData: tlThemeConfig,
                  iconDataOfSettingPageContents: iconDataOfSettingPageContents,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// MARK: - Bottom Navigation Item Widget
class _BottomNavItem extends StatelessWidget {
  final int index;
  final ValueNotifier<int> selectedPageIndex;
  final PageController pageController;
  final TLThemeConfig tlThemeData;
  final List<dynamic> iconDataOfSettingPageContents;

  const _BottomNavItem({
    required this.index,
    required this.selectedPageIndex,
    required this.pageController,
    required this.tlThemeData,
    required this.iconDataOfSettingPageContents,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          _onBottomNavItemTapped(index, selectedPageIndex, pageController),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconDataOfSettingPageContents[index][0],
            color: index == selectedPageIndex.value
                ? tlThemeData.accentColor
                : Colors.black45,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 11.0),
            child: Text(
              iconDataOfSettingPageContents[index][1],
              style: TextStyle(
                color: index == selectedPageIndex.value
                    ? tlThemeData.accentColor
                    : Colors.black45,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onBottomNavItemTapped(int index, ValueNotifier<int> selectedPageIndex,
      PageController pageController) {
    if (selectedPageIndex.value != index) {
      selectedPageIndex.value = index;
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 400),
        curve: Curves.decelerate,
      );
    }
  }
}
