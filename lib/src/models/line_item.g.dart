// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'line_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LineItem _$LineItemFromJson(Map<String, dynamic> json) => LineItem(
  id: json['id'] as String,
  title: json['title'] as String,
  quantity: (json['quantity'] as num).toInt(),
  unitPrice: (json['unit_price'] as num).toInt(),
  requiresShipping: json['requires_shipping'] as bool?,
  isDiscountable: json['is_discountable'] as bool?,
  isGiftcard: json['is_giftcard'] as bool?,
  isTaxInclusive: json['is_tax_inclusive'] as bool?,
  isCustomPrice: json['is_custom_price'] as bool?,
  compareAtUnitPrice: (json['compare_at_unit_price'] as num?)?.toInt(),
  originalUnitPrice: (json['original_unit_price'] as num?)?.toInt(),
  subtotal: (json['subtotal'] as num?)?.toInt(),
  discountTotal: (json['discount_total'] as num?)?.toInt(),
  total: (json['total'] as num?)?.toInt(),
  originalTotal: (json['original_total'] as num?)?.toInt(),
  taxTotal: (json['tax_total'] as num?)?.toInt(),
  rawDiscountTotal: (json['raw_discount_total'] as num?)?.toInt(),
  refundable: (json['refundable'] as num?)?.toInt(),
  cartId: json['cart_id'] as String?,
  orderId: json['order_id'] as String?,
  swapId: json['swap_id'] as String?,
  claimOrderId: json['claim_order_id'] as String?,
  subtitle: json['subtitle'] as String?,
  thumbnail: json['thumbnail'] as String?,
  variantId: json['variant_id'] as String?,
  productId: json['product_id'] as String?,
  productTitle: json['product_title'] as String?,
  productDescription: json['product_description'] as String?,
  productSubtitle: json['product_subtitle'] as String?,
  productType: json['product_type'] as String?,
  productTypeId: json['product_type_id'] as String?,
  productCollection: json['product_collection'] as String?,
  productHandle: json['product_handle'] as String?,
  variantSku: json['variant_sku'] as String?,
  variantBarcode: json['variant_barcode'] as String?,
  variantTitle: json['variant_title'] as String?,
  variantOptionValues: json['variant_option_values'] as List<dynamic>?,
  metadata: json['metadata'] as Map<String, dynamic>?,
  createdAt:
      json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
  updatedAt:
      json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
  adjustments:
      (json['adjustments'] as List<dynamic>?)
          ?.map((e) => Adjustment.fromJson(e as Map<String, dynamic>))
          .toList(),
  taxLines:
      (json['tax_lines'] as List<dynamic>?)
          ?.map((e) => TaxLine.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$LineItemToJson(LineItem instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'quantity': instance.quantity,
  'unit_price': instance.unitPrice,
  'requires_shipping': instance.requiresShipping,
  'is_discountable': instance.isDiscountable,
  'is_giftcard': instance.isGiftcard,
  'is_tax_inclusive': instance.isTaxInclusive,
  'is_custom_price': instance.isCustomPrice,
  'compare_at_unit_price': instance.compareAtUnitPrice,
  'original_unit_price': instance.originalUnitPrice,
  'subtotal': instance.subtotal,
  'discount_total': instance.discountTotal,
  'total': instance.total,
  'original_total': instance.originalTotal,
  'tax_total': instance.taxTotal,
  'raw_discount_total': instance.rawDiscountTotal,
  'refundable': instance.refundable,
  'cart_id': instance.cartId,
  'order_id': instance.orderId,
  'swap_id': instance.swapId,
  'claim_order_id': instance.claimOrderId,
  'subtitle': instance.subtitle,
  'thumbnail': instance.thumbnail,
  'variant_id': instance.variantId,
  'product_id': instance.productId,
  'product_title': instance.productTitle,
  'product_description': instance.productDescription,
  'product_subtitle': instance.productSubtitle,
  'product_type': instance.productType,
  'product_type_id': instance.productTypeId,
  'product_collection': instance.productCollection,
  'product_handle': instance.productHandle,
  'variant_sku': instance.variantSku,
  'variant_barcode': instance.variantBarcode,
  'variant_title': instance.variantTitle,
  'variant_option_values': instance.variantOptionValues,
  'metadata': instance.metadata,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
  'adjustments': instance.adjustments,
  'tax_lines': instance.taxLines,
};
