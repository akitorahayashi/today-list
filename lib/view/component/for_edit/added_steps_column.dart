import 'package:flutter/material.dart';
import 'package:today_list/model/todo/tl_step.dart';
import 'package:today_list/view/component/todo_card/tl_checkbox.dart';

class AddedStepsColumn extends StatelessWidget {
  final List<TLStep> steps;
  final Function(int) onEditStep;
  final Function(int) onRemoveStep;

  const AddedStepsColumn({
    super.key,
    required this.steps,
    required this.onEditStep,
    required this.onRemoveStep,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        children: List.generate(steps.length, (i) {
          final step = steps[i];
          return Padding(
            key: ValueKey(step.id),
            padding: const EdgeInsets.only(left: 37.0, top: 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 見た目だけのチェックボックス
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: TLCheckBox(
                    isChecked: false,
                    iconColor: Colors.black.withValues(alpha: 0.35),
                    iconSize: 23,
                  ),
                ),
                // Step タイトル
                Expanded(
                  child: GestureDetector(
                    onTap: () => onEditStep(i),
                    child: Text(
                      step.content,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black.withValues(alpha: 0.55),
                      ),
                    ),
                  ),
                ),
                // Step削除ボタン
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: TextButton(
                    onPressed: () => onRemoveStep(i),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 9.0),
                      child: Icon(
                        Icons.remove,
                        color: Colors.black.withValues(alpha: 0.35),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
