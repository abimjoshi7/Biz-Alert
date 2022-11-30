import 'dart:developer';

import 'package:google_mobile_ads/google_mobile_ads.dart';

final BannerAd myBanner = BannerAd(
  // adUnitId: 'ca-app-pub-1156120899849802/2379710897',
  adUnitId: 'ca-app-pub-3940256099942544/6300978111',
  size: AdSize.banner,
  request: const AdRequest(),
  listener: const BannerAdListener(),
);

const AdSize adSize = AdSize(height: 50, width: 300);

final BannerAdListener listener = BannerAdListener(
  // Called when an ad is successfully received.
  onAdLoaded: (Ad ad) => log('Ad loaded.'),
  // Called when an ad request failed.
  onAdFailedToLoad: (Ad ad, LoadAdError error) {
    // Dispose the ad here to free resources.
    ad.dispose();
    log('Ad failed to load: $error');
  },
  // Called when an ad opens an overlay that covers the screen.
  onAdOpened: (Ad ad) => log('Ad opened.'),
  // Called when an ad removes an overlay that covers the screen.
  onAdClosed: (Ad ad) => log('Ad closed.'),
  // Called when an impression occurs on the ad.
  onAdImpression: (Ad ad) => log('Ad impression.'),
);
