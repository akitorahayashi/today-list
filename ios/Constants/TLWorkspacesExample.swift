//
//  TLContentExample.swift
//  Runner
//
//  Created by 林 明虎 on 2024/10/05.
//

import Foundation

let noneID = "defaultID"

let kTLWorkspacesExample =
"""
[
  {
    "id": "workspace1",
    "name": "ToDo",
    "bigCategories": [
      { "id": "defaultID", "title": "なし" },
    ],
    "smallCategories": {
      "defaultID": [],
    },
    "categoryIDToToDos": {
      "defaultID": {
        "toDosInToday": [
          {
            "id": "todo1",
            "title": "パスタ",
            "isChecked": false,
            "steps": [
              { "id": "step1", "title": "スパゲッティ", "isChecked": false },
              { "id": "step2", "title": "オリーブオイル", "isChecked": false }
            ]
          }
        ],
        "toDosInWhenever": []
      }
    }
  }
]
""";
