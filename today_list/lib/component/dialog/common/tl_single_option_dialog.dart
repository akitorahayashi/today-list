import 'package:flutter/material.dart';
import '../../../model/design/tl_theme.dart';
import '../../../style/styles.dart';

class TLSingleOptionDialog extends StatelessWidget {
  final String title;
  final String? message;

  static Future<void> show({
    required BuildContext context,
    required String title,
    String? message,
  }) async {
    return showDialog(
        context: context,
        builder: (context) {
          return TLSingleOptionDialog(title: title, message: message);
        });
  }

  const TLSingleOptionDialog({
    super.key,
    required this.title,
    required this.message,
  });
  @override
  Widget build(BuildContext context) {
    final TLThemeData corrThemeData = TLTheme.of(context);
    return Dialog(
      backgroundColor: corrThemeData.alertColor,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 16),
                child: Text(
                  title,
                  style: TextStyle(
                      color: corrThemeData.accentColor,
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
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  style:
                      alertButtonStyle(accentColor: corrThemeData.accentColor),
                  child: Text("OK"))
            ],
          ),
        ),
      ),
    );
  }
}
