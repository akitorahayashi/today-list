import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/tl_theme.dart';

class CreateWKSettingsCard extends ConsumerStatefulWidget {
  final VoidCallback showAddWKSButtonAction;
  const CreateWKSettingsCard({super.key, required this.showAddWKSButtonAction});

  @override
  CreateWKSettingsCardState createState() => CreateWKSettingsCardState();
}

class CreateWKSettingsCardState extends ConsumerState<CreateWKSettingsCard> {
  final TextEditingController _wksInputController = TextEditingController();

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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Card(
        color: tlThemeData.accentColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: SizedBox(
            width: deviceWidth - 50,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // wksのtitleを入力する
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: TextField(
                      autofocus: true,
                      controller: _wksInputController,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black.withOpacity(0.6),
                      ),
                      cursorColor: tlThemeData.accentColor,
                      decoration: InputDecoration(
                        labelText: 'Title', // ここにラベルのテキストを指定
                        labelStyle: const TextStyle(
                          color: Colors.black45, // ラベルのスタイルを指定
                          fontWeight: FontWeight.bold,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: tlThemeData.accentColor),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: tlThemeData.accentColor),
                        ),
                      ),
                    ),
                  ),
                  // workspaceを選択する
                  // bigCategoryを選択する
                  // smallCategoryを選択するを選択する
                  // controll buttons
                  OverflowBar(
                    alignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                          onPressed: () => widget.showAddWKSButtonAction(),
                          style: controllButtonStyle,
                          child: const Text(
                            "戻る",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      TextButton(
                        onPressed: () {},
                        style: controllButtonStyle,
                        child: const Text(
                          "追加",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
