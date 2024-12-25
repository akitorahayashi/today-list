import 'package:flutter/material.dart';
import 'package:today_list/view/component/dialog/common/tl_single_option_dialog.dart';

enum ValidationResult {
  valid,
  empty,
  tooLong,
}

class TLValidation {
  static ValidationResult validateCategoryName(String name) {
    if (name.trim().isEmpty) {
      return ValidationResult.empty;
    }
    if (name.length > 15) {
      return ValidationResult.tooLong;
    }
    return ValidationResult.valid;
  }

  static ValidationResult validateWKSName(String name) {
    if (name.trim().isEmpty) {
      return ValidationResult.empty;
    }
    if (name.length > 15) {
      return ValidationResult.tooLong;
    }
    return ValidationResult.valid;
  }

  static ValidationResult validateWorkspaceName(String name) {
    if (name.trim().isEmpty) {
      return ValidationResult.empty;
    }
    if (name.length > 15) {
      return ValidationResult.tooLong;
    }
    return ValidationResult.valid;
  }

  static Future<void> validateNameAndExecute({
    required BuildContext context,
    required String name,
    required ValidationResult Function(String) validator,
    required Future<void> Function() onSuccess,
  }) async {
    final validationResult = validator(name);

    if (validationResult == ValidationResult.valid) {
      await onSuccess();
    } else {
      showValidationErrorDialog(context, validationResult);
    }
  }

  static void showValidationErrorDialog(
      BuildContext context, ValidationResult validationResult) {
    const errorTitle = "エラー";
    if (validationResult == ValidationResult.empty) {
      // 空白しかない場合
      const TLSingleOptionDialog(
        title: errorTitle,
        message: "空白以外の文字を入力してください",
      ).show(context: context);
    } else if (validationResult == ValidationResult.tooLong) {
      // 15文字以上で長すぎる場合
      const TLSingleOptionDialog(
        title: errorTitle,
        message: "15文字以内で入力してください",
      ).show(context: context);
    }
  }
}
