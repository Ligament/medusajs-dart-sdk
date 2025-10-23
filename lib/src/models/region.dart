import 'package:json_annotation/json_annotation.dart';

part 'region.g.dart';

/// Represents a region in the Medusa system
@JsonSerializable(fieldRename: FieldRename.snake)
class Region {
  /// Unique identifier for the region
  final String id;

  /// Region name
  final String name;

  /// Currency code (ISO 4217)
  final String currencyCode;

  /// Tax rate for the region
  final double? taxRate;

  /// Tax code
  final String? taxCode;

  /// List of countries in this region
  final List<Country>? countries;

  /// List of payment providers available in this region
  final List<PaymentProvider>? paymentProviders;

  /// List of fulfillment providers available in this region
  final List<FulfillmentProvider>? fulfillmentProviders;

  /// Whether the region includes taxes in prices
  final bool? includesTax;

  /// Timestamp of creation
  final DateTime? createdAt;

  /// Timestamp of last update
  final DateTime? updatedAt;

  /// Timestamp of deletion (soft delete)
  final DateTime? deletedAt;

  /// Metadata associated with the region
  final Map<String, dynamic>? metadata;

  const Region({
    required this.id,
    required this.name,
    required this.currencyCode,
    this.taxRate,
    this.taxCode,
    this.countries,
    this.paymentProviders,
    this.fulfillmentProviders,
    this.includesTax,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.metadata,
  });

  factory Region.fromJson(Map<String, dynamic> json) => _$RegionFromJson(json);
  Map<String, dynamic> toJson() => _$RegionToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Region && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'Region(id: $id, name: $name, currencyCode: $currencyCode)';
}

/// Represents a country in the Medusa system
@JsonSerializable(fieldRename: FieldRename.snake)
class Country {
  /// ISO 2-letter country code
  @JsonKey(name: 'iso_2')
  final String iso2;

  /// ISO 3-letter country code
  @JsonKey(name: 'iso_3')
  final String iso3;

  /// Numeric country code (can be int or string in the API)
  @JsonKey(name: 'num_code', fromJson: _numCodeFromJson, toJson: _numCodeToJson)
  final String numCode;

  /// Country name
  final String name;

  /// Country display name
  final String displayName;

  /// Region ID this country belongs to
  final String? regionId;

  /// Metadata associated with the country
  final Map<String, dynamic>? metadata;

  /// Timestamp of creation
  final DateTime? createdAt;

  /// Timestamp of last update
  final DateTime? updatedAt;

  /// Timestamp of deletion (soft delete)
  final DateTime? deletedAt;

  const Country({
    required this.iso2,
    required this.iso3,
    required this.numCode,
    required this.name,
    required this.displayName,
    this.regionId,
    this.metadata,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);
  Map<String, dynamic> toJson() => _$CountryToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Country &&
          runtimeType == other.runtimeType &&
          iso2 == other.iso2;

  @override
  int get hashCode => iso2.hashCode;

  @override
  String toString() => 'Country(iso2: $iso2, name: $name)';
}

/// Represents a payment provider
@JsonSerializable(fieldRename: FieldRename.snake)
class PaymentProvider {
  /// Unique identifier for the payment provider
  final String id;

  /// Whether the provider is installed
  final bool isInstalled;

  const PaymentProvider({required this.id, required this.isInstalled});

  factory PaymentProvider.fromJson(Map<String, dynamic> json) =>
      _$PaymentProviderFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentProviderToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentProvider &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'PaymentProvider(id: $id, isInstalled: $isInstalled)';
}

/// Represents a fulfillment provider
@JsonSerializable(fieldRename: FieldRename.snake)
class FulfillmentProvider {
  /// Unique identifier for the fulfillment provider
  final String id;

  /// Whether the provider is installed
  final bool isInstalled;

  const FulfillmentProvider({required this.id, required this.isInstalled});

  factory FulfillmentProvider.fromJson(Map<String, dynamic> json) =>
      _$FulfillmentProviderFromJson(json);
  Map<String, dynamic> toJson() => _$FulfillmentProviderToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FulfillmentProvider &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'FulfillmentProvider(id: $id, isInstalled: $isInstalled)';
}

/// Helper function to convert num_code from int or string to string
String _numCodeFromJson(dynamic value) {
  if (value is int) {
    return value.toString();
  } else if (value is String) {
    return value;
  } else {
    throw FormatException(
      'Expected int or String for num_code, got ${value.runtimeType}',
    );
  }
}

/// Helper function to convert num_code from string to dynamic for JSON
dynamic _numCodeToJson(String value) => value;
