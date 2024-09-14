import WidgetKit
import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller = window?.rootViewController as! FlutterViewController
        let channel = FlutterMethodChannel(name: "com.akitora0703.todaylist/sample", binaryMessenger: controller.binaryMessenger)
        
        let userdefaults = UserDefaults(suiteName: "group.akitora0703.todo")
        
        channel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in
            if (call.method == "updateWorkspaceCategories") {
                // 引数からStringを取り出す
//                if let stringWorkspaceCategories = call.arguments as? String {
//                    
//                    // UserDefaultsに保存
//                    userdefaults?.set(stringWorkspaceCategories, forKey: "workspaceCategories")
//                    result("workspaceCategories saved successfully")
//                } else {
//                    result(FlutterError(code: "INVALID_ARGUMENT", message: "Expected a String", details: nil))
//                }
            } else if call.method == "updateIdToJsonWorkspaceList" {
                // 引数からStringを取り出す
                if let stringOfStringWorkspaces = call.arguments as? String {
                    // UserDefaultsに保存
                    userdefaults?.set(stringOfStringWorkspaces, forKey: "idToJsonWorkspaceList")
                    WidgetCenter.shared.reloadAllTimelines()
                    result("idToJsonWorkspaceList saved successfully")
                } else {
                    result(FlutterError(code: "INVALID_ARGUMENT", message: "Expected a String", details: nil))
                }
                
            } else if call.method == "updateSelectedTheme" {
                // 引数からStringを取り出す
                if let selectedTheme = call.arguments as? String {
                    print(selectedTheme)
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
