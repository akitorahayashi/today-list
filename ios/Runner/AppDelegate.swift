import Flutter
import UIKit
import WidgetKit

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller = window?.rootViewController as! FlutterViewController
        
        let userdefaults = UserDefaults(suiteName: "group.akitorahayashi.todayListGroup")
        
        let toDosInCategoryWidgetKind: String = "ToDosInCategoryWidget"
        
        // --- TodosInCategoryWidget
        let todosInCategoryWidgetMethodChannel = FlutterMethodChannel(name: "com.akitora0703.todaylist/todos_in_category_widget", binaryMessenger: controller.binaryMessenger)
        
        todosInCategoryWidgetMethodChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
            switch call.method {
            case "updateTLWorkspaces":
                if let tlWorkspacesString = call.arguments as? String {
                    userdefaults?.set(tlWorkspacesString, forKey: "tlWorkspaces")
                    // メインスレッドでの更新を追加
                    DispatchQueue.main.async {
                        WidgetCenter.shared.reloadTimelines(ofKind: toDosInCategoryWidgetKind)
                    }
                    result("workspaces saved successfully")
                } else {
                    let errorMessage = "Expected a String for updateTLWorkspaces"
                    print(errorMessage) // Log error
                    result(FlutterError(code: "INVALID_ARGUMENT", message: errorMessage, details: nil))
                }
            case "updateListOfToDosInCategoryWidgetSettings":
                if let stringListOfToDosInCategoryWidgetSettings = call.arguments as? String {
                    userdefaults?.set(stringListOfToDosInCategoryWidgetSettings, forKey: "listOfToDosInCategoryWidgetSettings")
                    // メインスレッドでの更新を追加
                    DispatchQueue.main.async {
                        WidgetCenter.shared.reloadTimelines(ofKind: toDosInCategoryWidgetKind)
                    }
                    result("ListOfToDosInCategoryWidgetSettings saved successfully")
                } else {
                    let errorMessage = "Expected a String for ListOfToDosInCategoryWidgetSettings"
                    print(errorMessage) // Log error
                    result(FlutterError(code: "INVALID_ARGUMENT", message: errorMessage, details: nil))
                }
                
            case "updateSelectedTheme":
                if let selectedTheme = call.arguments as? String {
                    userdefaults?.set(selectedTheme, forKey: "selectedThemeName")
                    // メインスレッドでの更新を追加
                    DispatchQueue.main.async {
                        WidgetCenter.shared.reloadTimelines(ofKind: toDosInCategoryWidgetKind)
                    }
                    result("selectedTheme saved successfully")
                } else {
                    let errorMessage = "Expected a String for updateSelectedTheme"
                    print(errorMessage) // Log error
                    result(FlutterError(code: "INVALID_ARGUMENT", message: errorMessage, details: nil))
                }
                
            default:
                result(FlutterMethodNotImplemented)
            }
        }
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
