import 'package:freezed_annotation/freezed_annotation.dart';
import './tl_step.dart';

part '../generate/tl_todo.freezed.dart';
part '../generate/tl_todo.g.dart';

// $ dart run build_runner build

@freezed
class TLToDo with _$TLToDo {
  const factory TLToDo({
    required String id,
    required String categoryID,
    required String content,
    @Default(false) bool isChecked,
    @Default([]) List<TLStep> steps,
  }) = _TLToDo;

  factory TLToDo.fromJson(Map<String, dynamic> json) => _$TLToDoFromJson(json);
}
