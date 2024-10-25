import 'package:flutter/material.dart';
import 'package:today_list/model/external/tl_connectivity.dart';
import 'package:today_list/model/external/tl_vibration.dart';
import 'model/workspace/tl_workspace.dart';
import './constants/global_keys.dart';
import 'model/user/setting_data.dart';
import 'model/external/tl_ads.dart';
import './app.dart';

import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

bool kAdTestMode = true;
bool kDebugMode = true;

enum LanguageType { ja, en }

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  try {
    print('Loading .env file...');
    await dotenv.load(fileName: ".env");
    print('.env file loaded successfully');
  } catch (e, stackTrace) {
    print('Failed to load .env file: ${e.toString()}');
    print('Stack trace: $stackTrace');
  }
  await TLAds.initializeTLAds();
  await TLWorkspace.readWorkspaces();
  await SettingData.shared.readSettings();
  await TLVibration.initVibrate();
  await TLConnectivity.initializeConnectivity();
  // await todayListUser.initializeFirebase();
  runApp(TodayList(key: todayListAppKey));
}
