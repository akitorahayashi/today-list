import 'package:today_list/model/todo/tl_workspace.dart';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_watch_os_connectivity/flutter_watch_os_connectivity.dart';

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

  static Future<void> sendSelectedThemeToAppleWatch(
      {required int selectedThemeIndex}) async {
    if (Platform.isIOS) {
      bool isReachable = await TLConnectivity.connectivity.getReachability();
      if (isReachable) {
        print("start to send selectedTheme to Apple Watch");
        await TLConnectivity.connectivity
            .sendMessage({"selectedTheme": selectedThemeIndex});
      } else {
        print("sendSelectedTheme: No reachable watches.");
      }
    }
  }

  static Future<void> sendTLWorkspacesToAppleWatch(
      {required List<TLWorkspace> tlWorkspaces}) async {
    if (Platform.isIOS) {
      bool isReachable = await TLConnectivity.connectivity.getReachability();
      if (isReachable) {
        final List<Map<String, dynamic>> _jsonWorkspaces =
            tlWorkspaces.map((workspace) => workspace.toJson()).toList();
        await TLConnectivity.connectivity
            .sendMessage({"tlWorkspaces": json.encode(_jsonWorkspaces)});
      } else {
        print("sendSelectedTheme: No reachable watches.");
      }
    }
  }
}
