import 'package:freezed_annotation/freezed_annotation.dart';
import './tl_todo.dart';

part '../generate/tl_todos_in_today_and_whenever.freezed.dart';
part '../generate/tl_todos_in_today_and_whenever.g.dart';

// $ dart run build_runner build

@freezed
class TLToDosInTodayAndWhenever with _$TLToDosInTodayAndWhenever {
  // プライベートコンストラクタを追加してカスタムメソッドを定義できるようにする
  const TLToDosInTodayAndWhenever._();

  const factory TLToDosInTodayAndWhenever({
    @Default([]) List<TLToDo> toDosInToday,
    @Default([]) List<TLToDo> toDosInWhenever,
  }) = _TLToDosInTodayAndWhenever;

  factory TLToDosInTodayAndWhenever.fromJson(Map<String, dynamic> json) =>
      _$TLToDosInTodayAndWheneverFromJson(json);

  /// `isInToday` が `true` の場合は `toDosInToday` を、`false` の場合は `toDosInWhenever` を返す
  List<TLToDo> getToDos(bool isInToday) {
    return isInToday ? toDosInToday : toDosInWhenever;
  }

  /// `isInToday` の情報を元に、新しい `ToDo` リストを適用した新しいTLToDosInTodayAndWheneverのインスタンスを返す
  TLToDosInTodayAndWhenever updateListOfToDoInTodayOrWhenever({
    required bool isInToday,
    required List<TLToDo> updatedToDos,
  }) {
    return copyWith(
      toDosInToday: isInToday ? updatedToDos : toDosInToday,
      toDosInWhenever: isInToday ? toDosInWhenever : updatedToDos,
    );
  }

  /// `isInToday` の情報を元に、指定した `ToDo` を削除した新しいTLToDosInTodayAndWheneverのインスタンスを返す
  TLToDosInTodayAndWhenever deleteAllCheckedToDosInAToDosList({
    bool? isInToday,
  }) {
    final copiedToDosInTodayAndWhenever = copyWith();
    if (isInToday != null) {
      copiedToDosInTodayAndWhenever.updateListOfToDoInTodayOrWhenever(
        isInToday: isInToday,
        updatedToDos: getToDos(isInToday)
            .where((TLToDo toDo) => !toDo.isChecked)
            .toList(),
      );
    } else {
      copiedToDosInTodayAndWhenever.updateListOfToDoInTodayOrWhenever(
        isInToday: true,
        updatedToDos:
            toDosInToday.where((TLToDo toDo) => !toDo.isChecked).toList(),
      );
      copiedToDosInTodayAndWhenever.updateListOfToDoInTodayOrWhenever(
        isInToday: false,
        updatedToDos:
            toDosInWhenever.where((TLToDo toDo) => !toDo.isChecked).toList(),
      );
    }
    return copiedToDosInTodayAndWhenever;
  }
}
