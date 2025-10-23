// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipping.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShippingOption _$ShippingOptionFromJson(Map<String, dynamic> json) =>
    ShippingOption(
      id: json['id'] as String,
      name: json['name'] as String,
      regionId: json['region_id'] as String,
      profileId: json['profile_id'] as String,
      providerId: json['provider_id'] as String,
      priceType: $enumDecode(_$PriceTypeEnumMap, json['price_type']),
      amount: (json['amount'] as num?)?.toInt(),
      isReturn: json['is_return'] as bool,
      adminOnly: json['admin_only'] as bool?,
      requirements:
          (json['requirements'] as List<dynamic>?)
              ?.map(
                (e) => ShippingOptionRequirement.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList(),
      data: json['data'] as Map<String, dynamic>?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      createdAt:
          json['created_at'] == null
              ? null
              : DateTime.parse(json['created_at'] as String),
      updatedAt:
          json['updated_at'] == null
              ? null
              : DateTime.parse(json['updated_at'] as String),
      deletedAt:
          json['deleted_at'] == null
              ? null
              : DateTime.parse(json['deleted_at'] as String),
    );

Map<String, dynamic> _$ShippingOptionToJson(ShippingOption instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'region_id': instance.regionId,
      'profile_id': instance.profileId,
      'provider_id': instance.providerId,
      'price_type': _$PriceTypeEnumMap[instance.priceType]!,
      'amount': instance.amount,
      'is_return': instance.isReturn,
      'admin_only': instance.adminOnly,
      'requirements': instance.requirements,
      'data': instance.data,
      'metadata': instance.metadata,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'deleted_at': instance.deletedAt?.toIso8601String(),
    };

const _$PriceTypeEnumMap = {
  PriceType.flatRate: 'flat_rate',
  PriceType.calculated: 'calculated',
};

ShippingOptionRequirement _$ShippingOptionRequirementFromJson(
  Map<String, dynamic> json,
) => ShippingOptionRequirement(
  id: json['id'] as String,
  shippingOptionId: json['shipping_option_id'] as String,
  type: $enumDecode(_$RequirementTypeEnumMap, json['type']),
  amount: (json['amount'] as num).toInt(),
  deletedAt:
      json['deleted_at'] == null
          ? null
          : DateTime.parse(json['deleted_at'] as String),
);

Map<String, dynamic> _$ShippingOptionRequirementToJson(
  ShippingOptionRequirement instance,
) => <String, dynamic>{
  'id': instance.id,
  'shipping_option_id': instance.shippingOptionId,
  'type': _$RequirementTypeEnumMap[instance.type]!,
  'amount': instance.amount,
  'deleted_at': instance.deletedAt?.toIso8601String(),
};

const _$RequirementTypeEnumMap = {
  RequirementType.minSubtotal: 'min_subtotal',
  RequirementType.maxSubtotal: 'max_subtotal',
};

ShippingMethod _$ShippingMethodFromJson(Map<String, dynamic> json) =>
    ShippingMethod(
      id: json['id'] as String,
      shippingOptionId: json['shipping_option_id'] as String,
      cartId: json['cart_id'] as String?,
      orderId: json['order_id'] as String?,
      swapId: json['swap_id'] as String?,
      returnId: json['return_id'] as String?,
      claimId: json['claim_id'] as String?,
      price: (json['price'] as num).toInt(),
      data: json['data'] as Map<String, dynamic>?,
      createdAt:
          json['created_at'] == null
              ? null
              : DateTime.parse(json['created_at'] as String),
      updatedAt:
          json['updated_at'] == null
              ? null
              : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$ShippingMethodToJson(ShippingMethod instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shipping_option_id': instance.shippingOptionId,
      'cart_id': instance.cartId,
      'order_id': instance.orderId,
      'swap_id': instance.swapId,
      'return_id': instance.returnId,
      'claim_id': instance.claimId,
      'price': instance.price,
      'data': instance.data,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
