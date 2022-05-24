import 'dart:async';

import 'package:album/application/effects/common/auth.dart';
import 'package:album/application/events/app/dialog_requested.dart';
import 'package:album/application/events/film/counted.dart';
import 'package:album/application/events/shop/item_completed.dart';
import 'package:album/application/events/shop/item_pending.dart';
import 'package:album/infrastructure/services/client/response.dart';
import 'package:codux/codux.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class RequestFilmEffect extends Effect with AuthEffectMixin {
  late final StreamSubscription subscription;

  RequestFilmEffect() {
    subscription = InAppPurchase.instance.purchaseStream.listen((event) async {
      for (final purchase in event) {
        if (purchase.status == PurchaseStatus.pending) {
          return dispatch(ShopItemPending(purchase.productID));
        }

        if (purchase.status == PurchaseStatus.purchased) {
          final id = purchase.productID;

          final source = purchase.verificationData.source;

          final verification = purchase.verificationData.serverVerificationData;

          final response = await withAuth(
            (client) => client.body({
              "product_id": id,
              "source": source,
              "token": verification,
            }).post("film"),
          );

          if (response is SuccessResponse) {
            final count = response.body["count"];

            dispatch(FilmCounted(count));
          } else {
            dispatch(const DialogRequested("예기치 못한 오류입니다."));
          }
        }

        InAppPurchase.instance.completePurchase(purchase);

        dispatch(ShopItemCompleted(purchase.productID));
      }
    });
  }

  @override
  void onDispose() {
    subscription.cancel();

    super.onDispose();
  }
}
