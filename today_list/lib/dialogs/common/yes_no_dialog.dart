import 'package:flutter/material.dart';
import '../../model/tl_theme.dart';
import '../../constants/styles.dart';

class YesNoDialog extends StatelessWidget {
  final String title;
  final String? message;
  final Function()? yesAction;
  YesNoDialog({
    super.key,
    required this.title,
    required this.message,
    required this.yesAction,
  });

  @override
  Widget build(BuildContext context) {
    final TLThemeData _tlThemeData = TLTheme.of(context);
    return Dialog(
      backgroundColor: _tlThemeData.alertColor,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 16),
              child: Text(
                title,
                style: TextStyle(
                    color: _tlThemeData.accentColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            if (message != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  message!,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.6),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            if (message == null)
              const SizedBox(
                height: 30,
              ),
            OverflowBar(
              alignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style:
                        alertButtonStyle(accentColor: _tlThemeData.accentColor),
                    child: const Text("いいえ")),
                TextButton(
                  onPressed: yesAction,
                  style:
                      alertButtonStyle(accentColor: _tlThemeData.accentColor),
                  child: const Text("はい"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
