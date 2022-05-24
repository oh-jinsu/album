import 'package:codux/codux.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class PurchaseRequested implements Event {
  final ProductDetails details;

  const PurchaseRequested(this.details);
}
