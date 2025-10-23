import 'package:json_annotation/json_annotation.dart';
import 'product_variant_option_request.dart';
import 'product_variant_option_value.dart';

part 'product_variant.g.dart';

/// Represents a product variant in the Medusa system
@JsonSerializable(fieldRename: FieldRename.snake)
class ProductVariant {
  /// Unique identifier for the product variant
  final String id;

  /// Product variant title
  final String title;

  /// Product variant SKU
  final String? sku;

  /// Product variant barcode
  final String? barcode;

  /// Product variant EAN
  final String? ean;

  /// Product variant UPC
  final String? upc;

  /// Whether the variant allows backorders
  final bool allowBackorder;

  /// Whether inventory is managed for this variant
  final bool manageInventory;

  /// High stock count
  final int? hsCode;

  /// Product variant weight
  final int? weight;

  /// Product variant length
  final int? length;

  /// Product variant height
  final int? height;

  /// Product variant width
  final int? width;

  /// Product variant origin country
  final String? originCountry;

  /// Product variant material
  final String? material;

  /// Product variant options (list of option values)
  final List<ProductVariantOptionValue>? options;

  /// Product variant metadata
  final Map<String, dynamic>? metadata;

  /// Product ID this variant belongs to
  final String productId;

  /// Calculated prices for this variant
  final ProductVariantPrice? calculatedPrice;

  /// When the variant was created
  final DateTime createdAt;

  /// When the variant was last updated
  final DateTime updatedAt;

  /// When the variant was deleted (if soft deleted)
  final DateTime? deletedAt;

  const ProductVariant({
    required this.id,
    required this.title,
    this.sku,
    this.barcode,
    this.ean,
    this.upc,
    this.allowBackorder = false,
    this.manageInventory = true,
    this.hsCode,
    this.weight,
    this.length,
    this.height,
    this.width,
    this.originCountry,
    this.material,
    this.options,
    this.metadata,
    required this.productId,
    this.calculatedPrice,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory ProductVariant.fromJson(Map<String, dynamic> json) =>
      _$ProductVariantFromJson(json);
  Map<String, dynamic> toJson() => _$ProductVariantToJson(this);

  /// Check if variant has dimensions
  bool get hasDimensions => length != null && height != null && width != null;

  /// Check if variant has weight
  bool get hasWeight => weight != null;

  /// Get variant dimensions as a formatted string
  String get formattedDimensions {
    if (!hasDimensions) return 'N/A';
    return '${length}x${width}x$height';
  }

  /// Get variant weight formatted
  String get formattedWeight {
    if (!hasWeight) return 'N/A';
    return '${weight}g';
  }

  /// Get variant price for specific currency
  ProductVariantPrice? getPriceForCurrency(String currencyCode) {
    // Since calculatedPrice now contains comprehensive pricing information
    // and has its own currencyCode field, we can check it directly
    if (calculatedPrice?.currencyCode == currencyCode) {
      return calculatedPrice;
    }
    return null;
  }
}

/// Price details for calculated and original prices
@JsonSerializable(fieldRename: FieldRename.snake)
class PriceDetails {
  /// The ID of the price selected
  final String? id;

  /// The ID of the associated price list, if any
  final String? priceListId;

  /// The type of the associated price list, if any
  final String? priceListType;

  /// The minimum quantity field defined on a price
  final int? minQuantity;

  /// The maximum quantity field defined on a price
  final int? maxQuantity;

  const PriceDetails({
    this.id,
    this.priceListId,
    this.priceListType,
    this.minQuantity,
    this.maxQuantity,
  });

  factory PriceDetails.fromJson(Map<String, dynamic> json) =>
      _$PriceDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$PriceDetailsToJson(this);
}

/// Product variant price with comprehensive pricing information
@JsonSerializable(fieldRename: FieldRename.snake)
class ProductVariantPrice {
  /// The ID of the price set
  final String id;

  /// Whether the calculated price is associated with a price list
  final bool? isCalculatedPricePriceList;

  /// Whether the calculated price is tax inclusive
  final bool? isCalculatedPriceTaxInclusive;

  /// The amount of the calculated price, or null if there isn't a calculated price
  final double? calculatedAmount;

  /// The amount of the calculated price with taxes included
  final double? calculatedAmountWithTax;

  /// The amount of the calculated price without taxes included
  final double? calculatedAmountWithoutTax;

  /// Whether the original price is associated with a price list
  final bool? isOriginalPricePriceList;

  /// Whether the original price is tax inclusive
  final bool? isOriginalPriceTaxInclusive;

  /// The amount of the original price, or null if there isn't a calculated price
  final double? originalAmount;

  /// The amount of the original price with taxes included
  final double? originalAmountWithTax;

  /// The amount of the original price without taxes included
  final double? originalAmountWithoutTax;

  /// The currency code of the calculated price, or null if there isn't a calculated price
  final String? currencyCode;

  /// The details of the calculated price
  final PriceDetails? calculatedPrice;

  /// The details of the original price
  final PriceDetails? originalPrice;

  const ProductVariantPrice({
    required this.id,
    this.isCalculatedPricePriceList,
    this.isCalculatedPriceTaxInclusive,
    this.calculatedAmount,
    this.calculatedAmountWithTax,
    this.calculatedAmountWithoutTax,
    this.isOriginalPricePriceList,
    this.isOriginalPriceTaxInclusive,
    this.originalAmount,
    this.originalAmountWithTax,
    this.originalAmountWithoutTax,
    this.currencyCode,
    this.calculatedPrice,
    this.originalPrice,
  });

  factory ProductVariantPrice.fromJson(Map<String, dynamic> json) =>
      _$ProductVariantPriceFromJson(json);
  Map<String, dynamic> toJson() => _$ProductVariantPriceToJson(this);

  /// Get formatted calculated price
  String? getFormattedCalculatedPrice([int? decimalPlaces = 2]) {
    if (calculatedAmount == null) return null;
    // Medusa v2 returns amounts in decimal format (already in currency units)
    return calculatedAmount!.toStringAsFixed(decimalPlaces!);
  }

  /// Get formatted original price
  String? getFormattedOriginalPrice([int? decimalPlaces = 2]) {
    if (originalAmount == null) return null;
    // Medusa v2 returns amounts in decimal format (already in currency units)
    return originalAmount!.toStringAsFixed(decimalPlaces!);
  }

  /// Get the effective price (calculated if available, otherwise original)
  double? get effectiveAmount => calculatedAmount ?? originalAmount;

  /// Get formatted effective price
  String? getFormattedEffectivePrice([int? decimalPlaces = 2]) {
    final amount = effectiveAmount;
    if (amount == null) return null;
    // Medusa v2 returns amounts in decimal format (already in currency units)
    return amount.toStringAsFixed(decimalPlaces!);
  }

  /// Check if there's a price discount (calculated price differs from original)
  bool get hasDiscount {
    return calculatedAmount != null &&
        originalAmount != null &&
        calculatedAmount! < originalAmount!;
  }

  /// Get discount amount if applicable
  double? get discountAmount {
    if (!hasDiscount) return null;
    return originalAmount! - calculatedAmount!;
  }

  /// Get discount percentage if applicable
  double? get discountPercentage {
    if (!hasDiscount || originalAmount == 0) return null;
    return ((originalAmount! - calculatedAmount!) / originalAmount!) * 100;
  }
}

/// Request to create a product variant
@JsonSerializable(fieldRename: FieldRename.snake)
class CreateProductVariantRequest {
  /// Product variant title
  final String title;

  /// Product variant SKU
  final String? sku;

  /// Product variant barcode
  final String? barcode;

  /// Product variant EAN
  final String? ean;

  /// Product variant UPC
  final String? upc;

  /// Whether the variant allows backorders
  final bool? allowBackorder;

  /// Whether inventory is managed for this variant
  final bool? manageInventory;

  /// High stock count
  final int? hsCode;

  /// Product variant weight
  final int? weight;

  /// Product variant length
  final int? length;

  /// Product variant height
  final int? height;

  /// Product variant width
  final int? width;

  /// Product variant origin country
  final String? originCountry;

  /// Product variant material
  final String? material;

  /// Product variant options
  final List<ProductVariantOptionRequest>? options;

  /// Product variant metadata
  final Map<String, dynamic>? metadata;

  /// Prices for this variant
  final List<CreateProductVariantPriceRequest>? prices;

  const CreateProductVariantRequest({
    required this.title,
    this.sku,
    this.barcode,
    this.ean,
    this.upc,
    this.allowBackorder,
    this.manageInventory,
    this.hsCode,
    this.weight,
    this.length,
    this.height,
    this.width,
    this.originCountry,
    this.material,
    this.options,
    this.metadata,
    this.prices,
  });

  factory CreateProductVariantRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateProductVariantRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateProductVariantRequestToJson(this);
}

/// Request to create a product variant price
@JsonSerializable(fieldRename: FieldRename.snake)
class CreateProductVariantPriceRequest {
  /// Currency code
  final String currencyCode;

  /// Price amount
  final int amount;

  /// Minimum quantity for this price
  final int? minQuantity;

  /// Maximum quantity for this price
  final int? maxQuantity;

  /// Price list ID if this price belongs to a price list
  final String? priceListId;

  const CreateProductVariantPriceRequest({
    required this.currencyCode,
    required this.amount,
    this.minQuantity,
    this.maxQuantity,
    this.priceListId,
  });

  factory CreateProductVariantPriceRequest.fromJson(
    Map<String, dynamic> json,
  ) => _$CreateProductVariantPriceRequestFromJson(json);
  Map<String, dynamic> toJson() =>
      _$CreateProductVariantPriceRequestToJson(this);
}

/// Request to update a product variant
@JsonSerializable(fieldRename: FieldRename.snake)
class UpdateProductVariantRequest {
  /// Product variant title
  final String? title;

  /// Product variant SKU
  final String? sku;

  /// Product variant barcode
  final String? barcode;

  /// Product variant EAN
  final String? ean;

  /// Product variant UPC
  final String? upc;

  /// Whether the variant allows backorders
  final bool? allowBackorder;

  /// Whether inventory is managed for this variant
  final bool? manageInventory;

  /// High stock count
  final int? hsCode;

  /// Product variant weight
  final int? weight;

  /// Product variant length
  final int? length;

  /// Product variant height
  final int? height;

  /// Product variant width
  final int? width;

  /// Product variant origin country
  final String? originCountry;

  /// Product variant material
  final String? material;

  /// Product variant options
  final List<ProductVariantOptionRequest>? options;

  /// Product variant metadata
  final Map<String, dynamic>? metadata;

  const UpdateProductVariantRequest({
    this.title,
    this.sku,
    this.barcode,
    this.ean,
    this.upc,
    this.allowBackorder,
    this.manageInventory,
    this.hsCode,
    this.weight,
    this.length,
    this.height,
    this.width,
    this.originCountry,
    this.material,
    this.options,
    this.metadata,
  });

  factory UpdateProductVariantRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateProductVariantRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateProductVariantRequestToJson(this);
}
