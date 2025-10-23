// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
  id: json['id'] as String?,
  customerId: json['customer_id'] as String?,
  company: json['company'] as String?,
  firstName: json['first_name'] as String?,
  lastName: json['last_name'] as String?,
  address1: json['address1'] as String?,
  address2: json['address2'] as String?,
  city: json['city'] as String?,
  countryCode: json['country_code'] as String?,
  province: json['province'] as String?,
  postalCode: json['postal_code'] as String?,
  phone: json['phone'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
  createdAt:
      json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
  updatedAt:
      json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
  'id': instance.id,
  'customer_id': instance.customerId,
  'company': instance.company,
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'address1': instance.address1,
  'address2': instance.address2,
  'city': instance.city,
  'country_code': instance.countryCode,
  'province': instance.province,
  'postal_code': instance.postalCode,
  'phone': instance.phone,
  'metadata': instance.metadata,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
};
