import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:today_list/view/screen/setting_page/set_ios_widget_page/set_ios_widget_page.dart';
import 'package:today_list/view/component/common_ui_part/tl_sliver_appbar.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'set_features_page/set_appearance_page.dart';
import 'dart:io';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class SettingsPage extends HookWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TLThemeConfig tlThemeData = TLTheme.of(context);

    // MARK - Hooks for state management
    final selectedPageIndex = useState<int>(Platform.isIOS ? 1 : 0);
    final pageController =
        usePageController(initialPage: selectedPageIndex.value);

    final List<Widget> contentsInSettingPage = [
      if (Platform.isIOS) const SetIOSWidgetPage(),
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
        body: Stack(
          children: [
            Container(color: tlThemeData.backgroundColor),
            NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [_buildAppBar(context)];
              },
              body: _buildPageView(pageController, contentsInSettingPage),
            ),
            _buildBottomNavBar(context, tlThemeData, selectedPageIndex,
                pageController, iconDataOfSettingPageContents),
          ],
        ),
      ),
    );
  }

  // MARK - Build AppBar
  Widget _buildAppBar(BuildContext context) {
    return TLSliverAppBar(
      pageTitle: "Settings",
      leadingButtonOnPressed: () => Navigator.pop(context),
      leadingIcon: const Icon(Icons.arrow_back_ios, color: Colors.white),
      trailingButtonOnPressed: null,
      trailingIcon: null,
    );
  }

  // MARK - Build PageView
  Widget _buildPageView(PageController pageController, List<Widget> contents) {
    return PageView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => contents[index],
      itemCount: contents.length,
      controller: pageController,
    );
  }

  // MARK - Build Bottom Navigation Bar
  Widget _buildBottomNavBar(
    BuildContext context,
    TLThemeConfig tlThemeData,
    ValueNotifier<int> selectedPageIndex,
    PageController pageController,
    List<dynamic> iconDataOfSettingPageContents,
  ) {
    return Positioned(
      bottom: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: (100 * MediaQuery.of(context).size.height / 896),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 8)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (int index = 0;
                index < iconDataOfSettingPageContents.length;
                index++)
              _buildBottomNavItem(index, selectedPageIndex, pageController,
                  tlThemeData, iconDataOfSettingPageContents),
          ],
        ),
      ),
    );
  }

  // MARK - Build Navigation Item
  Widget _buildBottomNavItem(
    int index,
    ValueNotifier<int> selectedPageIndex,
    PageController pageController,
    TLThemeConfig tlThemeData,
    List<dynamic> iconDataOfSettingPageContents,
  ) {
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

  // MARK - Handle Navigation Item Tap
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
