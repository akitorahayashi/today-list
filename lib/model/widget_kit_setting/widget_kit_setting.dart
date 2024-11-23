import 'package:today_list/model/todo/tl_category.dart';

class WidgetKitSetting {
  String id;
  String title;
  int workspaceIdx;
  TLCategory selectedBigCategory;
  TLCategory? selectedSmallCategory;

  WidgetKitSetting({
    required this.id,
    required this.title,
    required this.workspaceIdx,
    required this.selectedBigCategory,
    required this.selectedSmallCategory,
  });

  WidgetKitSetting copyWith({
    String? id,
    String? title,
    int? selectedWorkspaceIndex,
    TLCategory? selectedBigCategory,
    TLCategory? selectedSmallCategory,
  }) {
    return WidgetKitSetting(
      id: id ?? this.id,
      title: title ?? this.title,
      workspaceIdx: selectedWorkspaceIndex ?? this.workspaceIdx,
      selectedBigCategory: selectedBigCategory ?? this.selectedBigCategory,
      selectedSmallCategory:
          selectedSmallCategory ?? this.selectedSmallCategory,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'workspaceIdx': workspaceIdx,
      'selectedBigCategory': selectedBigCategory,
      'selectedSmallCategory': selectedSmallCategory,
    };
  }

  factory WidgetKitSetting.fromJson(Map<String, dynamic> json) {
    return WidgetKitSetting(
      id: json['id'],
      title: json['title'],
      workspaceIdx: json['workspaceIdx'],
      selectedBigCategory: TLCategory.fromJson(json['selectedBigCategory']),
      selectedSmallCategory: TLCategory.fromJson(json['selectedSmallCategory']),
    );
  }
}
