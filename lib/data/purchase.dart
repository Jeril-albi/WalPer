import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:wallper/data/data.dart';

class PurchaseApi {
  static const _apiKey = 'OELArOVnUVNXOiCTKlgqNFLweDtwxyri';

  static Future init() async {
    await Purchases.setDebugLogsEnabled(true);
    await Purchases.setup(_apiKey);
    updatePurchaseStatus();
  }

  static Future<List<Offering>> fetchOffers() async {
    try {
      final offerings = await Purchases.getOfferings();
      final current = offerings.current;

      return current == null ? [] : [current];
    } on PlatformException catch (e) {
      return [];
    }
  }

  static Future<bool> purchasePackage(Package package) async {
    try {
      await Purchases.purchasePackage(package);
      updatePurchaseStatus();
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future updatePurchaseStatus() async {
    try {
      final purchaseinfo = await Purchases.getPurchaserInfo();
      if (purchaseinfo.entitlements.all['weekly_ad_blocker'].isActive) {
        isPurchased = true;
        page = '80';
      }
    } on PlatformException catch (e) {}
  }
}
