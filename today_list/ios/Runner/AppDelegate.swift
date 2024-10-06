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
            switch call.method {
            case "updateTLWorkspaces":
                if let stringOfStringWorkspaces = call.arguments as? String {
                    userdefaults?.set(stringOfStringWorkspaces, forKey: "jsonWorkspaces") // Fixed typo
                    WidgetCenter.shared.reloadAllTimelines()
                    result("workspaces saved successfully")
                } else {
                    let errorMessage = "Expected a String for updateTLWorkspaces"
                    print(errorMessage) // Log error
                    result(FlutterError(code: "INVALID_ARGUMENT", message: errorMessage, details: nil))
                }
                
            case "updateSelectedTheme":
                if let selectedTheme = call.arguments as? String {
                    userdefaults?.set(selectedTheme, forKey: "selectedTheme")
                    WidgetCenter.shared.reloadAllTimelines()
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
