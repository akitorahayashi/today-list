import 'package:flutter/material.dart';
import 'package:today_list/view/screen/setting_page/set_ios_widget_page/set_ios_widget_page.dart';
import 'package:today_list/view/component/common_ui_part/tl_sliver_appbar.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'set_features_page/set_appearance_page.dart';
import 'dart:io';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class TLSettingPage extends StatefulWidget {
  const TLSettingPage({super.key});

  @override
  State<TLSettingPage> createState() => _TLSettingPageState();
}

class _TLSettingPageState extends State<TLSettingPage> {
  late int _selectedPageIndex;
  late PageController _pageControllerInSettingPage;

  final List<Widget> _contentsInSettingPage = [
    if (Platform.isIOS) const SetIOSWidgetPage(),
    const SetAppearancePage(),
    // const MyPage(),
  ];

  final List<dynamic> _iconDataOfSettingPageContents = [
    [Icons.widgets, "Widgets"],
    [Icons.phone_android, "Features"],
    // [Icons.account_circle_outlined, "My Page"],
  ];

  @override
  void initState() {
    super.initState();
    _initializePageController();
  }

  // MARK - Initialize PageController
  void _initializePageController() {
    _selectedPageIndex = Platform.isIOS ? 1 : 0;
    _pageControllerInSettingPage =
        PageController(initialPage: _selectedPageIndex);
  }

  @override
  Widget build(BuildContext context) {
    final TLThemeData tlThemeData = TLTheme.of(context);
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
              body: _buildPageView(),
            ),
            _buildBottomNavBar(tlThemeData),
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
  Widget _buildPageView() {
    return PageView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => _contentsInSettingPage[index],
      itemCount: _contentsInSettingPage.length,
      controller: _pageControllerInSettingPage,
    );
  }

  // MARK - Build Bottom Navigation Bar
  Widget _buildBottomNavBar(TLThemeData tlThemeData) {
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
            for (int index = 0; index < _contentsInSettingPage.length; index++)
              _buildBottomNavItem(index, tlThemeData),
          ],
        ),
      ),
    );
  }

  // MARK - Build Navigation Item
  Widget _buildBottomNavItem(int index, TLThemeData tlThemeData) {
    return GestureDetector(
      onTap: () => _onBottomNavItemTapped(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _iconDataOfSettingPageContents[index][0],
            color: index == _selectedPageIndex
                ? tlThemeData.accentColor
                : Colors.black45,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 11.0),
            child: Text(
              _iconDataOfSettingPageContents[index][1],
              style: TextStyle(
                color: index == _selectedPageIndex
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
  void _onBottomNavItemTapped(int index) {
    if (_selectedPageIndex != index) {
      setState(() {
        _selectedPageIndex = index;
      });
      _pageControllerInSettingPage.animateToPage(
        _selectedPageIndex,
        duration: const Duration(milliseconds: 400),
        curve: Curves.decelerate,
      );
    }
  }
}
