import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/external/tl_connectivity.dart';
import 'package:today_list/model/external/tl_vibration.dart';
import 'package:today_list/model/user/setting_data.dart';
import 'model/external/tl_ads.dart';
import './app.dart';

import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

bool kAdTestMode = true;
bool kDebugMode = true;

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await dotenv.load(fileName: ".env");
  await SettingData.readSettingData();
  await TLAds.initializeTLAds();
  await TLVibration.initVibrate();
  await TLConnectivity.initializeConnectivity();
  runApp(const ProviderScope(
    child: TodayListApp(),
  ));
}
