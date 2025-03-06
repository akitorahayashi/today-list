import 'package:flutter/material.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/model/design/tl_theme_config.dart';
import 'package:today_list/model/todo/tl_todo.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/view/component/todo_card/tl_checkbox.dart';

class ModelOfToDoCard extends StatelessWidget {
  final bool ifInToday;
  final TLWorkspace corrWorkspace;
  final TLToDo corrTLToDo;
  const ModelOfToDoCard({
    super.key,
    required this.ifInToday,
    required this.corrWorkspace,
    required this.corrTLToDo,
  });

  @override
  Widget build(BuildContext context) {
    final TLThemeConfig tlThemeData = TLTheme.of(context);
    // notifier
    return Card(
      color: tlThemeData.canTapCardColor,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                  16, 18, 16, corrTLToDo.steps.isNotEmpty ? 15 : 18),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  // 左側のチェックボックス
                  Padding(
                      padding: const EdgeInsets.fromLTRB(4, 0, 16, 0),
                      // const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      child: Transform.scale(
                        scale: 1.2,
                        child: TLCheckBox(isChecked: corrTLToDo.isChecked),
                      )),
                  // toDoのタイトル
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        corrTLToDo.content,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black
                                .withAlpha(corrTLToDo.isChecked ? 77 : 153)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // steps
            if (corrTLToDo.steps.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Column(
                  children: corrTLToDo.steps.map((stepData) {
                    return Padding(
                      key: Key(stepData.id),
                      padding: const EdgeInsets.fromLTRB(8, 0, 2, 0),
                      child: Card(
                        color: tlThemeData.whiteBasedColor,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                          child: Row(
                            children: [
                              // 左側のチェックボックス
                              Padding(
                                padding: const EdgeInsets.fromLTRB(4, 0, 16, 0),
                                child: Transform.scale(
                                  scale: 1.2,
                                  child:
                                      TLCheckBox(isChecked: stepData.isChecked),
                                ),
                              ),
                              // stepのタイトル
                              Expanded(
                                child: Text(stepData.content,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black.withAlpha(
                                            stepData.isChecked ? 77 : 153))),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              )
          ],
        ),
      ),
    );
  }
}
