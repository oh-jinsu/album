import 'package:album/application/models/shop/item.dart';
import 'package:codux/codux.dart';

class ListOfShopItemFound implements Event {
  final List<ShopItemModel> model;

  const ListOfShopItemFound(this.model);
}
