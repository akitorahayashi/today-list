import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:today_list/model/design/tl_theme_config.dart';
import 'package:today_list/view/component/common_ui_part/tl_appbar.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'set_features_page/set_features_page.dart';

// MARK: - SettingsPage
class SettingsPage extends HookWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TLThemeConfig tlThemeConfig = TLTheme.of(context);

    // MARK: - Hooks for state management
    final selectedPageIndex = useState<int>(0);
    final pageController =
        usePageController(initialPage: selectedPageIndex.value);
    final showBottomNavBar = useState<bool>(true);

    final List<Widget> contentsInSettingPage = [
      const SetFeaturesPage(),
    ];

    final List<dynamic> iconDataOfSettingPageContents = [
      [Icons.phone_android, "Features"],
    ];

    return Scaffold(
      appBar: _AppBar(),
      body: Stack(
        children: [
          Container(color: tlThemeConfig.backgroundColor),
          PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => contentsInSettingPage[index],
            itemCount: contentsInSettingPage.length,
            controller: pageController,
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: showBottomNavBar.value
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: _BottomNavBar(
                      tlThemeConfig: tlThemeConfig,
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
      leadingIconData: Icons.arrow_back_ios,
      trailingButtonOnPressed: null,
      trailingIconData: null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
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
    final double navBarHeight = 100 * MediaQuery.of(context).size.height / 896;

    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: navBarHeight,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: tlThemeConfig.whiteBasedColor,
            boxShadow: const [BoxShadow(color: Colors.black45, blurRadius: 8)],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              iconDataOfSettingPageContents.length,
              (index) => _BottomNavItem(
                index: index,
                selectedPageIndex: selectedPageIndex,
                pageController: pageController,
                tlThemeData: tlThemeConfig,
                iconDataOfSettingPageContents: iconDataOfSettingPageContents,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// MARK: - Bottom Navigation Item Widget
class _BottomNavItem extends HookWidget {
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
    final isPressed = useState(false);

    return GestureDetector(
      onTapDown: (_) => isPressed.value = true,
      onTapUp: (_) => isPressed.value = false,
      onTapCancel: () => isPressed.value = false,
      onTap: () =>
          _onBottomNavItemTapped(index, selectedPageIndex, pageController),
      child: AnimatedScale(
        scale: isPressed.value ? 0.9 : 1.0, // タップ時に 90% に縮小
        duration: const Duration(milliseconds: 100),
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
            ),
          ],
        ),
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
