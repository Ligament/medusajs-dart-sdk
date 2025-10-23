import 'package:json_annotation/json_annotation.dart';
import 'common.dart';

part 'store_shipping_option.g.dart';

/// Store price model for shipping options
@JsonSerializable(fieldRename: FieldRename.snake)
class StorePrice {
  /// The price's ID
  final String id;

  /// The price's currency code
  final String currencyCode;

  /// The price's amount
  final int amount;

  /// The minimum quantity that must be available in the cart for the price to be applied
  final int? minQuantity;

  /// The maximum quantity allowed to be available in the cart for the price to be applied
  final int? maxQuantity;

  /// The rules enabled to enable the current price
  final List<StorePriceRule>? priceRules;

  const StorePrice({
    required this.id,
    required this.currencyCode,
    required this.amount,
    this.minQuantity,
    this.maxQuantity,
    this.priceRules,
  });

  factory StorePrice.fromJson(Map<String, dynamic> json) =>
      _$StorePriceFromJson(json);
  Map<String, dynamic> toJson() => _$StorePriceToJson(this);
}

/// Store price rule model
@JsonSerializable(fieldRename: FieldRename.snake)
class StorePriceRule {
  /// The rule's ID
  final String id;

  /// The rule's attribute
  final String attribute;

  /// The rule's operator
  final String operator;

  /// The rule's value
  final String value;

  const StorePriceRule({
    required this.id,
    required this.attribute,
    required this.operator,
    required this.value,
  });

  factory StorePriceRule.fromJson(Map<String, dynamic> json) =>
      _$StorePriceRuleFromJson(json);
  Map<String, dynamic> toJson() => _$StorePriceRuleToJson(this);
}

/// Store calculated price model
@JsonSerializable(fieldRename: FieldRename.snake)
class StoreCalculatedPrice {
  /// The ID of the price set
  final String? id;

  /// The amount of the calculated price, or null if there isn't a calculated price
  final int? calculatedAmount;

  /// The amount of the original price, or null if there isn't a calculated price
  final int? originalAmount;

  /// The amount of the original price with taxes included
  final int? originalAmountWithTax;

  /// The amount of the original price without taxes included
  final int? originalAmountWithoutTax;

  /// The currency code of the calculated price, or null if there isn't a calculated price
  final String? currencyCode;

  /// Whether the calculated price is associated with a price list
  final bool? isCalculatedPricePriceList;

  /// Whether the calculated price is tax inclusive
  final bool? isCalculatedPriceTaxInclusive;

  /// The amount of the calculated price with taxes included
  final int? calculatedAmountWithTax;

  /// The amount of the calculated price without taxes included
  final int? calculatedAmountWithoutTax;

  /// Whether the original price is associated with a price list
  final bool? isOriginalPricePriceList;

  /// Whether the original price is tax inclusive
  final bool? isOriginalPriceTaxInclusive;

  /// The details of the calculated price
  final Map<String, dynamic>? calculatedPrice;

  /// The details of the original price
  final Map<String, dynamic>? originalPrice;

  const StoreCalculatedPrice({
    this.id,
    this.calculatedAmount,
    this.originalAmount,
    this.originalAmountWithTax,
    this.originalAmountWithoutTax,
    this.currencyCode,
    this.isCalculatedPricePriceList,
    this.isCalculatedPriceTaxInclusive,
    this.calculatedAmountWithTax,
    this.calculatedAmountWithoutTax,
    this.isOriginalPricePriceList,
    this.isOriginalPriceTaxInclusive,
    this.calculatedPrice,
    this.originalPrice,
  });

  factory StoreCalculatedPrice.fromJson(Map<String, dynamic> json) =>
      _$StoreCalculatedPriceFromJson(json);
  Map<String, dynamic> toJson() => _$StoreCalculatedPriceToJson(this);
}

/// Store fulfillment provider details
@JsonSerializable(fieldRename: FieldRename.snake)
class StoreFulfillmentProvider {
  /// The provider's ID
  final String id;

  /// Whether the provider is enabled
  final bool isEnabled;

  const StoreFulfillmentProvider({required this.id, required this.isEnabled});

  factory StoreFulfillmentProvider.fromJson(Map<String, dynamic> json) =>
      _$StoreFulfillmentProviderFromJson(json);
  Map<String, dynamic> toJson() => _$StoreFulfillmentProviderToJson(this);
}

/// Shipping option type details
@JsonSerializable(fieldRename: FieldRename.snake)
class ShippingOptionTypeInfo {
  /// The type's ID
  final String id;

  /// The type's label
  final String label;

  /// The type's description
  final String description;

  /// The type's code
  final String code;

  const ShippingOptionTypeInfo({
    required this.id,
    required this.label,
    required this.description,
    required this.code,
  });

  factory ShippingOptionTypeInfo.fromJson(Map<String, dynamic> json) =>
      _$ShippingOptionTypeInfoFromJson(json);
  Map<String, dynamic> toJson() => _$ShippingOptionTypeInfoToJson(this);
}

/// Store cart shipping option model - matches Medusa Store API
@JsonSerializable(fieldRename: FieldRename.snake)
class StoreCartShippingOption {
  /// The shipping option's ID
  final String id;

  /// The shipping option's name
  final String name;

  /// The shipping option's price type
  final ShippingOptionPriceType priceType;

  /// The ID of the service zone the shipping option belongs to
  final String serviceZoneId;

  /// The ID of the associated shipping profile
  final String shippingProfileId;

  /// The ID of the fulfillment provider handling this option
  final String? providerId;

  /// The fulfillment provider's details
  final StoreFulfillmentProvider? provider;

  /// The shipping option type's details
  final ShippingOptionTypeInfo? type;

  /// The shipping option's amount
  final int amount;

  /// The shipping option's data, useful for the provider handling fulfillment
  final Map<String, dynamic>? data;

  /// The shipping option's prices
  final List<StorePrice>? prices;

  /// Calculated price for the shipping option
  final StoreCalculatedPrice? calculatedPrice;

  /// Whether the shipping option's location doesn't have sufficient quantity for any of the cart's items
  final bool? insufficientInventory;

  const StoreCartShippingOption({
    required this.id,
    required this.name,
    required this.priceType,
    required this.serviceZoneId,
    required this.shippingProfileId,
    this.providerId,
    this.provider,
    this.type,
    required this.amount,
    this.data,
    this.prices,
    this.calculatedPrice,
    this.insufficientInventory,
  });

  factory StoreCartShippingOption.fromJson(Map<String, dynamic> json) =>
      _$StoreCartShippingOptionFromJson(json);
  Map<String, dynamic> toJson() => _$StoreCartShippingOptionToJson(this);

  /// Check if this shipping option has a flat rate price
  bool get isFlatRate => priceType == ShippingOptionPriceType.flat;

  /// Check if this shipping option has a calculated price
  bool get isCalculated => priceType == ShippingOptionPriceType.calculated;

  /// Get the effective price amount
  int get effectiveAmount => calculatedPrice?.calculatedAmount ?? amount;

  /// Check if inventory is sufficient
  bool get hasInventory => insufficientInventory != true;

  /// Get currency code from calculated price or first price
  String? get currencyCode =>
      calculatedPrice?.currencyCode ?? prices?.firstOrNull?.currencyCode;
}

/// Store shipping option list response
@JsonSerializable(fieldRename: FieldRename.snake)
class StoreShippingOptionListResponse {
  /// The shipping options for the cart
  final List<StoreCartShippingOption> shippingOptions;

  const StoreShippingOptionListResponse({required this.shippingOptions});

  factory StoreShippingOptionListResponse.fromJson(Map<String, dynamic> json) =>
      _$StoreShippingOptionListResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$StoreShippingOptionListResponseToJson(this);
}

/// Store shipping option response (single option)
@JsonSerializable(fieldRename: FieldRename.snake)
class StoreShippingOptionResponse {
  /// The shipping option's details
  final StoreCartShippingOption shippingOption;

  const StoreShippingOptionResponse({required this.shippingOption});

  factory StoreShippingOptionResponse.fromJson(Map<String, dynamic> json) =>
      _$StoreShippingOptionResponseFromJson(json);
  Map<String, dynamic> toJson() => _$StoreShippingOptionResponseToJson(this);
}
