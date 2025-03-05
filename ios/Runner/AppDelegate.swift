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
        
        // MARK: - ToDos In Category Widgetの処理
        let tcwMethodChannel = FlutterMethodChannel(
            name: "com.akitora0703.todaylist.methodChannel",
            binaryMessenger: controller.binaryMessenger
        )
        
        tcwMethodChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
            guard let arguments = call.arguments as? String else {
                let errorMessage = "Expected a String for \(call.method)"
                print(errorMessage)
                result(FlutterError(code: "INVALID_ARGUMENT", message: errorMessage, details: nil))
                return
            }
            
            let uctKind: String = "UnCategorizedToDosInWorkspaceWidget"
            
            switch call.method {
            case "updateTLWorkspaces":
                self.updateTLWorkspaces(arguments)
                self.reloadWidget(uctKind)
                result("workspaces saved successfully")
                
            case "updateSelectedTheme":
                self.updateSelectedTheme(arguments)
                self.reloadWidget(uctKind)
                result("selectedTheme saved successfully")
                
            default:
                result(FlutterMethodNotImplemented)
            }
        }
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private func updateTLWorkspaces(_ value: String) {
        TLUserDefaultsManager.shared.userDefaults?.set(value, forKey: "tlWorkspaces")
    }
    
    private func updateSelectedTheme(_ value: String) {
        TLUserDefaultsManager.shared.userDefaults?.set(value, forKey: "selectedThemeName")
    }
    
    /// ウィジェットの更新
    private func reloadWidget(_ widgetKind: String) {
        DispatchQueue.main.async {
            WidgetCenter.shared.reloadTimelines(ofKind: widgetKind)
        }
    }
}
