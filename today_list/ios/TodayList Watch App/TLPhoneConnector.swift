//
//  TLPhoneConnector.swift
//  Runner
//
//  Created by 林 明虎 on 2024/10/05.
//

import SwiftUI
import WatchConnectivity


class TLPhoneConnector: NSObject, ObservableObject, WCSessionDelegate  {
    static let shared = TLPhoneConnector()
    
    @Published var selectedTheme: String = "Sun Orange"
    @Published var decodedTLWorkspace: [TLWorkspace] = []
    
    override init() {
        super.init()
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            
            WCSession.default.activate()
        }
    }
    
    // iPhoneへデータを送信するメソッド
    func sendMessageToPhone(_ data: [String: Any]) {
        if WCSession.default.isReachable {
            WCSession.default.sendMessage(data, replyHandler: nil) { error in
                print("Error sending message: \(error.localizedDescription)")
            }
        } else {
            print("iPhone is not reachable")
        }
    }
    
    // --- session
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("activationDidCompleteWith state= \(activationState.rawValue)")
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("didReceiveMessage: \(message)")
        //         受け取ったメッセージを取り出す
        if let receivedSelectedtheme = message["selectedTheme"] as? String {
            DispatchQueue.main.async {
                self.selectedTheme = receivedSelectedtheme
            }
            //結果
            print("watchOS: selectedtheme saved successfully")
        } else if let strTLWorkspaces = message["tlWorkspaces"] as? String {
            DispatchQueue.main.async {
                self.decodedTLWorkspace = TLWorkspace.decodeWorkspaces(from: strTLWorkspaces) ?? []
            }
            print("watchOS: tlWorkspaces saved successfully")
        } else {
            print("watchOS: message was not saved")
        }
    }
    
#if os(iOS)
    func sessionDidBecomeInactive(_ session: WCSession) {
        // セッションが非アクティブになった時の処理
        print("sessionDidBecomeInactive")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        // セッションが無効化された時の処理
        print("sessionDidDeactivate")
        WCSession.default.activate()
    }
#endif
}
