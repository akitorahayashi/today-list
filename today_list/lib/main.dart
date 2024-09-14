import 'package:flutter/material.dart';
import 'package:today_list/model/externals/tl_vibration.dart';
import 'model/workspace/workspace.dart';
import './constants/global_keys.dart';
import 'model/user/setting_data.dart';
import 'model/externals/tl_ads.dart';
import 'model/tl_category.dart';
import './model/user/todaylist_user.dart';
import './app.dart';

import 'package:flutter_native_splash/flutter_native_splash.dart';

bool adTestMode = true;

enum LanguageType { ja, en }

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Workspace.readWorkspaces();
  await TLAds.initializeTLAds();
  await settingData.readSettings();
  await TLVibration.initVibrate();
  await TLCategory.readWorkspaceCategories();
  await todayListUser.initializeFirebase();
  // await MobileAds.instance.initialize();
  runApp(TodayList(key: todayListAppKey));
}
