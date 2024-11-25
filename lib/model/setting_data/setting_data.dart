class SettingData {
  String currentAppIconName;

  SettingData({
    required this.currentAppIconName,
  });

  // copyWithメソッド
  SettingData copyWith({String? currentAppIconName}) {
    return SettingData(
      currentAppIconName: currentAppIconName ?? this.currentAppIconName,
    );
  }

  // JSONに変換するメソッド
  Map<String, dynamic> toJson() {
    return {
      'currentAppIconName': currentAppIconName,
    };
  }

  // JSONからインスタンスを生成するファクトリコンストラクタ
  factory SettingData.fromJson(Map<String, dynamic> json) {
    return SettingData(
        currentAppIconName: json['currentAppIconName'] ?? "Sun Orange");
  }
}
