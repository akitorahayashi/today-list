import 'package:flutter/material.dart';
import '../../../model/todo/tl_step.dart';
import '../../../constants/global_keys.dart';

import 'package:reorderables/reorderables.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StepsColumn extends StatefulWidget {
  final List<TLStep> stepsOfThisToDo;
  final Function(int) onTapStepRow;
  final Function(int) tapToRemoveStepRow;
  const StepsColumn({
    super.key,
    required this.stepsOfThisToDo,
    required this.onTapStepRow,
    required this.tapToRemoveStepRow,
  });

  @override
  State<StepsColumn> createState() => _StepsColumnState();
}

class _StepsColumnState extends State<StepsColumn> {
  @override
  Widget build(BuildContext context) {
    return ReorderableColumn(
      children: List<Widget>.generate(widget.stepsOfThisToDo.length, (index) {
        return Padding(
          key: Key(UniqueKey().toString()),
          padding: const EdgeInsets.only(left: 16.0, top: 1),
          child: Padding(
            padding: const EdgeInsets.only(left: 21.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: FaIcon(
                    FontAwesomeIcons.square,
                    color: Colors.black.withOpacity(0.35),
                    size: 23,
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                      onTap: () {
                        widget.onTapStepRow(index);
                        editToDoPageKey.currentState?.setState(() {});
                      },
                      child: Text(
                        widget.stepsOfThisToDo[index].title,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black.withOpacity(0.55)),
                      )),
                ),
                // step を消す
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: TextButton(
                    onPressed: () {
                      widget.tapToRemoveStepRow(index);
                      editToDoPageKey.currentState?.setState(() {});
                    },
                    style: TextButton.styleFrom(
                      splashFactory: NoSplash.splashFactory,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 9.0),
                      child: Icon(
                        Icons.remove,
                        color: Colors.black.withOpacity(0.35),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
      onReorder: (oldIndex, newIndex) {
        if (oldIndex != newIndex) {
          final reOrderedToDo = widget.stepsOfThisToDo.removeAt(oldIndex);
          widget.stepsOfThisToDo.insert(newIndex, reOrderedToDo);

          setState(() {});
        }
      },
    );
  }
}
