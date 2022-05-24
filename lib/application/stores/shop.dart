import 'package:album/application/events/shop/purchase_canceled.dart';
import 'package:album/application/events/shop/purchase_completed.dart';
import 'package:album/application/events/shop/purchase_pending.dart';
import 'package:album/application/events/shop/list_of_item_found.dart';
import 'package:album/application/models/common/argument.dart';
import 'package:album/application/models/shop/item.dart';
import 'package:codux/codux.dart';

class ShopStore extends Store<List<ShopItemModel>> {
  ShopStore() {
    on<ListOfShopItemFound>((current, event) {
      return event.model;
    });
    on<PurchasePending>((current, event) {
      return current.state.map((e) {
        if (e.details.id != event.id) {
          return e;
        }

        return e.copy(isPending: const New(true));
      }).toList();
    });
    on<PurchaseCompleted>((current, event) {
      return current.state.map((e) {
        if (e.details.id != event.id) {
          return e;
        }

        return e.copy(isPending: const New(false));
      }).toList();
    });
    on<PurchaseCanceled>((current, event) {
      return current.state.map((e) {
        if (e.details.id != event.id) {
          return e;
        }

        return e.copy(isPending: const New(false));
      }).toList();
    });
  }
}
