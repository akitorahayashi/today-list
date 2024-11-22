import 'package:flutter/material.dart';

class TLStep {
  String id;
  String title;
  bool isChecked;

  TLStep({
    required this.id,
    required this.title,
    this.isChecked = false,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "isChecked": isChecked,
    };
  }

  factory TLStep.fromJson(Map<String, dynamic> jsonData) {
    return TLStep(
      id: jsonData["id"] ?? UniqueKey().toString(),
      title: jsonData["title"] ?? "",
      isChecked: jsonData["isChecked"] ?? false,
    );
  }
}
