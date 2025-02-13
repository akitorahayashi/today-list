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
        let widgetKind = "ToDosInCategoryWidget"
        
        // MARK: - ToDos In Category Widgetの処理
        let tcwMethodChannel = FlutterMethodChannel(
            name: "com.akitora0703.todaylist/todos_in_category_widget",
            binaryMessenger: controller.binaryMessenger
        )
        
        tcwMethodChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
            guard let arguments = call.arguments as? String else {
                let errorMessage = "Expected a String for \(call.method)"
                print(errorMessage)
                result(FlutterError(code: "INVALID_ARGUMENT", message: errorMessage, details: nil))
                return
            }
            
            switch call.method {
                case "updateTLWorkspaces":
                    self.updateTLWorkspaces(arguments, widgetKind)
                    result("workspaces saved successfully")

                case "updateListOfToDosInCategoryWidgetSettings":
                    self.updateListOfToDosInCategoryWidgetSettings(arguments, widgetKind)
                    result("ListOfToDosInCategoryWidgetSettings saved successfully")

                case "updateSelectedTheme":
                    self.updateSelectedTheme(arguments, widgetKind)
                    result("selectedTheme saved successfully")

                default:
                    result(FlutterMethodNotImplemented)
            }
        }

        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    private func updateTLWorkspaces(_ value: String, _ widgetKind: String) {
        TLUserDefaultsManager.shared.userDefaults?.set(value, forKey: "tlWorkspaces")
        reloadWidget(widgetKind)
    }

    private func updateListOfToDosInCategoryWidgetSettings(_ value: String, _ widgetKind: String) {
        TLUserDefaultsManager.shared.userDefaults?.set(value, forKey: "listOfToDosInCategoryWidgetSettings")
        reloadWidget(widgetKind)
    }

    private func updateSelectedTheme(_ value: String, _ widgetKind: String) {
        TLUserDefaultsManager.shared.userDefaults?.set(value, forKey: "selectedThemeName")
        reloadWidget(widgetKind)
    }

    /// ウィジェットの更新
    private func reloadWidget(_ widgetKind: String) {
        DispatchQueue.main.async {
            WidgetCenter.shared.reloadTimelines(ofKind: widgetKind)
        }
    }
}
