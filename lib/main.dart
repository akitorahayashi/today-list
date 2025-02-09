import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/service/tl_connectivity.dart';
import 'package:today_list/service/tl_vibration.dart';
import 'service/tl_ads.dart';
import './app.dart';

import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

bool kAdTestMode = true;
bool kDebugMode = true;

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await dotenv.load(fileName: ".env");
  await TLAdsService.initializeTLAds();
  await TLVibrationService.initVibrate();
  // await TLConnectivityService.initializeConnectivity();
  runApp(const ProviderScope(
    child: TodayListApp(),
  ));
}
