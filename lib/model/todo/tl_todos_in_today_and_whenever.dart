import 'package:freezed_annotation/freezed_annotation.dart';
import './tl_todo.dart';

part '../generate/tl_todos_in_today_and_whenever.freezed.dart';
part '../generate/tl_todos_in_today_and_whenever.g.dart';

// $ dart run build_runner build

@freezed
class TLToDosInTodayAndWhenever with _$TLToDosInTodayAndWhenever {
  const TLToDosInTodayAndWhenever._(); // プライベートコンストラクタを追加

  const factory TLToDosInTodayAndWhenever({
    @Default([]) List<TLToDo> toDosInToday,
    @Default([]) List<TLToDo> toDosInWhenever,
  }) = _TLToDosInTodayAndWhenever;

  factory TLToDosInTodayAndWhenever.fromJson(Map<String, dynamic> json) =>
      _$TLToDosInTodayAndWheneverFromJson(json);

  /// `ifInToday` が `true` の場合は `toDosInToday` を、`false` の場合は `toDosInWhenever` を返す
  List<TLToDo> getToDos(bool ifInToday) {
    return ifInToday ? toDosInToday : toDosInWhenever;
  }
}
