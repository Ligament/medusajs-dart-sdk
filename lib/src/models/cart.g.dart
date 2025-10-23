// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cart _$CartFromJson(Map<String, dynamic> json) => Cart(
  id: json['id'] as String,
  currencyCode: json['currency_code'] as String?,
  originalItemTotal: (json['original_item_total'] as num?)?.toInt(),
  originalItemSubtotal: (json['original_item_subtotal'] as num?)?.toInt(),
  originalItemTaxTotal: (json['original_item_tax_total'] as num?)?.toInt(),
  itemTotal: (json['item_total'] as num?)?.toInt(),
  itemSubtotal: (json['item_subtotal'] as num?)?.toInt(),
  itemTaxTotal: (json['item_tax_total'] as num?)?.toInt(),
  originalTotal: (json['original_total'] as num?)?.toInt(),
  originalSubtotal: (json['original_subtotal'] as num?)?.toInt(),
  originalTaxTotal: (json['original_tax_total'] as num?)?.toInt(),
  total: (json['total'] as num?)?.toInt(),
  subtotal: (json['subtotal'] as num?)?.toInt(),
  taxTotal: (json['tax_total'] as num?)?.toInt(),
  discountTotal: (json['discount_total'] as num?)?.toInt(),
  discountTaxTotal: (json['discount_tax_total'] as num?)?.toInt(),
  giftCardTotal: (json['gift_card_total'] as num?)?.toInt(),
  giftCardTaxTotal: (json['gift_card_tax_total'] as num?)?.toInt(),
  shippingTotal: (json['shipping_total'] as num?)?.toInt(),
  shippingSubtotal: (json['shipping_subtotal'] as num?)?.toInt(),
  shippingTaxTotal: (json['shipping_tax_total'] as num?)?.toInt(),
  originalShippingTotal: (json['original_shipping_total'] as num?)?.toInt(),
  originalShippingSubtotal:
      (json['original_shipping_subtotal'] as num?)?.toInt(),
  originalShippingTaxTotal:
      (json['original_shipping_tax_total'] as num?)?.toInt(),
  promotions:
      (json['promotions'] as List<dynamic>?)
          ?.map((e) => StoreCartPromotion.fromJson(e as Map<String, dynamic>))
          .toList(),
  regionId: json['region_id'] as String?,
  customerId: json['customer_id'] as String?,
  salesChannelId: json['sales_channel_id'] as String?,
  email: json['email'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
  createdAt:
      json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
  updatedAt:
      json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
  shippingAddress:
      json['shipping_address'] == null
          ? null
          : Address.fromJson(json['shipping_address'] as Map<String, dynamic>),
  billingAddress:
      json['billing_address'] == null
          ? null
          : Address.fromJson(json['billing_address'] as Map<String, dynamic>),
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => LineItem.fromJson(e as Map<String, dynamic>))
          .toList(),
  shippingMethods:
      (json['shipping_methods'] as List<dynamic>?)
          ?.map((e) => ShippingMethod.fromJson(e as Map<String, dynamic>))
          .toList(),
  region:
      json['region'] == null
          ? null
          : Region.fromJson(json['region'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
  'id': instance.id,
  'currency_code': instance.currencyCode,
  'original_item_total': instance.originalItemTotal,
  'original_item_subtotal': instance.originalItemSubtotal,
  'original_item_tax_total': instance.originalItemTaxTotal,
  'item_total': instance.itemTotal,
  'item_subtotal': instance.itemSubtotal,
  'item_tax_total': instance.itemTaxTotal,
  'original_total': instance.originalTotal,
  'original_subtotal': instance.originalSubtotal,
  'original_tax_total': instance.originalTaxTotal,
  'total': instance.total,
  'subtotal': instance.subtotal,
  'tax_total': instance.taxTotal,
  'discount_total': instance.discountTotal,
  'discount_tax_total': instance.discountTaxTotal,
  'gift_card_total': instance.giftCardTotal,
  'gift_card_tax_total': instance.giftCardTaxTotal,
  'shipping_total': instance.shippingTotal,
  'shipping_subtotal': instance.shippingSubtotal,
  'shipping_tax_total': instance.shippingTaxTotal,
  'original_shipping_total': instance.originalShippingTotal,
  'original_shipping_subtotal': instance.originalShippingSubtotal,
  'original_shipping_tax_total': instance.originalShippingTaxTotal,
  'promotions': instance.promotions?.map((e) => e.toJson()).toList(),
  'region_id': instance.regionId,
  'customer_id': instance.customerId,
  'sales_channel_id': instance.salesChannelId,
  'email': instance.email,
  'metadata': instance.metadata,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
  'shipping_address': instance.shippingAddress?.toJson(),
  'billing_address': instance.billingAddress?.toJson(),
  'items': instance.items?.map((e) => e.toJson()).toList(),
  'shipping_methods': instance.shippingMethods?.map((e) => e.toJson()).toList(),
  'region': instance.region?.toJson(),
};
