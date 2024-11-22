import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../external/tl_pref.dart';
import 'dart:convert';

class TLIconData {
  final String category;
  final String rarity;
  final String name;

  TLIconData({
    required this.category,
    required this.rarity,
    required this.name,
  });

  TLIconData copyWith({
    String? category,
    String? rarity,
    String? name,
  }) {
    return TLIconData(
      category: category ?? this.category,
      rarity: rarity ?? this.rarity,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'rarity': rarity,
      'name': name,
    };
  }

  factory TLIconData.fromJson(Map<String, dynamic> json) {
    return TLIconData(
      category: json['category'],
      rarity: json['rarity'],
      name: json['name'],
    );
  }
}
