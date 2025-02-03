import 'package:freezed_annotation/freezed_annotation.dart';
import './tl_todo.dart';

part '../generate/tl_todos.freezed.dart';
part '../generate/tl_todos.g.dart';

// $ dart run build_runner build

@freezed
class TLToDos with _$TLToDos {
  const factory TLToDos({
    @Default([]) List<TLToDo> toDosInToday,
    @Default([]) List<TLToDo> toDosInWhenever,
  }) = _TLToDos;

  factory TLToDos.fromJson(Map<String, dynamic> json) =>
      _$TLToDosFromJson(json);
}

// TODO 応急処置
extension TLToDosExtension on TLToDos {
  List<TLToDo> getToDos(bool ifInToday) {
    return ifInToday ? toDosInToday : toDosInWhenever;
  }
}
