import 'package:album/application/models/common/argument.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class ShopItemModel {
  final bool isPending;
  final ProductDetails details;

  const ShopItemModel({
    required this.isPending,
    required this.details,
  });

  ShopItemModel copy({
    New<bool>? isPending,
    New<ProductDetails>? details,
  }) {
    return ShopItemModel(
      isPending: isPending != null ? isPending.value : this.isPending,
      details: details != null ? details.value : this.details,
    );
  }
}
