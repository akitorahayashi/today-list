import 'package:flutter_watch_os_connectivity/flutter_watch_os_connectivity.dart';

class TLConnectivity {
  static final FlutterWatchOsConnectivity connectivity =
      FlutterWatchOsConnectivity();

  static Future<void> sendJsonToAppleWatch() async {
    bool isReachable = await TLConnectivity.connectivity.getReachability();
    if (isReachable) {
      await TLConnectivity.connectivity
          .sendMessage({"message": "Hello from Flutter!"});
    } else {
      print("No reachable watches.");
    }
  }
}
