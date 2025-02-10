import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:today_list/styles.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';

class StepTitleInputField extends StatefulWidget {
  final TextEditingController stepTitleController;
  final bool isEditing;
  final Function(String) onAddOrEditStep;

  const StepTitleInputField({
    super.key,
    required this.stepTitleController,
    required this.isEditing,
    required this.onAddOrEditStep,
  });

  @override
  State<StepTitleInputField> createState() => _StepTitleInputFieldState();
}

class _StepTitleInputFieldState extends State<StepTitleInputField> {
  String _enteredStepTitle = "";

  @override
  void initState() {
    super.initState();
    _enteredStepTitle = widget.stepTitleController.text;
    widget.stepTitleController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.stepTitleController.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _enteredStepTitle = widget.stepTitleController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    final TLThemeConfig tlThemeData = TLTheme.of(context);

    return SizedBox(
      width: MediaQuery.of(context).size.width - 50,
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: TextField(
          controller: widget.stepTitleController,
          autofocus: true,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black.withOpacity(0.6),
          ),
          cursorColor: tlThemeData.accentColor,
          decoration: tlInputDecoration(
            context: context,
            labelText: "Step",
            icon: Icon(
              FontAwesomeIcons.square,
              color: Colors.black.withOpacity(0.35),
            ),
            suffixIcon: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: _enteredStepTitle.trim().isNotEmpty ? 1 : 0.25,
              child: TextButton(
                onPressed: _enteredStepTitle.trim().isEmpty
                    ? null
                    : () {
                        widget.onAddOrEditStep(_enteredStepTitle.trim());
                        // ここで TextField をクリアするかどうかは親の処理次第
                        // → 今回は親から clear される前提でもOK
                      },
                child: Icon(
                  widget.isEditing ? Icons.edit : Icons.add,
                  color: _enteredStepTitle.trim().isNotEmpty
                      ? tlThemeData.accentColor
                      : Colors.black,
                  size: 25,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
