import 'package:flutter/material.dart';
import 'package:today_list/view/component/dialog/common/tl_single_option_dialog.dart';

enum TLValidationResult {
  valid,
  empty,
  tooLong,
}

class TLValidation {
  static TLValidationResult validateCategoryName(String name) {
    if (name.trim().isEmpty) {
      return TLValidationResult.empty;
    }
    if (name.length > 15) {
      return TLValidationResult.tooLong;
    }
    return TLValidationResult.valid;
  }

  static TLValidationResult validateWKSName(String name) {
    if (name.trim().isEmpty) {
      return TLValidationResult.empty;
    }
    if (name.length > 15) {
      return TLValidationResult.tooLong;
    }
    return TLValidationResult.valid;
  }

  static TLValidationResult validateWorkspaceName(String name) {
    if (name.trim().isEmpty) {
      return TLValidationResult.empty;
    }
    if (name.length > 15) {
      return TLValidationResult.tooLong;
    }
    return TLValidationResult.valid;
  }

  static Future<void> validateNameAndExecute({
    required BuildContext context,
    required String name,
    required TLValidationResult Function(String) validator,
    required Future<void> Function() onSuccess,
  }) async {
    final validationResult = validator(name);

    if (validationResult == TLValidationResult.valid) {
      await onSuccess();
    } else {
      showValidationErrorDialog(context, validationResult);
    }
  }

  static void showValidationErrorDialog(
      BuildContext context, TLValidationResult validationResult) {
    const errorTitle = "エラー";
    if (validationResult == TLValidationResult.empty) {
      // 空白しかない場合
      const TLSingleOptionDialog(
        title: errorTitle,
        message: "空白以外の文字を入力してください",
      ).show(context: context);
    } else if (validationResult == TLValidationResult.tooLong) {
      // 15文字以上で長すぎる場合
      const TLSingleOptionDialog(
        title: errorTitle,
        message: "15文字以内で入力してください",
      ).show(context: context);
    }
  }
}
