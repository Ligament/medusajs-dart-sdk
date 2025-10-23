import 'dart:math' as math;

import 'package:json_annotation/json_annotation.dart';

part 'currency.g.dart';

/// Store currency model aligned with @medusajs/types v2.10.3
///
/// Mirrors `BaseCurrency`/`StoreCurrency` definitions exposed by the
/// Medusa Store API.
@JsonSerializable(fieldRename: FieldRename.snake)
class Currency {
  /// ISO 4217 currency code
  final String code;

  /// Primary currency symbol (e.g. `$`)
  final String symbol;

  /// Currency symbol in the native locale/language
  final String symbolNative;

  /// Human readable currency name
  final String name;

  /// Number of decimal digits supported by this currency
  final int decimalDigits;

  /// Rounding precision applied to values in this currency
  final double rounding;

  /// Timestamp for when the currency was created
  final DateTime? createdAt;

  /// Timestamp for when the currency was last updated
  final DateTime? updatedAt;

  /// Timestamp for when the currency was soft-deleted (if ever)
  final DateTime? deletedAt;

  /// Optional metadata returned by certain admin/store endpoints
  final Map<String, dynamic>? metadata;

  /// Legacy flag kept for backward compatibility with older API payloads
  final bool? includesTax;

  const Currency({
    required this.code,
    required this.symbol,
    required this.symbolNative,
    required this.name,
    required this.decimalDigits,
    required this.rounding,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.metadata,
    this.includesTax,
  });

  factory Currency.fromJson(Map<String, dynamic> json) =>
      _$CurrencyFromJson(json);
  Map<String, dynamic> toJson() => _$CurrencyToJson(this);

  /// Format an amount according to this currency
  String formatAmount(int amountMinorUnits) {
    final divisor = math.pow(10, decimalDigits).toDouble();
    final decimal = amountMinorUnits / divisor;
    return '$symbol${decimal.toStringAsFixed(decimalDigits)}';
  }

  /// Convert amount from major units to minor units (e.g., dollars to cents)
  int toMinorUnits(double amountMajorUnits) {
    final multiplier = math.pow(10, decimalDigits).toDouble();
    return (amountMajorUnits * multiplier).round();
  }

  /// Convert amount from minor units to major units (e.g., cents to dollars)
  double toMajorUnits(int amountMinorUnits) {
    final divisor = math.pow(10, decimalDigits).toDouble();
    return amountMinorUnits / divisor;
  }
}
