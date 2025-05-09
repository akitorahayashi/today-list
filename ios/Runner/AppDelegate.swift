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

            let twKind = "ToDosInWorkspaceWidget"
            let ttKind = "ToDosInTodayWidget"

            switch call.method {
            case "updateTLWorkspaces":
                self.updateTLWorkspaces(arguments)
                self.reloadWidget(twKind)
                self.reloadWidget(ttKind)
                result("workspaces saved successfully")

            case "updateSelectedTheme":
                self.updateSelectedTheme(arguments)
                self.reloadWidget(twKind)
                self.reloadWidget(ttKind)
                result("selectedTheme saved successfully")

            case "changeAppIcon":
                let iconName = arguments // arguments is already cast to String
                // If iconName is empty or a specific keyword for default, pass nil
                let targetIconName = (iconName.isEmpty || iconName == "Notebook") ? nil : iconName

                // Check if alternate icons are supported
                if #available(iOS 10.3, *) {
                    guard UIApplication.shared.supportsAlternateIcons else {
                        print("Alternate icons not supported")
                        result(FlutterError(code: "UNSUPPORTED", message: "Alternate icons not supported on this device.", details: nil))
                        return
                    }

                    // Call setAlternateIconName
                    UIApplication.shared.setAlternateIconName(targetIconName) { error in
                        if let error = error {
                            print("Failed to change app icon: \(error.localizedDescription)")
                            result(FlutterError(code: "NATIVE_ERROR", message: "Failed to set alternate icon: \(error.localizedDescription)", details: nil))
                        } else {
                            print("App icon changed successfully to \(targetIconName ?? "Primary")")
                            result("App icon changed successfully")
                        }
                    }
                } else {
                    // Fallback on earlier versions
                    print("Alternate icons not supported below iOS 10.3")
                    result(FlutterError(code: "UNSUPPORTED", message: "Alternate icons require iOS 10.3 or later.", details: nil))
                }

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
