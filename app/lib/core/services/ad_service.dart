import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdService {
  static InterstitialAd? _interstitialAd;
  static bool _isInterstitialLoading = false;

  // Official Google AdMob Test Ad Unit IDs
  static const String testBannerIdAndroid = 'ca-app-pub-3940256099942544/6300978111';
  static const String testBannerIdIOS = 'ca-app-pub-3940256099942544/2934735716';

  static const String testInterstitialIdAndroid = 'ca-app-pub-3940256099942544/1033173712';
  static const String testInterstitialIdIOS = 'ca-app-pub-3940256099942544/4411468910';

  static Future<void> initialize() async {
    try {
      await MobileAds.instance.initialize();
      loadInterstitialAd();
    } catch (e) {
      debugPrint('AdMob initialization error: $e');
    }
  }

  static void loadInterstitialAd() {
    if (_isInterstitialLoading || _interstitialAd != null) return;
    _isInterstitialLoading = true;

    final adUnitId = defaultTargetPlatform == TargetPlatform.iOS
        ? testInterstitialIdIOS
        : testInterstitialIdAndroid;

    InterstitialAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isInterstitialLoading = false;
          _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              _interstitialAd = null;
              loadInterstitialAd(); // Preload next
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
              _interstitialAd = null;
              loadInterstitialAd();
            },
          );
        },
        onAdFailedToLoad: (error) {
          _isInterstitialLoading = false;
          _interstitialAd = null;
          debugPrint('Interstitial failed to load: $error');
        },
      ),
    );
  }

  static void showInterstitialAd() {
    if (_interstitialAd != null) {
      _interstitialAd!.show();
    } else {
      loadInterstitialAd();
    }
  }
}
