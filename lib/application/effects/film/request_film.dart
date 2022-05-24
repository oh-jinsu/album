import 'dart:async';

import 'package:album/application/effects/common/auth.dart';
import 'package:album/application/events/app/dialog_requested.dart';
import 'package:album/application/events/film/counted.dart';
import 'package:album/application/events/shop/purchase_canceled.dart';
import 'package:album/application/events/shop/purchase_completed.dart';
import 'package:album/application/events/shop/purchase_pending.dart';
import 'package:album/infrastructure/services/client/response.dart';
import 'package:codux/codux.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class RequestFilmEffect extends Effect with AuthEffectMixin {
  late final StreamSubscription subscription;

  RequestFilmEffect() {
    subscription = InAppPurchase.instance.purchaseStream.listen((event) async {
      for (final purchase in event) {
        if (purchase.status == PurchaseStatus.pending) {
          return dispatch(PurchasePending(purchase.productID));
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

            dispatch(PurchaseCompleted(purchase.productID));
          } else {
            dispatch(const DialogRequested("예기치 못한 오류입니다."));

            dispatch(PurchaseCanceled(purchase.productID));
          }
        } else {
          dispatch(PurchaseCanceled(purchase.productID));
        }

        InAppPurchase.instance.completePurchase(purchase);
      }
    });
  }

  @override
  void onDispose() {
    subscription.cancel();

    super.onDispose();
  }
}
