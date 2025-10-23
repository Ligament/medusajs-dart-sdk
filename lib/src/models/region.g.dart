// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'region.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Region _$RegionFromJson(Map<String, dynamic> json) => Region(
  id: json['id'] as String,
  name: json['name'] as String,
  currencyCode: json['currency_code'] as String,
  taxRate: (json['tax_rate'] as num?)?.toDouble(),
  taxCode: json['tax_code'] as String?,
  countries:
      (json['countries'] as List<dynamic>?)
          ?.map((e) => Country.fromJson(e as Map<String, dynamic>))
          .toList(),
  paymentProviders:
      (json['payment_providers'] as List<dynamic>?)
          ?.map((e) => PaymentProvider.fromJson(e as Map<String, dynamic>))
          .toList(),
  fulfillmentProviders:
      (json['fulfillment_providers'] as List<dynamic>?)
          ?.map((e) => FulfillmentProvider.fromJson(e as Map<String, dynamic>))
          .toList(),
  includesTax: json['includes_tax'] as bool?,
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
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$RegionToJson(Region instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'currency_code': instance.currencyCode,
  'tax_rate': instance.taxRate,
  'tax_code': instance.taxCode,
  'countries': instance.countries,
  'payment_providers': instance.paymentProviders,
  'fulfillment_providers': instance.fulfillmentProviders,
  'includes_tax': instance.includesTax,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
  'deleted_at': instance.deletedAt?.toIso8601String(),
  'metadata': instance.metadata,
};

Country _$CountryFromJson(Map<String, dynamic> json) => Country(
  iso2: json['iso_2'] as String,
  iso3: json['iso_3'] as String,
  numCode: _numCodeFromJson(json['num_code']),
  name: json['name'] as String,
  displayName: json['display_name'] as String,
  regionId: json['region_id'] as String?,
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

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
  'iso_2': instance.iso2,
  'iso_3': instance.iso3,
  'num_code': _numCodeToJson(instance.numCode),
  'name': instance.name,
  'display_name': instance.displayName,
  'region_id': instance.regionId,
  'metadata': instance.metadata,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
  'deleted_at': instance.deletedAt?.toIso8601String(),
};

PaymentProvider _$PaymentProviderFromJson(Map<String, dynamic> json) =>
    PaymentProvider(
      id: json['id'] as String,
      isInstalled: json['is_installed'] as bool,
    );

Map<String, dynamic> _$PaymentProviderToJson(PaymentProvider instance) =>
    <String, dynamic>{'id': instance.id, 'is_installed': instance.isInstalled};

FulfillmentProvider _$FulfillmentProviderFromJson(Map<String, dynamic> json) =>
    FulfillmentProvider(
      id: json['id'] as String,
      isInstalled: json['is_installed'] as bool,
    );

Map<String, dynamic> _$FulfillmentProviderToJson(
  FulfillmentProvider instance,
) => <String, dynamic>{'id': instance.id, 'is_installed': instance.isInstalled};
