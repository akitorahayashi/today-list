class WidgetKitSetting {
  String id;
  String title;
  int workspaceIdx;
  int bcIdx;
  int? scIdx;

  WidgetKitSetting({
    required this.id,
    required this.title,
    required this.workspaceIdx,
    required this.bcIdx,
    required this.scIdx,
  });

  WidgetKitSetting copyWith({
    String? id,
    String? title,
    int? workspaceIdx,
    int? bcIdx,
    int? scIdx,
  }) {
    return WidgetKitSetting(
      id: id ?? this.id,
      title: title ?? this.title,
      workspaceIdx: workspaceIdx ?? this.workspaceIdx,
      bcIdx: bcIdx ?? this.bcIdx,
      scIdx: scIdx ?? this.scIdx,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'workspaceIdx': workspaceIdx,
      'bcIdx': bcIdx,
      'scIdx': scIdx,
    };
  }

  factory WidgetKitSetting.fromJson(Map<String, dynamic> json) {
    return WidgetKitSetting(
      id: json['id'],
      title: json['title'],
      workspaceIdx: json['workspaceIdx'] ?? 0,
      bcIdx: json['bcIdx'] ?? 0,
      scIdx: json['scIdx'],
    );
  }
}
