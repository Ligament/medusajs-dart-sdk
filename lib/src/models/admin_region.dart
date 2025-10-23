import 'package:json_annotation/json_annotation.dart';

part 'admin_region.g.dart';

/// AdminRegion model from official @medusajs/types v2.10.1
///
/// Admin-specific region model with comprehensive region management capabilities.
/// Extends BaseRegion with admin-specific fields, configuration, and relationships.
///
/// Key features:
/// - Complete region configuration management
/// - Currency and taxation settings
/// - Payment and fulfillment provider management
/// - Country and shipping zone configuration
/// - Admin-specific metadata and tracking
///
/// Official Type: AdminRegion extends BaseRegion
@JsonSerializable(explicitToJson: true)
class AdminRegion {
  /// The region's ID
  final String id;

  /// The region's name
  final String name;

  /// The currency code used in this region (ISO 4217)
  @JsonKey(name: 'currency_code')
  final String currencyCode;

  /// Whether taxes are included in prices for this region
  @JsonKey(name: 'includes_tax')
  final bool includesTax;

  /// Whether the region is automatic (system-defined) or manual
  @JsonKey(name: 'automatic_taxes')
  final bool automaticTaxes;

  /// Gift cards usable in this region
  @JsonKey(name: 'gift_cards_taxable')
  final bool giftCardsTaxable;

  /// Countries belonging to this region
  final List<AdminCountry>? countries;

  /// Payment providers available in this region
  @JsonKey(name: 'payment_providers')
  final List<AdminPaymentProvider>? paymentProviders;

  /// Fulfillment providers available in this region
  @JsonKey(name: 'fulfillment_providers')
  final List<AdminFulfillmentProvider>? fulfillmentProviders;

  /// Tax providers for this region
  @JsonKey(name: 'tax_providers')
  final List<AdminTaxProvider>? taxProviders;

  /// Region-specific metadata
  final Map<String, dynamic>? metadata;

  /// When the region was created
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  /// When the region was last updated
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  /// When the region was deleted (soft delete)
  @JsonKey(name: 'deleted_at')
  final DateTime? deletedAt;

  const AdminRegion({
    required this.id,
    required this.name,
    required this.currencyCode,
    required this.includesTax,
    required this.automaticTaxes,
    required this.giftCardsTaxable,
    this.countries,
    this.paymentProviders,
    this.fulfillmentProviders,
    this.taxProviders,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory AdminRegion.fromJson(Map<String, dynamic> json) =>
      _$AdminRegionFromJson(json);

  Map<String, dynamic> toJson() => _$AdminRegionToJson(this);

  /// Check if this region has automatic tax calculation enabled
  bool get hasAutomaticTaxes => automaticTaxes;

  /// Check if this region includes taxes in displayed prices
  bool get hasTaxInclusivePricing => includesTax;

  /// Get country count for this region
  int get countryCount => countries?.length ?? 0;

  /// Get payment provider count for this region
  int get paymentProviderCount => paymentProviders?.length ?? 0;

  /// Get fulfillment provider count for this region
  int get fulfillmentProviderCount => fulfillmentProviders?.length ?? 0;

  /// Check if region has a specific country by ISO code
  bool hasCountry(String isoCode) {
    return countries?.any(
          (country) => country.iso2.toLowerCase() == isoCode.toLowerCase(),
        ) ??
        false;
  }

  /// Get country by ISO code
  AdminCountry? getCountry(String isoCode) {
    return countries?.firstWhere(
      (country) => country.iso2.toLowerCase() == isoCode.toLowerCase(),
      orElse: () => throw StateError('Country not found'),
    );
  }
}

/// Country model for admin region management
@JsonSerializable(explicitToJson: true)
class AdminCountry {
  /// The country's ID
  final String id;

  /// ISO 2-letter country code
  @JsonKey(name: 'iso_2')
  final String iso2;

  /// ISO 3-letter country code
  @JsonKey(name: 'iso_3')
  final String iso3;

  /// Numeric country code
  @JsonKey(name: 'num_code')
  final String numCode;

  /// Country name
  final String name;

  /// Display name for the country
  @JsonKey(name: 'display_name')
  final String displayName;

  /// The region ID this country belongs to
  @JsonKey(name: 'region_id')
  final String? regionId;

  /// Country-specific metadata
  final Map<String, dynamic>? metadata;

  /// When the country was created
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  /// When the country was last updated
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  /// When the country was deleted (soft delete)
  @JsonKey(name: 'deleted_at')
  final DateTime? deletedAt;

  const AdminCountry({
    required this.id,
    required this.iso2,
    required this.iso3,
    required this.numCode,
    required this.name,
    required this.displayName,
    this.regionId,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory AdminCountry.fromJson(Map<String, dynamic> json) =>
      _$AdminCountryFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCountryToJson(this);
}

/// Payment provider model for admin region management
@JsonSerializable(explicitToJson: true)
class AdminPaymentProvider {
  /// The payment provider's ID
  final String id;

  /// Whether the payment provider is enabled
  @JsonKey(name: 'is_enabled')
  final bool isEnabled;

  /// Payment provider metadata
  final Map<String, dynamic>? metadata;

  /// When the payment provider was created
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  /// When the payment provider was last updated
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  /// When the payment provider was deleted (soft delete)
  @JsonKey(name: 'deleted_at')
  final DateTime? deletedAt;

  const AdminPaymentProvider({
    required this.id,
    required this.isEnabled,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory AdminPaymentProvider.fromJson(Map<String, dynamic> json) =>
      _$AdminPaymentProviderFromJson(json);

  Map<String, dynamic> toJson() => _$AdminPaymentProviderToJson(this);
}

/// Fulfillment provider model for admin region management
@JsonSerializable(explicitToJson: true)
class AdminFulfillmentProvider {
  /// The fulfillment provider's ID
  final String id;

  /// Whether the fulfillment provider is enabled
  @JsonKey(name: 'is_enabled')
  final bool isEnabled;

  /// Fulfillment provider metadata
  final Map<String, dynamic>? metadata;

  /// When the fulfillment provider was created
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  /// When the fulfillment provider was last updated
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  /// When the fulfillment provider was deleted (soft delete)
  @JsonKey(name: 'deleted_at')
  final DateTime? deletedAt;

  const AdminFulfillmentProvider({
    required this.id,
    required this.isEnabled,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory AdminFulfillmentProvider.fromJson(Map<String, dynamic> json) =>
      _$AdminFulfillmentProviderFromJson(json);

  Map<String, dynamic> toJson() => _$AdminFulfillmentProviderToJson(this);
}

/// Tax provider model for admin region management
@JsonSerializable(explicitToJson: true)
class AdminTaxProvider {
  /// The tax provider's ID
  final String id;

  /// Whether the tax provider is enabled
  @JsonKey(name: 'is_enabled')
  final bool isEnabled;

  /// Tax provider metadata
  final Map<String, dynamic>? metadata;

  /// When the tax provider was created
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  /// When the tax provider was last updated
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  /// When the tax provider was deleted (soft delete)
  @JsonKey(name: 'deleted_at')
  final DateTime? deletedAt;

  const AdminTaxProvider({
    required this.id,
    required this.isEnabled,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory AdminTaxProvider.fromJson(Map<String, dynamic> json) =>
      _$AdminTaxProviderFromJson(json);

  Map<String, dynamic> toJson() => _$AdminTaxProviderToJson(this);
}
