import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:wallper/data/data.dart';

class Ads {
  static BannerAd _bannerAd ;
   InterstitialAd _interstitialAd;
   RewardedAd _rewardedAd;


  static void initialize(){
    MobileAds.instance.initialize();
  }
  static AdRequest request = AdRequest(
    keywords: <String>['wallpapers','mobile apps','wallpaper apps','games','personalisation','customization','user interface','photo apps','photography','editing apps','mobile ads'],
    nonPersonalizedAds: true,
  );

   static AdWidget adWidget = AdWidget(ad: _bannerAd);

 static bool isAdLoaded;
  static BannerAd mybanner = isPurchased ? null : BannerAd(
    adUnitId: "ca-app-pub-3403270527076927/5885646025",
    //adUnitId: BannerAd.testAdUnitId,
    size: AdSize.banner,
    request: request,
    listener: BannerAdListener(
      onAdLoaded: (ad){
        isAdLoaded = true;
      },
      onAdFailedToLoad: (ad,error){
        print("Ad failed to load $error");
      },
    ),
  );

    showBanner(){
    return Container(
      alignment: Alignment.center,
      height: mybanner.size.height.toDouble(),
      width: mybanner.size.width.toDouble(),
      child: AdWidget(ad: mybanner,),
    );
  }

   void  loadInter() {
      if(isPurchased){
        return null;
      } else {
        InterstitialAd.load(
          adUnitId: 'ca-app-pub-3403270527076927/6497047784',
            //adUnitId: InterstitialAd.testAdUnitId,
            request: request,
            adLoadCallback: InterstitialAdLoadCallback(
              onAdLoaded: (ad) {
                this._interstitialAd = ad;
              },
              onAdFailedToLoad: (error) {
                loadInter();
              },
            )
        );
      }
   }

   void showInter() {
    if(_interstitialAd == null)  loadInter();
    _interstitialAd.show();
  }

  void closeInter(){
     _interstitialAd?.dispose();
  }

  void loadReward(){
      if(isPurchased){
        return null;
      }else{
    RewardedAd.load(
      adUnitId: 'ca-app-pub-3403270527076927/6565330545',
     // adUnitId: RewardedAd.testAdUnitId,
      request: request,
      rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (ad){this._rewardedAd = ad;},
          onAdFailedToLoad: (error){loadReward();}
      )
    );
      }
  }

  void closeReward(){
     _rewardedAd?.dispose();
  }
}
