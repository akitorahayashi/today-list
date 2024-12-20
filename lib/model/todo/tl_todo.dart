import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import './tl_step.dart';

part '../generate/tl_todo.freezed.dart';
part '../generate/tl_todo.g.dart';

@freezed
class TLToDo with _$TLToDo {
  const factory TLToDo({
    required String id,
    required String title,
    @Default(false) bool isChecked,
    @Default([]) List<TLStep> steps,
  }) = _TLToDo;

  /// 自動生成された fromJson をそのまま使用
  factory TLToDo.fromJson(Map<String, dynamic> json) => _$TLToDoFromJson(json);

  // static Map<String, dynamic> _adjustJson(Map<String, dynamic> json) {
  //   final List<dynamic> stepsData = json['steps'] ?? [];
  //   return {
  //     ...json,
  //     'steps': stepsData.map((stepData) => TLStep.fromJson(stepData)).toList(),
  //   };
  // }

  /// デフォルト値を提供するメソッド
  static TLToDo getDefaultToDo() {
    return TLToDo(
      id: UniqueKey().toString(),
      title: '',
      isChecked: false,
      steps: [],
    );
  }
}
