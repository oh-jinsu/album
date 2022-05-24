import 'package:codux/codux.dart';

class ShopItemCompleted implements Event {
  final String id;

  const ShopItemCompleted(this.id);
}
