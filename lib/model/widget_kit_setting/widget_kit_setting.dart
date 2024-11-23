import 'package:today_list/model/todo/tl_category.dart';

class WidgetKitSetting {
  String id;
  String title;
  int selectedWorkspaceIndex;
  TLCategory selectedBigCategory;
  TLCategory? selectedSmallCategory;

  WidgetKitSetting({
    required this.id,
    required this.title,
    required this.selectedWorkspaceIndex,
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
      selectedWorkspaceIndex:
          selectedWorkspaceIndex ?? this.selectedWorkspaceIndex,
      selectedBigCategory: selectedBigCategory ?? this.selectedBigCategory,
      selectedSmallCategory:
          selectedSmallCategory ?? this.selectedSmallCategory,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'selectedWorkspaceIndex': selectedWorkspaceIndex,
      'selectedBigCategory': selectedBigCategory,
      'selectedSmallCategory': selectedSmallCategory,
    };
  }

  factory WidgetKitSetting.fromJson(Map<String, dynamic> json) {
    return WidgetKitSetting(
      id: json['id'],
      title: json['title'],
      selectedWorkspaceIndex: json['selectedWorkspaceIndex'],
      selectedBigCategory: TLCategory.fromJson(json['selectedBigCategory']),
      selectedSmallCategory: TLCategory.fromJson(json['selectedSmallCategory']),
    );
  }
}
