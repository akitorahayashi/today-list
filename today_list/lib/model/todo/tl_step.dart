class TLStep {
  String title;
  bool isChecked;

  TLStep({
    required this.title,
    this.isChecked = false,
  });

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "isChecked": isChecked,
    };
  }

  factory TLStep.fromJson(Map<String, dynamic> jsonData) {
    return TLStep(
      title: jsonData["title"],
      isChecked: jsonData["isChecked"] ?? false, // デフォルト値を設定
    );
  }
}
