import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart'; // 本番環境の判定に使用

enum TLAdUnitType {
  editPageBanner(
    iosAdUnitId: 'IOS_EDIT_PAGE_BANNER_AD_UNIT_ID',
    androidAdUnitId: 'ANDROID_EDIT_PAGE_BANNER_AD_UNIT_ID',
  ),
  setFeaturesBanner(
    iosAdUnitId: 'IOS_SET_FEATURES_BANNER_AD_UNIT_ID',
    androidAdUnitId: 'ANDROID_SET_FEATURES_BANNER_AD_UNIT_ID',
  ),
  iconRewarded(
    iosAdUnitId: 'IOS_CHECKBOX_ICON_REWARDED_AD_UNIT_ID',
    androidAdUnitId: 'ANDROID_CHECKBOX_ICON_REWARDED_AD_UNIT_ID',
  ),
  testBanner(
    iosAdUnitId: 'IOS_BANNER_AD_UNIT_ID_TEST',
    androidAdUnitId: 'ANDROID_BANNER_AD_UNIT_ID_TEST',
  ),
  testReward(
    iosAdUnitId: 'IOS_REWARDED_AD_UNIT_ID_TEST',
    androidAdUnitId: 'ANDROID_REWARDED_AD_UNIT_ID_TEST',
  );

  final String iosAdUnitId;
  final String androidAdUnitId;

  const TLAdUnitType({
    required this.iosAdUnitId,
    required this.androidAdUnitId,
  });

  bool get isRewarded =>
      this == TLAdUnitType.testReward || name.contains('Rewarded');

  String getAdUnitId({required bool isTestMode}) {
    final envKey =
        isTestMode ? _getTestPlatformAdUnitId() : _getPlatformAdUnitId();

    if (!kReleaseMode) {
      print('AdUnitType: $this');
      print('Platform: ${Platform.isIOS ? "iOS" : "Android"}');
      print('isTestMode: $isTestMode');
      print('Resolved envKey: $envKey');
    }

    final adUnitId = dotenv.env[envKey];

    if (adUnitId == null) {
      if (!kReleaseMode) {
        print('Error: AdUnitId not found in dotenv for key: $envKey');
      }
      throw Exception('AdUnitId not found in dotenv for key: $envKey');
    }

    if (!kReleaseMode) {
      print('Loaded AdUnitId: $adUnitId');
    }
    return adUnitId;
  }

  String _getPlatformAdUnitId() {
    final key = Platform.isIOS ? iosAdUnitId : androidAdUnitId;
    if (!kReleaseMode) {
      print('_getPlatformAdUnitId resolved key: $key');
    }
    return key;
  }

  String _getTestPlatformAdUnitId() {
    final key = isRewarded
        ? TLAdUnitType.testReward._getPlatformAdUnitId()
        : TLAdUnitType.testBanner._getPlatformAdUnitId();
    if (!kReleaseMode) {
      print('_getTestPlatformAdUnitId resolved key: $key');
    }
    return key;
  }
}
