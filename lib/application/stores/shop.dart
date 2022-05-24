import 'package:album/application/events/shop/item_completed.dart';
import 'package:album/application/events/shop/item_pending.dart';
import 'package:album/application/events/shop/list_of_item_found.dart';
import 'package:album/application/models/common/argument.dart';
import 'package:album/application/models/shop/item.dart';
import 'package:codux/codux.dart';

class ShopStore extends Store<List<ShopItemModel>> {
  ShopStore() {
    on<ListOfShopItemFound>((current, event) {
      return event.model;
    });
    on<ShopItemPending>((current, event) {
      return current.state.map((e) {
        if (e.details.id != event.id) {
          return e;
        }

        return e.copy(isPending: const New(true));
      }).toList();
    });
    on<ShopItemCompleted>((current, event) {
      return current.state.map((e) {
        if (e.details.id != event.id) {
          return e;
        }

        return e.copy(isPending: const New(false));
      }).toList();
    });
  }
}
