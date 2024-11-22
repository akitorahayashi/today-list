import 'package:today_list/model/todo/tl_todo.dart';

class WidgetKitSetting {
  String id;
  String title;
  List<TLToDo> toDosToShow;

  WidgetKitSetting({
    required this.id,
    required this.title,
    required this.toDosToShow,
  });

  WidgetKitSetting copyWith({
    String? id,
    String? title,
    List<TLToDo>? toDosToShow,
  }) {
    return WidgetKitSetting(
      id: id ?? this.id,
      title: title ?? this.title,
      toDosToShow: toDosToShow ?? this.toDosToShow,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'toDosToShow': toDosToShow.map((t) => t.toJson()).toList(),
    };
  }

  factory WidgetKitSetting.fromJson(Map<String, dynamic> json) {
    return WidgetKitSetting(
      id: json['id'],
      title: json['title'],
      toDosToShow:
          (json['toDosToShow'] as List).map((t) => TLToDo.fromJson(t)).toList(),
    );
  }
}
