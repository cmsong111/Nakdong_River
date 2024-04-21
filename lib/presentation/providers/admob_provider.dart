import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nakdong_river/ad_helper.dart';

class AdMobProvider extends ChangeNotifier {
  BannerAd? _bannerAd;
  BannerAd? get bannerAd => _bannerAd;

  AdMobProvider() {
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$ad loaded.');
          notifyListeners();
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('$ad failed to load: $error');
        },
        onAdOpened: (Ad ad) => print('$ad onAdOpened.'),
        onAdClosed: (Ad ad) => print('$ad onAdClosed.'),
        onAdWillDismissScreen: (ad) => print('$ad onAdWillDismissScreen.'),
        onAdImpression: (ad) => print('$ad impression occurred.'),
      ),
    );
    _bannerAd!.load();
  }
}
