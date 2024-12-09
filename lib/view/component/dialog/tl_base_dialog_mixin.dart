import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// stateless dialog
mixin TLBaseDialogMixin {
  Future<void> show({
    required BuildContext context,
  }) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return this as Widget;
      },
    );
  }
}
