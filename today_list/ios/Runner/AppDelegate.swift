import Flutter
import WidgetKit
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller = window?.rootViewController as! FlutterViewController
        
        let userdefaults = UserDefaults(suiteName: "group.akitorahayashi.todayListGroup")
        
    // --- showTodosInAWorkspaceWidget
        let showTodosInAWorkspaceWidgetMethodChannel = FlutterMethodChannel(name: "com.akitora0703.todaylist/show_todos_in_a_workspace_widget", binaryMessenger: controller.binaryMessenger)
        
        showTodosInAWorkspaceWidgetMethodChannel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in
            if call.method == "updateTLWorkspaces" {
                // 引数からStringを取り出す
                if let stringOfStringWorkspaces = call.arguments as? String {
                    // UserDefaultsに保存
                    userdefaults?.set(stringOfStringWorkspaces, forKey: "jsonWorksapces")
                    WidgetCenter.shared.reloadAllTimelines()
                    result("worksapces saved successfully")
                } else {
                    result(FlutterError(code: "INVALID_ARGUMENT", message: "Expected a String", details: nil))
                }
                
            } else if call.method == "updateSelectedTheme" {
                // 引数からStringを取り出す
                if let selectedTheme = call.arguments as? String {
                    // UserDefaultsに保存
                    userdefaults?.set(selectedTheme, forKey: "selectedTheme")
                    WidgetCenter.shared.reloadAllTimelines()
                    result("selectedTheme saved successfully")
                } else {
                    result(FlutterError(code: "INVALID_ARGUMENT", message: "Expected a String", details: nil))
                }
                
            } else {
                result(FlutterMethodNotImplemented)
            }
        }
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
