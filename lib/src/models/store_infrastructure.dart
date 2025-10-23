/// Store Infrastructure Models: Region, Collection, Category canonical implementations
/// Following official @medusajs/types v2.10.1 specifications
///
/// This file contains canonical Store-specific infrastructure models that mirror the
/// official TypeScript interfaces exactly, ensuring type safety and API compatibility.
///
/// Key models included:
/// - Region & Country management
/// - Collection organization
/// - Product Category hierarchy
/// - Payment provider configuration
/// - Currency & tax handling

import 'package:json_annotation/json_annotation.dart';
import 'store_product.dart';

part 'store_infrastructure.g.dart';

// =============================================================================
// REGION MODELS - Geographic & Currency Management
// =============================================================================

/// StoreRegion - Geographic region with currency and tax configuration
///
/// Represents a geographic region where products can be sold, including
/// currency settings, tax configuration, and available payment providers.
///
/// Official Type: StoreRegion extends BaseRegion
@JsonSerializable(explicitToJson: true)
class StoreRegion {
  /// The region's ID
  final String id;

  /// The region's name
  final String name;

  /// The region's currency code
  @JsonKey(name: 'currency_code')
  final String currencyCode;

  /// Whether taxes are calculated automatically in the region
  @JsonKey(name: 'automatic_taxes')
  final bool? automaticTaxes;

  /// The countries that belong to the region
  final List<StoreRegionCountry>? countries;

  /// The payment providers enabled in the region
  @JsonKey(name: 'payment_providers')
  final List<AdminPaymentProvider>? paymentProviders;

  /// Key-value pairs of custom data
  final Map<String, dynamic>? metadata;

  /// The date the region was created
  @JsonKey(name: 'created_at')
  final String? createdAt;

  /// The date the region was updated
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  /// The date the region was deleted
  @JsonKey(name: 'deleted_at')
  final String? deletedAt;

  const StoreRegion({
    required this.id,
    required this.name,
    required this.currencyCode,
    this.automaticTaxes,
    this.countries,
    this.paymentProviders,
    this.metadata,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory StoreRegion.fromJson(Map<String, dynamic> json) =>
      _$StoreRegionFromJson(json);
  Map<String, dynamic> toJson() => _$StoreRegionToJson(this);
}

/// StoreRegionCountry - Country information within a region
///
/// Represents a country that belongs to a region with ISO codes
/// and display information for international commerce support.
///
/// Official Type: StoreRegionCountry extends BaseRegionCountry
@JsonSerializable(explicitToJson: true)
class StoreRegionCountry {
  /// The country's region ID
  @JsonKey(name: 'region_id')
  final String regionId;

  /// The country's ISO 2 code (e.g., "us")
  @JsonKey(name: 'iso_2')
  final String? iso2;

  /// The country's ISO 3 code (e.g., "usa")
  @JsonKey(name: 'iso_3')
  final String? iso3;

  /// The country's num code (e.g., "840")
  /// Handles both string and integer values from the API
  @JsonKey(name: 'num_code', fromJson: _numCodeFromJson, toJson: _numCodeToJson)
  final String? numCode;

  /// The country's name
  final String? name;

  /// The country's name used for display
  @JsonKey(name: 'display_name')
  final String? displayName;

  /// Key-value pairs of custom data
  final Map<String, dynamic>? metadata;

  /// The date the country was created
  @JsonKey(name: 'created_at')
  final String? createdAt;

  /// The date the country was updated
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  /// The date the country was deleted
  @JsonKey(name: 'deleted_at')
  final String? deletedAt;

  const StoreRegionCountry({
    required this.regionId,
    this.iso2,
    this.iso3,
    this.numCode,
    this.name,
    this.displayName,
    this.metadata,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory StoreRegionCountry.fromJson(Map<String, dynamic> json) =>
      _$StoreRegionCountryFromJson(json);
  Map<String, dynamic> toJson() => _$StoreRegionCountryToJson(this);
}

// =============================================================================
// COLLECTION MODELS - Product Organization System
// =============================================================================

/// StoreCollection - Product collection for organization and marketing
///
/// Represents a curated collection of products for organizing inventory,
/// creating marketing campaigns, and improving product discovery.
///
/// Official Type: StoreCollection extends Omit<BaseCollection, "products">
@JsonSerializable(explicitToJson: true)
class StoreCollection {
  /// The collection's ID
  final String id;

  /// The collection's title
  final String title;

  /// The collection's handle
  final String handle;

  /// The date the collection was created
  @JsonKey(name: 'created_at')
  final String createdAt;

  /// The date the collection was updated
  @JsonKey(name: 'updated_at')
  final String updatedAt;

  /// The date the collection was deleted
  @JsonKey(name: 'deleted_at')
  final String? deletedAt;

  /// Key-value pairs of custom data
  final Map<String, dynamic>? metadata;

  /// The collection's products
  final List<StoreProduct>? products;

  const StoreCollection({
    required this.id,
    required this.title,
    required this.handle,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.metadata,
    this.products,
  });

  factory StoreCollection.fromJson(Map<String, dynamic> json) =>
      _$StoreCollectionFromJson(json);
  Map<String, dynamic> toJson() => _$StoreCollectionToJson(this);
}

// =============================================================================
// PRODUCT CATEGORY MODELS - Hierarchical Product Classification
// =============================================================================

/// StoreProductCategory - Hierarchical product category system
///
/// Represents a product category with support for hierarchical organization,
/// parent-child relationships, and product associations for navigation.
///
/// Official Type: StoreProductCategory extends Omit<BaseProductCategory, "is_active" | "is_internal" | "products" | "parent_category" | "category_children">
@JsonSerializable(explicitToJson: true)
class StoreProductCategory {
  /// The category's ID
  final String id;

  /// The category's name
  final String name;

  /// The category's description
  final String? description;

  /// The category's handle
  final String handle;

  /// The category's rank (used for display order)
  final int? rank;

  /// The ID of the parent category
  @JsonKey(name: 'parent_category_id')
  final String? parentCategoryId;

  /// Key-value pairs of custom data
  final Map<String, dynamic>? metadata;

  /// The date the category was created
  @JsonKey(name: 'created_at')
  final String createdAt;

  /// The date the category was updated
  @JsonKey(name: 'updated_at')
  final String updatedAt;

  /// The date the category was deleted
  @JsonKey(name: 'deleted_at')
  final String? deletedAt;

  /// The category's products
  final List<StoreProduct>? products;

  /// The parent category
  @JsonKey(name: 'parent_category')
  final StoreProductCategory? parentCategory;

  /// The category's children
  @JsonKey(name: 'category_children')
  final List<StoreProductCategory> categoryChildren;

  const StoreProductCategory({
    required this.id,
    required this.name,
    this.description,
    required this.handle,
    this.rank,
    this.parentCategoryId,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.products,
    this.parentCategory,
    this.categoryChildren = const [],
  });

  factory StoreProductCategory.fromJson(Map<String, dynamic> json) =>
      _$StoreProductCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$StoreProductCategoryToJson(this);
}

// =============================================================================
// CURRENCY & PAYMENT MODELS - Financial Infrastructure
// =============================================================================

/// Currency - Currency information for international commerce
///
/// Represents a currency with formatting rules and metadata
/// for proper monetary value display and calculation.
@JsonSerializable(explicitToJson: true)
class Currency {
  /// The currency's code (e.g., "USD", "EUR")
  final String code;

  /// The currency's symbol (e.g., "$", "€")
  final String? symbol;

  /// The currency's symbol placed native (e.g., "$", "€")
  @JsonKey(name: 'symbol_native')
  final String? symbolNative;

  /// The currency's name
  final String name;

  /// Number of decimal places for the currency
  @JsonKey(name: 'decimal_digits')
  final int? decimalDigits;

  /// Rounding increment for the currency
  final double? rounding;

  /// Key-value pairs of custom data
  final Map<String, dynamic>? metadata;

  const Currency({
    required this.code,
    this.symbol,
    this.symbolNative,
    required this.name,
    this.decimalDigits,
    this.rounding,
    this.metadata,
  });

  factory Currency.fromJson(Map<String, dynamic> json) =>
      _$CurrencyFromJson(json);
  Map<String, dynamic> toJson() => _$CurrencyToJson(this);
}

/// AdminPaymentProvider - Payment provider configuration (placeholder)
///
/// Represents a payment provider available in the admin system.
/// This is a simplified version for region associations.
@JsonSerializable(explicitToJson: true)
class AdminPaymentProvider {
  /// The payment provider's ID
  final String id;

  /// The payment provider's name
  final String name;

  /// Whether the provider is enabled
  @JsonKey(name: 'is_enabled')
  final bool isEnabled;

  const AdminPaymentProvider({
    required this.id,
    required this.name,
    required this.isEnabled,
  });

  factory AdminPaymentProvider.fromJson(Map<String, dynamic> json) =>
      _$AdminPaymentProviderFromJson(json);
  Map<String, dynamic> toJson() => _$AdminPaymentProviderToJson(this);
}

// =============================================================================
// SHIPPING & TAX MODELS - Logistics Infrastructure
// =============================================================================

/// ShippingOption - Available shipping methods for a region
///
/// Represents a shipping option with pricing, provider information,
/// and configuration for checkout and fulfillment.
@JsonSerializable(explicitToJson: true)
class ShippingOption {
  /// The shipping option's ID
  final String id;

  /// The shipping option's name
  final String name;

  /// The shipping option's provider ID
  @JsonKey(name: 'provider_id')
  final String providerId;

  /// The shipping option's profile ID
  @JsonKey(name: 'profile_id')
  final String? profileId;

  /// The shipping option's type ID
  @JsonKey(name: 'type_id')
  final String? typeId;

  /// The price for this shipping option
  final double? price;

  /// Whether this option includes tax
  @JsonKey(name: 'includes_tax')
  final bool? includesTax;

  /// The shipping option's data
  final Map<String, dynamic>? data;

  /// Key-value pairs of custom data
  final Map<String, dynamic>? metadata;

  /// The date the shipping option was created
  @JsonKey(name: 'created_at')
  final String? createdAt;

  /// The date the shipping option was updated
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  /// The date the shipping option was deleted
  @JsonKey(name: 'deleted_at')
  final String? deletedAt;

  const ShippingOption({
    required this.id,
    required this.name,
    required this.providerId,
    this.profileId,
    this.typeId,
    this.price,
    this.includesTax,
    this.data,
    this.metadata,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory ShippingOption.fromJson(Map<String, dynamic> json) =>
      _$ShippingOptionFromJson(json);
  Map<String, dynamic> toJson() => _$ShippingOptionToJson(this);
}

/// TaxRate - Tax rate configuration for regions
///
/// Represents a tax rate that applies to products or shipping
/// in specific regions with rate calculation and metadata.
@JsonSerializable(explicitToJson: true)
class TaxRate {
  /// The tax rate's ID
  final String id;

  /// The tax rate's rate as a percentage
  final double rate;

  /// The tax rate's code
  final String? code;

  /// The tax rate's name
  final String name;

  /// The region ID this tax rate applies to
  @JsonKey(name: 'region_id')
  final String? regionId;

  /// Key-value pairs of custom data
  final Map<String, dynamic>? metadata;

  /// The date the tax rate was created
  @JsonKey(name: 'created_at')
  final String? createdAt;

  /// The date the tax rate was updated
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  const TaxRate({
    required this.id,
    required this.rate,
    this.code,
    required this.name,
    this.regionId,
    this.metadata,
    this.createdAt,
    this.updatedAt,
  });

  factory TaxRate.fromJson(Map<String, dynamic> json) =>
      _$TaxRateFromJson(json);
  Map<String, dynamic> toJson() => _$TaxRateToJson(this);
}

// =============================================================================
// API RESPONSE WRAPPERS
// =============================================================================

/// Response wrapper for single region operations
@JsonSerializable(explicitToJson: true)
class StoreRegionResponse {
  final StoreRegion region;

  const StoreRegionResponse({required this.region});

  factory StoreRegionResponse.fromJson(Map<String, dynamic> json) =>
      _$StoreRegionResponseFromJson(json);
  Map<String, dynamic> toJson() => _$StoreRegionResponseToJson(this);
}

/// Response wrapper for region list operations
@JsonSerializable(explicitToJson: true)
class StoreRegionListResponse {
  final List<StoreRegion> regions;
  final int count;
  final int offset;
  final int limit;

  const StoreRegionListResponse({
    required this.regions,
    required this.count,
    required this.offset,
    required this.limit,
  });

  factory StoreRegionListResponse.fromJson(Map<String, dynamic> json) =>
      _$StoreRegionListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$StoreRegionListResponseToJson(this);
}

/// Response wrapper for single collection operations
@JsonSerializable(explicitToJson: true)
class StoreCollectionResponse {
  final StoreCollection collection;

  const StoreCollectionResponse({required this.collection});

  factory StoreCollectionResponse.fromJson(Map<String, dynamic> json) =>
      _$StoreCollectionResponseFromJson(json);
  Map<String, dynamic> toJson() => _$StoreCollectionResponseToJson(this);
}

/// Response wrapper for collection list operations
@JsonSerializable(explicitToJson: true)
class StoreCollectionListResponse {
  final List<StoreCollection> collections;
  final int count;
  final int offset;
  final int limit;

  const StoreCollectionListResponse({
    required this.collections,
    required this.count,
    required this.offset,
    required this.limit,
  });

  factory StoreCollectionListResponse.fromJson(Map<String, dynamic> json) =>
      _$StoreCollectionListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$StoreCollectionListResponseToJson(this);
}

/// Response wrapper for single product category operations
@JsonSerializable(explicitToJson: true)
class StoreProductCategoryResponse {
  @JsonKey(name: 'product_category')
  final StoreProductCategory productCategory;

  const StoreProductCategoryResponse({required this.productCategory});

  factory StoreProductCategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$StoreProductCategoryResponseFromJson(json);
  Map<String, dynamic> toJson() => _$StoreProductCategoryResponseToJson(this);
}

/// Response wrapper for product category list operations
@JsonSerializable(explicitToJson: true)
class StoreProductCategoryListResponse {
  @JsonKey(name: 'product_categories')
  final List<StoreProductCategory> productCategories;
  final int count;
  final int offset;
  final int limit;

  const StoreProductCategoryListResponse({
    required this.productCategories,
    required this.count,
    required this.offset,
    required this.limit,
  });

  factory StoreProductCategoryListResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$StoreProductCategoryListResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$StoreProductCategoryListResponseToJson(this);
}

// Helper functions for num_code conversion
String? _numCodeFromJson(dynamic value) {
  if (value == null) return null;
  if (value is String) return value;
  if (value is int) return value.toString();
  return value.toString();
}

dynamic _numCodeToJson(String? value) => value;
