//
//  TLContentExample.swift
//  Runner
//
//  Created by 林 明虎 on 2024/10/05.
//

import Foundation

enum TLWorkspacesExample: String {
    case noneID = "defaultID"
    
    case kTLWorkspacesExample = """
[
  {
    "id": "defaultID",
    "name": "Default",
    "bigCategories": [
      { "id": "defaultID", "title": "なし" },
      { "id": "superMarcketId", "title": "スーパー" },
      { "id": "hundredStoreId", "title": "100均" }
    ],
    "smallCategories": {
      "defaultID": [],
      "superMarcketId": [
        { "id": "vegetableId", "title": "野菜" }
      ],
      "hundredStoreId": []
    },
    "categoryIDToToDos": {
      "defaultID": {
        "toDosInToday": [
          { "id": "todo1", "title": "のり", "isChecked": false, "steps": [] },
          { "id": "todo2", "title": "まくらカバー", "isChecked": false, "steps": [] }
        ],
        "toDosInWhenever": []
      },
      "superMarcketId": {
        "toDosInToday": [
          {
            "id": "todo3",
            "title": "パスタ",
            "isChecked": false,
            "steps": [
              { "id": "step1", "title": "パスタの束", "isChecked": false },
              { "id": "step2", "title": "オリーブオイル", "isChecked": false }
            ]
          }
        ],
        "toDosInWhenever": []
      },
      "vegetableId": {
        "toDosInToday": [
          { "id": "todo4", "title": "キャベツ", "isChecked": false, "steps": [] },
          { "id": "todo5", "title": "にんじん", "isChecked": false, "steps": [] }
        ],
        "toDosInWhenever": []
      },
      "hundredStoreId": {
        "toDosInToday": [
          { "id": "todo6", "title": "お皿", "isChecked": false, "steps": [] }
        ],
        "toDosInWhenever": []
      }
    }
  },
  {
    "id": "schoolWorksapceId",
    "name": "School",
    "bigCategories": [
      { "id": "defaultID", "title": "なし" },
      { "id": "mathId", "title": "数学" },
      { "id": "englishId", "title": "英語" }
    ],
    "smallCategories": {
      "defaultID": [],
      "mathId": [
        { "id": "mathAId", "title": "数学A" },
        { "id": "mathIId", "title": "数学I" }
      ],
      "englishId": []
    },
    "categoryIDToToDos": {
      "defaultID": {
        "toDosInToday": [
          { "id": "todo7", "title": "~のプリントを出す", "isChecked": false, "steps": [] }
        ],
        "toDosInWhenever": []
      },
      "mathId": {
        "toDosInToday": [],
        "toDosInWhenever": []
      },
      "mathAId": {
        "toDosInToday": [
          { "id": "todo8", "title": "~を復習する", "isChecked": false, "steps": [] },
          { "id": "todo9", "title": "ワーク12ページの宿題をやる", "isChecked": false, "steps": [] }
        ],
        "toDosInWhenever": []
      },
      "mathIId": {
        "toDosInToday": [
          { "id": "todo10", "title": "ドリル20~25ページ", "isChecked": false, "steps": [] }
        ],
        "toDosInWhenever": []
      },
      "englishId": {
        "toDosInToday": [
          { "id": "todo11", "title": "単語帳301~400", "isChecked": false, "steps": [] }
        ],
        "toDosInWhenever": []
      }
    }
  }
]
"""
}
