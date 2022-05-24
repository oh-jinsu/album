import 'package:album/application/events/bootstrap/bootstrap_finished.dart';
import 'package:album/application/events/shop/list_of_item_found.dart';
import 'package:album/application/models/shop/item.dart';
import 'package:codux/codux.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class FetchListOfShopItemEffect extends Effect {
  FetchListOfShopItemEffect() {
    on<AppReady>((event) async {
      const manifest = {"10film", "25film", "50film", "100film"};

      final response =
          await InAppPurchase.instance.queryProductDetails(manifest);

      final products = response.productDetails;

      products.sort((a, b) => a.rawPrice.compareTo(b.rawPrice));

      final model = products
          .map((e) => ShopItemModel(isPending: false, details: e))
          .toList();

      dispatch(ListOfShopItemFound(model));
    });
  }
}
