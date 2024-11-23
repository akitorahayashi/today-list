class WidgetKitSetting {
  String id;
  String title;
  int selectedWorkspaceIndex;
  String selectedCategoryID;

  WidgetKitSetting({
    required this.id,
    required this.title,
    required this.selectedWorkspaceIndex,
    required this.selectedCategoryID,
  });

  WidgetKitSetting copyWith({
    String? id,
    String? title,
    int? selectedWorkspaceIndex,
    String? selectedCategoryID,
  }) {
    return WidgetKitSetting(
      id: id ?? this.id,
      title: title ?? this.title,
      selectedWorkspaceIndex:
          selectedWorkspaceIndex ?? this.selectedWorkspaceIndex,
      selectedCategoryID: selectedCategoryID ?? this.selectedCategoryID,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'selectedWorkspaceIndex': selectedWorkspaceIndex,
      'selectedCategoryID': selectedCategoryID,
    };
  }

  factory WidgetKitSetting.fromJson(Map<String, dynamic> json) {
    return WidgetKitSetting(
      id: json['id'],
      title: json['title'],
      selectedWorkspaceIndex: json['selectedWorkspaceIndex'],
      selectedCategoryID: json['selectedCategoryID'],
    );
  }
}
