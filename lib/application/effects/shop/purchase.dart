import 'package:album/application/events/shop/purchase_requested.dart';
import 'package:codux/codux.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class PurchaseEffect extends Effect {
  PurchaseEffect() {
    on<PurchaseRequested>((event) async {
      final param = PurchaseParam(productDetails: event.details);

      InAppPurchase.instance.buyConsumable(purchaseParam: param);
    });
  }
}
