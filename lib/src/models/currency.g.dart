// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Currency _$CurrencyFromJson(Map<String, dynamic> json) => Currency(
  code: json['code'] as String,
  symbol: json['symbol'] as String,
  symbolNative: json['symbol_native'] as String,
  name: json['name'] as String,
  decimalDigits: (json['decimal_digits'] as num).toInt(),
  rounding: (json['rounding'] as num).toDouble(),
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
  includesTax: json['includes_tax'] as bool?,
);

Map<String, dynamic> _$CurrencyToJson(Currency instance) => <String, dynamic>{
  'code': instance.code,
  'symbol': instance.symbol,
  'symbol_native': instance.symbolNative,
  'name': instance.name,
  'decimal_digits': instance.decimalDigits,
  'rounding': instance.rounding,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
  'deleted_at': instance.deletedAt?.toIso8601String(),
  'metadata': instance.metadata,
  'includes_tax': instance.includesTax,
};
