import 'package:json_annotation/json_annotation.dart';
import 'adjustment.dart';
import 'tax.dart';

part 'line_item.g.dart';

/// Represents a line item in a cart or order
@JsonSerializable(fieldRename: FieldRename.snake)
class LineItem {
  final String id;
  final String title;
  final int quantity;
  final int unitPrice;
  final bool? requiresShipping;
  final bool? isDiscountable;
  final bool? isGiftcard;
  final bool? isTaxInclusive;
  final bool? isCustomPrice;
  final int? compareAtUnitPrice;
  final int? originalUnitPrice;
  final int? subtotal;
  final int? discountTotal;
  final int? total;
  final int? originalTotal;
  final int? taxTotal;
  final int? rawDiscountTotal;
  final int? refundable;
  final String? cartId;
  final String? orderId;
  final String? swapId;
  final String? claimOrderId;
  final String? subtitle;
  final String? thumbnail;
  final String? variantId;
  final String? productId;
  final String? productTitle;
  final String? productDescription;
  final String? productSubtitle;
  final String? productType;
  final String? productTypeId;
  final String? productCollection;
  final String? productHandle;
  final String? variantSku;
  final String? variantBarcode;
  final String? variantTitle;
  final List<dynamic>? variantOptionValues;
  final Map<String, dynamic>? metadata;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Adjustment>? adjustments;
  final List<TaxLine>? taxLines;

  const LineItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.unitPrice,
    this.requiresShipping,
    this.isDiscountable,
    this.isGiftcard,
    this.isTaxInclusive,
    this.isCustomPrice,
    this.compareAtUnitPrice,
    this.originalUnitPrice,
    this.subtotal,
    this.discountTotal,
    this.total,
    this.originalTotal,
    this.taxTotal,
    this.rawDiscountTotal,
    this.refundable,
    this.cartId,
    this.orderId,
    this.swapId,
    this.claimOrderId,
    this.subtitle,
    this.thumbnail,
    this.variantId,
    this.productId,
    this.productTitle,
    this.productDescription,
    this.productSubtitle,
    this.productType,
    this.productTypeId,
    this.productCollection,
    this.productHandle,
    this.variantSku,
    this.variantBarcode,
    this.variantTitle,
    this.variantOptionValues,
    this.metadata,
    this.createdAt,
    this.updatedAt,
    this.adjustments,
    this.taxLines,
  });

  factory LineItem.fromJson(Map<String, dynamic> json) =>
      _$LineItemFromJson(json);
  Map<String, dynamic> toJson() => _$LineItemToJson(this);
}
