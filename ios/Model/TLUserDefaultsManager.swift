//
//  TLUserDefaultsManager.swift
//  Runner
//
//  Created by 林 明虎 on 2025/02/13.
//

import Foundation
import WidgetKit

final class TLUserDefaultsManager {
    static let shared = TLUserDefaultsManager()
    
    let userDefaults: UserDefaults?
    
    private init() {
        self.userDefaults = UserDefaults(suiteName: "group.akitorahayashi.todayListGroup")
    }
}
