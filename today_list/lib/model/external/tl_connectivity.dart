import 'package:flutter_watch_os_connectivity/flutter_watch_os_connectivity.dart';
import 'package:today_list/model/user/setting_data.dart';

import 'dart:convert';
import 'dart:io';

import 'package:today_list/model/workspace/tl_workspace_notifier.dart';

class TLConnectivity {
  static final FlutterWatchOsConnectivity connectivity =
      FlutterWatchOsConnectivity();

  static Future<void> initializeConnectivity() async {
    if (Platform.isIOS) {
      await TLConnectivity.connectivity.configureAndActivateSession();
      TLConnectivity.connectivity.activationStateChanged
          .listen((activationState) {
        // 現在のActivationStateを通知する
        if (activationState == ActivationState.activated) {
          print("activationDidCompleteWith state= ${activationState.name}");
        }
      });
    }
  }

  static Future<void> sendSelectedThemeToAppleWatch() async {
    if (Platform.isIOS) {
      bool isReachable = await TLConnectivity.connectivity.getReachability();
      if (isReachable) {
        print("start to send selectedTheme to Apple Watch");
        await TLConnectivity.connectivity.sendMessage(
            {"selectedTheme": SettingData.shared.selectedThemeIndex});
      } else {
        print("sendSelectedTheme: No reachable watches.");
      }
    }
  }

  static Future<void> sendTLWorkspacesToAppleWatch() async {
    if (Platform.isIOS) {
      bool isReachable = await TLConnectivity.connectivity.getReachability();
      if (isReachable) {
        await TLConnectivity.connectivity
            .sendMessage({"tlWorkspaces": json.encode(_initialTLWorkspaces)});
      } else {
        print("sendSelectedTheme: No reachable watches.");
      }
    }
  }
}
