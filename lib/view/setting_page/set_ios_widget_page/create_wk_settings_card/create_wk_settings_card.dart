import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/component/common_ui_part/tl_double_card.dart';
import 'package:today_list/model/external/tl_vibration.dart';
import 'package:today_list/model/tl_theme.dart';
import 'package:today_list/model/todo/tl_category.dart';
import 'package:today_list/model/widget_kit_setting/widget_kit_setting.dart';
import 'package:today_list/model/widget_kit_setting/wks_provider.dart';
import 'package:today_list/model/workspace/provider/tl_workspaces_provider.dart';
import 'package:today_list/model/workspace/tl_workspace.dart';
import 'package:today_list/view/setting_page/set_ios_widget_page/component/wks_header.dart';

class CreateWKSettingsCard extends ConsumerStatefulWidget {
  final VoidCallback showAddWKSButtonAction;
  const CreateWKSettingsCard({super.key, required this.showAddWKSButtonAction});

  @override
  CreateWKSettingsCardState createState() => CreateWKSettingsCardState();
}

class CreateWKSettingsCardState extends ConsumerState<CreateWKSettingsCard> {
  // textControllerに関するメンバー
  final TextEditingController _wksInputController = TextEditingController();
  // 自動入力
  bool _ifUserHasEntered = false;
  // 選んでいるWorkspaceのindex
  int _selectedWorkspaceIndex = 0;
  // 選んでいるcategoryのID
  String _selectedBigCategoryID = noneID;
  String? _selectedSmallCategoryID;

  // 選んでいる項目を全てデフォルトの値に戻す関数
  void _initialize() {
    _wksInputController.clear();
    _ifUserHasEntered = false;
    _selectedWorkspaceIndex = 0;
    _selectedBigCategoryID = noneID;
    _selectedSmallCategoryID = null;
  }

  ButtonStyle get controllButtonStyle => (() {
        final themeColor =
            tlThemeDataList[ref.read(selectedThemeIndexProvider)].accentColor;
        return ButtonStyle(
          foregroundColor: WidgetStateProperty.all(themeColor),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          overlayColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              return themeColor.withOpacity(0.1);
            },
          ),
        );
      })();

  @override
  void dispose() {
    _wksInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TLThemeData tlThemeData = TLTheme.of(context);
    final double deviceWidth = MediaQuery.of(context).size.width;
    // provider
    final List<TLWorkspace> tlWorkspaces = ref.watch(tlWorkspacesProvider);
    // notifier
    final WidgetKitSettingNotifier wksnotifier =
        ref.read(widgetKitSettingsProvider.notifier);
    return GestureDetector(
      // カードをタップしたらTextFieldからunfocus
      onTap: () => FocusScope.of(context).unfocus(),
      child: TlDoubleCard(
        child: SizedBox(
          width: deviceWidth - 50,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // wksのtitleを入力する
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: TextField(
                    autofocus: true,
                    controller: _wksInputController,
                    // ユーザーが自分の手で入力したかどうか
                    onChanged: (t) => {_ifUserHasEntered = true},
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black.withOpacity(0.6),
                    ),
                    cursorColor: tlThemeData.accentColor,
                    decoration: InputDecoration(
                      labelText: '- Title -', // ここにラベルのテキストを指定
                      labelStyle: const TextStyle(
                        color: Colors.black45, // ラベルのスタイルを指定
                        fontWeight: FontWeight.bold,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: tlThemeData.accentColor),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: tlThemeData.accentColor),
                      ),
                    ),
                  ),
                ),
                // workspaceを選択する
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const WKSHeader(text: "Workspace"),
                      DropdownButton<int>(
                        isExpanded: true,
                        iconEnabledColor: tlThemeData.accentColor,
                        value: _selectedWorkspaceIndex,
                        items: tlWorkspaces.asMap().entries.map((entry) {
                          int idx = entry.key;
                          TLWorkspace workspace = entry.value;
                          return DropdownMenuItem<int>(
                            value: idx,
                            child: Text(workspace.name),
                          );
                        }).toList(),
                        style: const TextStyle(
                            color: Colors.black45, fontWeight: FontWeight.bold),
                        onChanged: (int? newIndex) {
                          if (newIndex == null) return;
                          TLVibration.vibrate();
                          setState(() {
                            if (!_ifUserHasEntered) {
                              _wksInputController.text =
                                  tlWorkspaces[newIndex].name;
                            }
                            _selectedWorkspaceIndex = newIndex;
                            _selectedBigCategoryID = noneID;
                            _selectedSmallCategoryID = null;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                // bigCategoryを選択する
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const WKSHeader(text: "Big category"),
                      DropdownButton<String>(
                        isExpanded: true,
                        iconEnabledColor: tlThemeData.accentColor,
                        value: _selectedBigCategoryID,
                        items: tlWorkspaces[_selectedWorkspaceIndex]
                            .bigCategories
                            .map((TLCategory bc) {
                          return DropdownMenuItem<String>(
                            value: bc.id,
                            child: Text(bc.title),
                          );
                        }).toList(),
                        style: const TextStyle(
                            color: Colors.black45, fontWeight: FontWeight.bold),
                        onChanged: (String? newBigCategoryID) {
                          if (newBigCategoryID == null) return;
                          TLVibration.vibrate();
                          setState(() {
                            if (!_ifUserHasEntered) {
                              _wksInputController.text =
                                  tlWorkspaces[_selectedWorkspaceIndex]
                                      .bigCategories
                                      .firstWhere(
                                          (bc) => bc.id == newBigCategoryID)
                                      .title;
                            }
                            _selectedBigCategoryID = newBigCategoryID;
                            _selectedSmallCategoryID = null;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                // smallCategoryを選択するを選択する
                AnimatedCrossFade(
                  crossFadeState: tlWorkspaces[_selectedWorkspaceIndex]
                          .smallCategories[_selectedBigCategoryID]!
                          .isEmpty
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  duration: const Duration(milliseconds: 200),
                  firstChild: Container(),
                  secondChild: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const WKSHeader(text: "Small category"),
                        DropdownButton<String>(
                          isExpanded: true,
                          iconEnabledColor: tlThemeData.accentColor,
                          value: _selectedSmallCategoryID,
                          hint: const Text(
                            "指定なし",
                            style: TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.bold),
                          ),
                          items: (tlWorkspaces[_selectedWorkspaceIndex]
                                          .smallCategories[
                                      _selectedBigCategoryID] ??
                                  [])
                              .map((TLCategory sc) {
                            return DropdownMenuItem<String>(
                              value: sc.id,
                              child: Text(sc.title),
                            );
                          }).toList(),
                          style: const TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.bold),
                          onChanged: (String? newSmallCategoryID) {
                            if (newSmallCategoryID == null) return;
                            TLVibration.vibrate();
                            setState(() {
                              if (!_ifUserHasEntered) {
                                _wksInputController.text = tlWorkspaces[
                                        _selectedWorkspaceIndex]
                                    .smallCategories[_selectedBigCategoryID]!
                                    .firstWhere(
                                        (sc) => sc.id == newSmallCategoryID)
                                    .title;
                              }
                              _selectedSmallCategoryID = newSmallCategoryID;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                // controll buttons
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                  child: OverflowBar(
                    alignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                          onPressed: () {
                            setState(() {
                              _initialize();
                            });
                            widget.showAddWKSButtonAction();
                          },
                          style: controllButtonStyle,
                          child: const Text(
                            "戻る",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      TextButton(
                        onPressed: _wksInputController.text.trim().isEmpty
                            ? null
                            : () {
                                TLVibration.vibrate();
                                // wksのlistに追加、保存
                                wksnotifier.addWidgetKitSettings(
                                    newWidgetKitSettings: WidgetKitSetting(
                                  id: UniqueKey().toString(),
                                  title: _wksInputController.text,
                                  selectedWorkspaceIndex:
                                      _selectedWorkspaceIndex,
                                  selectedCategoryID:
                                      _selectedSmallCategoryID ??
                                          _selectedBigCategoryID,
                                ));
                                // Card内のコンテンツを初期化
                                setState(() {
                                  _initialize();
                                });
                                // 一覧に戻る
                                widget.showAddWKSButtonAction();
                              },
                        style: controllButtonStyle,
                        child: const Text(
                          "追加",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
