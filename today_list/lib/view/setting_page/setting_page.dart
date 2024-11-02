import 'package:flutter/material.dart';
import '../../model/tl_theme.dart';
import '../../components/common/tl_sliver_appbar.dart';
import 'set_features_page/set_appearance_page.dart';
import './my_page/my_page.dart';
// import './other_app_page/other_app_page.dart';

import 'package:flutter_progress_hud/flutter_progress_hud.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
// 設定ページ遷移系のメンバー
  int _selectedPageIndex = 0;
  final PageController _pageControllerInSettingPage =
      PageController(initialPage: 0);
  final List<Widget> _contentsInSettingPage = [
    // const OtherAppsPage(),
    SetAppearancePage(),
    MyPage(),
  ];
  final List<dynamic> _iconDataOfSettingPageContents = [
    // iconData or imagePath, page name, isAsset
    // [Icons.construction, "Others"],
    [Icons.phone_android, "Features"],
    [Icons.account_circle_outlined, "My Page"],
  ];
// --- ページ遷移系のメンバー
  @override
  Widget build(BuildContext context) {
    final TLThemeData _tlThemeData = TLTheme.of(context);
    return ProgressHUD(
      barrierEnabled: true,
      indicatorColor: Colors.white,
      textStyle: const TextStyle(
          color: Colors.white, fontSize: 16, decoration: TextDecoration.none),
      child: Scaffold(
        // コンテンツの表示
        body: Stack(
          children: [
            // 背景色
            Container(
                decoration: BoxDecoration(color: _tlThemeData.backgroundColor)),
            NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  TLSliverAppBar(
                    pageTitle: "Settings",
                    leadingButtonOnPressed: () {
                      Navigator.pop(context);
                    },
                    leadingIcon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                    trailingButtonOnPressed: null,
                    // adIsClosed
                    //     ? null
                    //     : () async {
                    //         await Navigator.push(context,
                    //             MaterialPageRoute(builder: (context) {
                    //           return ProPage(
                    //             key: proPageKey,
                    //           );
                    //         }));
                    //         homePageKey.currentState?.setState(() {});
                    //       },
                    trailingIcon: null,
                    // adIsClosed
                    //     ? null
                    //     : isDevelopperMode
                    //         ? const Icon(
                    //             Icons.construction,
                    //             color: Colors.white,
                    //           )
                    //         : purchase.havePurchased
                    //             ? const Icon(
                    //                 FontAwesomeIcons.crown,
                    //                 color: Colors.white,
                    //                 size: 17,
                    //               )
                    //             : Transform.rotate(
                    //                 angle: 3.14,
                    //                 child: const Icon(
                    //                   Icons.auto_awesome,
                    //                   color: Colors.white,
                    //                 ),
                    //               ),
                  ),
                ];
              },
              body: PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return _contentsInSettingPage[index];
                },
                itemCount: _contentsInSettingPage.length,
                controller: _pageControllerInSettingPage,
              ),
            ),
            // bottom navbar
            Positioned(
              bottom: 0,
              // admob.ticketIsActive ? 0 : 50,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: (100 * MediaQuery.of(context).size.height / 896),
                // admob.ticketIsActive
                //     ? (100 * MediaQuery.of(context).size.height / 896)
                //     : 80,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black45, blurRadius: 8)
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int index = 0;
                        index < _contentsInSettingPage.length;
                        index++)
                      GestureDetector(
                        onTap: () {
                          if (_selectedPageIndex != index) {
                            _selectedPageIndex = index;
                            _pageControllerInSettingPage.animateToPage(
                              _selectedPageIndex,
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.decelerate,
                            );
                            setState(() {});
                          }
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // アイコンを表示
                            (() {
                              switch (index) {
                                case 0:
                                  return Icon(
                                    _iconDataOfSettingPageContents[index][0],
                                    color: index == _selectedPageIndex
                                        ? _tlThemeData.accentColor
                                        : Colors.black45,
                                  );
                                // if (todayListUser
                                //         .accontSignedInWithGoogle ==
                                //     null) {
                                // return Icon(
                                //   _iconDataOfSettingPageContents[index][0],
                                //   color: index == _selectedPageIndex
                                //       ? theme[settingData.selectedTheme]!
                                //           .accentColor
                                //       : Colors.black45,
                                // );
                                // } else {
                                //   return CachedNetworkImage(
                                //     imageUrl: todayListUser
                                //         .accontSignedInWithGoogle!
                                //         .photoUrl!,
                                //     imageBuilder: (context, imageProvider) {
                                //       return SizedBox(
                                //         width: 24,
                                //         height: 24,
                                //         child: DecoratedBox(
                                //           decoration: BoxDecoration(
                                //               shape: BoxShape.circle,
                                //               border: Border.all(
                                //                 width: 1.5,
                                //                 color: _selectedPageIndex ==
                                //                         0
                                //                     ? theme[settingData
                                //                             .selectedTheme]!
                                //                         .accentColor
                                //                         .withOpacity(1)
                                //                     : Colors.white
                                //                         .withOpacity(.8),
                                //               ),
                                //               image: DecorationImage(
                                //                   fit: BoxFit.contain,
                                //                   image: imageProvider)),
                                //         ),
                                //       );
                                //     },
                                //     placeholder: (context, url) =>
                                //         Container(),
                                //     errorWidget: (context, url, error) =>
                                //         Icon(
                                //       Icons.account_circle_outlined,
                                //       color: index == _selectedPageIndex
                                //           ? theme[settingData
                                //                   .selectedTheme]!
                                //               .accentColor
                                //           : Colors.black45,
                                //     ),
                                //   );
                                // }
                                case 2:
                                  return SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            width: 1.5,
                                            color: _selectedPageIndex == 2
                                                ? _tlThemeData.accentColor
                                                    .withOpacity(1)
                                                : Colors.white.withOpacity(.8),
                                          ),
                                          image: const DecorationImage(
                                              fit: BoxFit.contain,
                                              image: AssetImage(
                                                  "assets/my_icon.png"))),
                                    ),
                                  );
                                default:
                                  return Icon(
                                    _iconDataOfSettingPageContents[index][0],
                                    color: index == _selectedPageIndex
                                        ? _tlThemeData.accentColor
                                        : Colors.black45,
                                  );
                              }
                            }()),
                            Padding(
                              padding: const EdgeInsets.only(top: 11.0),
                              child: Text(
                                _iconDataOfSettingPageContents[index][1],
                                style: TextStyle(
                                  color: index == _selectedPageIndex
                                      ? _tlThemeData.accentColor
                                      : Colors.black45,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
