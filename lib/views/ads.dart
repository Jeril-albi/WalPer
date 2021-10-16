import 'package:flutter/cupertino.dart';
import 'package:unity_ads_plugin/unity_ads.dart';
import 'package:wallper/data/data.dart';

class Ads {
  void initialize() {
    UnityAds.init(gameId: '4408614', testMode: false);
  }

  showBanner() {
    return UnityBannerAd(placementId: 'Banner_Android');
  }

  void showInter(BuildContext context) {
    if (isPurchased) {
      return null;
    } else {
      UnityAds.showVideoAd(placementId: 'Interstitial_Android');
    }
  }
}
