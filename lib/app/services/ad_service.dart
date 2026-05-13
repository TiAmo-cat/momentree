import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdService {
  static const _androidBannerAdUnitId =
      'ca-app-pub-4102294727858954/7071029166';
  static const _androidRewardedAdUnitId =
      'ca-app-pub-4102294727858954/5218891448';

  static const _testAndroidBannerAdUnitId =
      'ca-app-pub-3940256099942544/6300978111';
  static const _testAndroidRewardedAdUnitId =
      'ca-app-pub-3940256099942544/5224354917';
  static const _testIosBannerAdUnitId =
      'ca-app-pub-3940256099942544/2934735716';
  static const _testIosRewardedAdUnitId =
      'ca-app-pub-3940256099942544/1712485313';

  static const bool useRealAds = bool.fromEnvironment('USE_REAL_ADS');

  static bool get isSupportedPlatform {
    if (kIsWeb) return false;
    return defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS;
  }

  static Future<InitializationStatus>? initialize() {
    if (!isSupportedPlatform) return null;
    return MobileAds.instance.initialize();
  }

  static String? get bannerAdUnitId {
    if (!isSupportedPlatform) return null;
    if (defaultTargetPlatform == TargetPlatform.android) {
      return useRealAds ? _androidBannerAdUnitId : _testAndroidBannerAdUnitId;
    }
    return _testIosBannerAdUnitId;
  }

  static String? get rewardedAdUnitId {
    if (!isSupportedPlatform) return null;
    if (defaultTargetPlatform == TargetPlatform.android) {
      return useRealAds
          ? _androidRewardedAdUnitId
          : _testAndroidRewardedAdUnitId;
    }
    return _testIosRewardedAdUnitId;
  }
}
