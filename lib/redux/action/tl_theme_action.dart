import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:today_list/resource/tl_theme_type.dart';

part 'generate/tl_theme_action.freezed.dart';

// $ dart run build_runner build

@freezed
class TLThemeAction with _$TLThemeAction {
  // テーマを変更する
  const factory TLThemeAction.changeTheme({
    required TLThemeType newThemeType,
  }) = ChangeThemeAction;

  // テーマのアクセントカラーを変更する
  const factory TLThemeAction.changeAccentColor({
    required Color newAccentColor,
  }) = ChangeAccentColorAction;
}
