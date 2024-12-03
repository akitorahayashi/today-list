import 'package:flutter/material.dart';
import '../tl_base_dialog.dart';
import '../../../../model/tl_theme.dart';
import '../../../styles.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class TLSingleOptionDialog extends TLBaseConsumerDialog {
  final String title;
  final String? message;

  const TLSingleOptionDialog({
    super.key,
    required this.title,
    this.message,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  child: const Text("OK"))
            ],
          ),
        ),
      ),
    );
  }
}
