import 'package:json_annotation/json_annotation.dart';
import 'address.dart';
import 'region.dart';
import 'line_item.dart';
import 'shipping.dart';
import 'store_commerce.dart' show StoreCartPromotion;

part 'cart.g.dart';

/// Represents a shopping cart in the Medusa Store API
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Cart {
  final String id;
  final String? currencyCode;
  final int? originalItemTotal;
  final int? originalItemSubtotal;
  final int? originalItemTaxTotal;
  final int? itemTotal;
  final int? itemSubtotal;
  final int? itemTaxTotal;
  final int? originalTotal;
  final int? originalSubtotal;
  final int? originalTaxTotal;
  final int? total;
  final int? subtotal;
  final int? taxTotal;
  final int? discountTotal;
  final int? discountTaxTotal;
  final int? giftCardTotal;
  final int? giftCardTaxTotal;
  final int? shippingTotal;
  final int? shippingSubtotal;
  final int? shippingTaxTotal;
  final int? originalShippingTotal;
  final int? originalShippingSubtotal;
  final int? originalShippingTaxTotal;
  final List<StoreCartPromotion>? promotions;
  final String? regionId;
  final String? customerId;
  final String? salesChannelId;
  final String? email;
  final Map<String, dynamic>? metadata;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Address? shippingAddress;
  final Address? billingAddress;
  final List<LineItem>? items;
  final List<ShippingMethod>? shippingMethods;
  final Region? region;

  const Cart({
    required this.id,
    this.currencyCode,
    this.originalItemTotal,
    this.originalItemSubtotal,
    this.originalItemTaxTotal,
    this.itemTotal,
    this.itemSubtotal,
    this.itemTaxTotal,
    this.originalTotal,
    this.originalSubtotal,
    this.originalTaxTotal,
    this.total,
    this.subtotal,
    this.taxTotal,
    this.discountTotal,
    this.discountTaxTotal,
    this.giftCardTotal,
    this.giftCardTaxTotal,
    this.shippingTotal,
    this.shippingSubtotal,
    this.shippingTaxTotal,
    this.originalShippingTotal,
    this.originalShippingSubtotal,
    this.originalShippingTaxTotal,
    this.promotions,
    this.regionId,
    this.customerId,
    this.salesChannelId,
    this.email,
    this.metadata,
    this.createdAt,
    this.updatedAt,
    this.shippingAddress,
    this.billingAddress,
    this.items,
    this.shippingMethods,
    this.region,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);
  Map<String, dynamic> toJson() => _$CartToJson(this);

  /// Get the number of items in the cart
  int get itemCount => items?.length ?? 0;

  /// Check if cart is empty
  bool get isEmpty => itemCount == 0;

  /// Check if cart has items
  bool get hasItems => itemCount > 0;
}
