// admin_tax.dart
// AdminTax canonical model - Complete implementation based on @medusajs/types v2.10.1

import 'package:json_annotation/json_annotation.dart';

part 'admin_tax.g.dart';

/// Admin tax provider entity
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminTaxProvider {
  /// The ID of the tax provider
  final String id;

  /// Whether the tax provider is enabled
  final bool isEnabled;

  const AdminTaxProvider({required this.id, required this.isEnabled});

  factory AdminTaxProvider.fromJson(Map<String, dynamic> json) =>
      _$AdminTaxProviderFromJson(json);

  Map<String, dynamic> toJson() => _$AdminTaxProviderToJson(this);
}

/// Admin tax rate rule entity
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminTaxRateRule {
  /// The name of the table that the rule references
  /// @example "product_type"
  final String reference;

  /// The ID of the record in the table that the rule references
  /// @example "protyp_123"
  final String referenceId;

  const AdminTaxRateRule({required this.reference, required this.referenceId});

  factory AdminTaxRateRule.fromJson(Map<String, dynamic> json) =>
      _$AdminTaxRateRuleFromJson(json);

  Map<String, dynamic> toJson() => _$AdminTaxRateRuleToJson(this);
}

/// Admin tax region entity
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminTaxRegion {
  /// The tax region's ID
  final String id;

  /// The tax region's country code
  /// @example "us"
  final String? countryCode;

  /// The tax region's lower-case ISO 3166-2 province or state code
  /// @example "us-ca"
  final String? provinceCode;

  /// Custom key-value pairs that can be added to the tax region
  final Map<String, dynamic>? metadata;

  /// The ID of the parent tax region
  final String? parentId;

  /// The ID of the tax provider for the region
  final String? providerId;

  /// The date the tax region was created
  final DateTime createdAt;

  /// The date the tax region was updated
  final DateTime updatedAt;

  /// The date the tax region was deleted
  final DateTime? deletedAt;

  /// The ID of the user who created the tax region
  final String? createdBy;

  /// The tax rates associated with the tax region
  final List<AdminTaxRate> taxRates;

  /// The parent tax region
  final AdminTaxRegion? parent;

  /// The child tax regions
  final List<AdminTaxRegion> children;

  const AdminTaxRegion({
    required this.id,
    this.countryCode,
    this.provinceCode,
    this.metadata,
    this.parentId,
    this.providerId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.createdBy,
    required this.taxRates,
    this.parent,
    required this.children,
  });

  factory AdminTaxRegion.fromJson(Map<String, dynamic> json) =>
      _$AdminTaxRegionFromJson(json);

  Map<String, dynamic> toJson() => _$AdminTaxRegionToJson(this);
}

/// Admin tax rate entity
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminTaxRate {
  /// The tax rate's ID
  final String id;

  /// The tax rate's percentage rate
  final num? rate;

  /// The tax rate's code
  final String code;

  /// The tax rate's name
  final String name;

  /// Custom key-value pairs that can be added to the tax rate
  final Map<String, dynamic>? metadata;

  /// The ID of the tax region associated with the tax rate
  final String taxRegionId;

  /// Whether the tax rate is combinable with other tax rates
  final bool isCombinable;

  /// Whether the tax rate is the default tax rate in its tax region
  final bool isDefault;

  /// The date the tax rate was created
  final DateTime createdAt;

  /// The date the tax rate was updated
  final DateTime updatedAt;

  /// The date the tax rate was deleted
  final DateTime? deletedAt;

  /// The ID of the user who created the tax rate
  final String? createdBy;

  /// The tax region associated with the tax rate
  final AdminTaxRegion taxRegion;

  /// The rules associated with the tax rate
  final List<AdminTaxRateRule> rules;

  const AdminTaxRate({
    required this.id,
    this.rate,
    required this.code,
    required this.name,
    this.metadata,
    required this.taxRegionId,
    required this.isCombinable,
    required this.isDefault,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.createdBy,
    required this.taxRegion,
    required this.rules,
  });

  factory AdminTaxRate.fromJson(Map<String, dynamic> json) =>
      _$AdminTaxRateFromJson(json);

  Map<String, dynamic> toJson() => _$AdminTaxRateToJson(this);
}

// Query Parameters

/// Admin tax providers list parameters
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminGetTaxProvidersParams {
  /// Filter by tax provider ID(s)
  final List<String>? id;

  /// Whether the tax provider is enabled
  final bool? isEnabled;

  /// Pagination limit
  final int? limit;

  /// Pagination offset
  final int? offset;

  /// Fields to expand in response
  final List<String>? expand;

  /// Fields to select in response
  final List<String>? fields;

  const AdminGetTaxProvidersParams({
    this.id,
    this.isEnabled,
    this.limit,
    this.offset,
    this.expand,
    this.fields,
  });

  factory AdminGetTaxProvidersParams.fromJson(Map<String, dynamic> json) =>
      _$AdminGetTaxProvidersParamsFromJson(json);

  Map<String, dynamic> toJson() => _$AdminGetTaxProvidersParamsToJson(this);
}

/// Admin tax rate list parameters
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminTaxRateListParams {
  /// Query or keywords to search the tax rate's searchable fields
  final String? q;

  /// Filter by tax region ID(s)
  final List<String>? taxRegionId;

  /// Filter by whether the tax rate is the default tax rate in its tax region
  final String? isDefault; // "true" or "false"

  /// Filter by service zone ID(s) to retrieve tax rates that are associated with the service zones
  final String? serviceZoneId;

  /// Filter by shipping profile ID(s) to retrieve tax rates that are associated with the shipping profiles
  final String? shippingProfileId;

  /// Filter by tax provider ID(s) to retrieve tax rates that are associated with the providers
  final String? providerId;

  /// Filter by shipping option type ID(s) to retrieve tax rates that are associated with the shipping option types
  final String? shippingOptionTypeId;

  /// Filter by the date the tax rate was created
  final String? createdAt;

  /// Filter by the date the tax rate was updated
  final String? updatedAt;

  /// Filter by the date the tax rate was deleted
  final String? deletedAt;

  /// Pagination limit
  final int? limit;

  /// Pagination offset
  final int? offset;

  /// Fields to expand in response
  final List<String>? expand;

  /// Fields to select in response
  final List<String>? fields;

  const AdminTaxRateListParams({
    this.q,
    this.taxRegionId,
    this.isDefault,
    this.serviceZoneId,
    this.shippingProfileId,
    this.providerId,
    this.shippingOptionTypeId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.limit,
    this.offset,
    this.expand,
    this.fields,
  });

  factory AdminTaxRateListParams.fromJson(Map<String, dynamic> json) =>
      _$AdminTaxRateListParamsFromJson(json);

  Map<String, dynamic> toJson() => _$AdminTaxRateListParamsToJson(this);
}

/// Admin tax region list parameters
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminTaxRegionListParams {
  /// Query or keywords to search the tax region's searchable fields
  final String? q;

  /// Filter by tax region ID(s)
  final List<String>? id;

  /// Filter by country code(s)
  final List<String>? countryCode;

  /// Filter by province code(s)
  final List<String>? provinceCode;

  /// Filter by parent tax region ID(s)
  final List<String>? parentId;

  /// Filter by tax provider ID(s)
  final List<String>? providerId;

  /// Filter by the date the tax region was created
  final String? createdAt;

  /// Filter by the date the tax region was updated
  final String? updatedAt;

  /// Filter by the date the tax region was deleted
  final String? deletedAt;

  /// Pagination limit
  final int? limit;

  /// Pagination offset
  final int? offset;

  /// Fields to expand in response
  final List<String>? expand;

  /// Fields to select in response
  final List<String>? fields;

  const AdminTaxRegionListParams({
    this.q,
    this.id,
    this.countryCode,
    this.provinceCode,
    this.parentId,
    this.providerId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.limit,
    this.offset,
    this.expand,
    this.fields,
  });

  factory AdminTaxRegionListParams.fromJson(Map<String, dynamic> json) =>
      _$AdminTaxRegionListParamsFromJson(json);

  Map<String, dynamic> toJson() => _$AdminTaxRegionListParamsToJson(this);
}

// Create/Update Payloads

/// Admin create tax rate rule payload
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCreateTaxRateRule {
  /// The name of the table that the rule references
  /// @example "product_type"
  final String reference;

  /// The ID of the record in the table that the rule references
  /// @example "protyp_123"
  final String referenceId;

  const AdminCreateTaxRateRule({
    required this.reference,
    required this.referenceId,
  });

  factory AdminCreateTaxRateRule.fromJson(Map<String, dynamic> json) =>
      _$AdminCreateTaxRateRuleFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCreateTaxRateRuleToJson(this);
}

/// Default tax rate payload for tax region creation
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCreateDefaultTaxRate {
  /// The percentage rate of the default tax rate
  final num? rate;

  /// The code of the default tax rate
  final String code;

  /// The name of the default tax rate
  final String name;

  /// Whether the default tax rate is combinable with other tax rates
  final bool? isCombinable;

  /// Custom key-value pairs that can be added to the default tax rate
  final Map<String, dynamic>? metadata;

  const AdminCreateDefaultTaxRate({
    this.rate,
    required this.code,
    required this.name,
    this.isCombinable,
    this.metadata,
  });

  factory AdminCreateDefaultTaxRate.fromJson(Map<String, dynamic> json) =>
      _$AdminCreateDefaultTaxRateFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCreateDefaultTaxRateToJson(this);
}

/// Admin create tax region payload
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCreateTaxRegion {
  /// The country code of the tax region
  final String countryCode;

  /// The ID of the tax provider
  final String? providerId;

  /// The lower-case ISO 3166-2 province or state code of the tax region
  final String? provinceCode;

  /// The ID of the parent tax region
  final String? parentId;

  /// The default tax rate of the tax region
  final AdminCreateDefaultTaxRate? defaultTaxRate;

  /// Custom key-value pairs that can be added to the tax region
  final Map<String, dynamic>? metadata;

  const AdminCreateTaxRegion({
    required this.countryCode,
    this.providerId,
    this.provinceCode,
    this.parentId,
    this.defaultTaxRate,
    this.metadata,
  });

  factory AdminCreateTaxRegion.fromJson(Map<String, dynamic> json) =>
      _$AdminCreateTaxRegionFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCreateTaxRegionToJson(this);
}

/// Admin update tax region payload
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminUpdateTaxRegion {
  /// The lower-case ISO 3166-2 province or state code of the tax region
  final String? provinceCode;

  /// The ID of the tax provider
  final String? providerId;

  /// Custom key-value pairs that can be added to the tax region
  final Map<String, dynamic>? metadata;

  const AdminUpdateTaxRegion({
    this.provinceCode,
    this.providerId,
    this.metadata,
  });

  factory AdminUpdateTaxRegion.fromJson(Map<String, dynamic> json) =>
      _$AdminUpdateTaxRegionFromJson(json);

  Map<String, dynamic> toJson() => _$AdminUpdateTaxRegionToJson(this);
}

/// Admin create tax rate payload
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCreateTaxRate {
  /// The name of the tax rate
  final String name;

  /// The ID of the tax region associated with the tax rate
  final String taxRegionId;

  /// The rate of the tax rate
  final num? rate;

  /// The code of the tax rate
  final String code;

  /// The rules of the tax rate
  final List<AdminCreateTaxRateRule>? rules;

  /// Whether the tax rate is the default tax rate in its tax region
  final bool? isDefault;

  /// Whether the tax rate is combinable with other tax rates
  final bool? isCombinable;

  /// Custom key-value pairs that can be added to the tax rate
  final Map<String, dynamic>? metadata;

  const AdminCreateTaxRate({
    required this.name,
    required this.taxRegionId,
    this.rate,
    required this.code,
    this.rules,
    this.isDefault,
    this.isCombinable,
    this.metadata,
  });

  factory AdminCreateTaxRate.fromJson(Map<String, dynamic> json) =>
      _$AdminCreateTaxRateFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCreateTaxRateToJson(this);
}

/// Admin update tax rate payload
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminUpdateTaxRate {
  /// The name of the tax rate
  final String? name;

  /// The percentage rate of the tax rate
  final num? rate;

  /// The code of the tax rate
  final String code;

  /// The rules of the tax rate
  final List<AdminCreateTaxRateRule>? rules;

  /// Whether the tax rate is the default tax rate in its tax region
  final bool? isDefault;

  /// Whether the tax rate is combinable with other tax rates
  final bool? isCombinable;

  /// Custom key-value pairs that can be added to the tax rate
  final Map<String, dynamic>? metadata;

  const AdminUpdateTaxRate({
    this.name,
    this.rate,
    required this.code,
    this.rules,
    this.isDefault,
    this.isCombinable,
    this.metadata,
  });

  factory AdminUpdateTaxRate.fromJson(Map<String, dynamic> json) =>
      _$AdminUpdateTaxRateFromJson(json);

  Map<String, dynamic> toJson() => _$AdminUpdateTaxRateToJson(this);
}

// Response Types

/// Admin tax provider list response
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminTaxProviderListResponse {
  /// The list of tax providers
  final List<AdminTaxProvider> taxProviders;

  /// Total count
  final int? count;

  /// Pagination offset
  final int? offset;

  /// Pagination limit
  final int? limit;

  const AdminTaxProviderListResponse({
    required this.taxProviders,
    this.count,
    this.offset,
    this.limit,
  });

  factory AdminTaxProviderListResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminTaxProviderListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminTaxProviderListResponseToJson(this);
}

/// Admin tax rate response
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminTaxRateResponse {
  /// The tax rate's details
  final AdminTaxRate taxRate;

  const AdminTaxRateResponse({required this.taxRate});

  factory AdminTaxRateResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminTaxRateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminTaxRateResponseToJson(this);
}

/// Admin tax rate list response
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminTaxRateListResponse {
  /// The list of tax rates
  final List<AdminTaxRate> taxRates;

  /// Total count
  final int? count;

  /// Pagination offset
  final int? offset;

  /// Pagination limit
  final int? limit;

  const AdminTaxRateListResponse({
    required this.taxRates,
    this.count,
    this.offset,
    this.limit,
  });

  factory AdminTaxRateListResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminTaxRateListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminTaxRateListResponseToJson(this);
}

/// Admin tax rate delete response
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminTaxRateDeleteResponse {
  /// The ID of the deleted tax rate
  final String id;

  /// The object type
  final String object;

  /// Whether the deletion was successful
  final bool deleted;

  const AdminTaxRateDeleteResponse({
    required this.id,
    required this.object,
    required this.deleted,
  });

  factory AdminTaxRateDeleteResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminTaxRateDeleteResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminTaxRateDeleteResponseToJson(this);
}

/// Admin tax rate rule delete response
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminTaxRateRuleDeleteResponse {
  /// The ID of the deleted tax rate rule
  final String id;

  /// The object type
  final String object;

  /// Whether the deletion was successful
  final bool deleted;

  /// The parent tax rate object
  final AdminTaxRate parent;

  const AdminTaxRateRuleDeleteResponse({
    required this.id,
    required this.object,
    required this.deleted,
    required this.parent,
  });

  factory AdminTaxRateRuleDeleteResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminTaxRateRuleDeleteResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminTaxRateRuleDeleteResponseToJson(this);
}

/// Admin tax region response
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminTaxRegionResponse {
  /// The tax region's details
  final AdminTaxRegion taxRegion;

  const AdminTaxRegionResponse({required this.taxRegion});

  factory AdminTaxRegionResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminTaxRegionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminTaxRegionResponseToJson(this);
}

/// Admin tax region list response
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminTaxRegionListResponse {
  /// The list of tax regions
  final List<AdminTaxRegion> taxRegions;

  /// Total count
  final int? count;

  /// Pagination offset
  final int? offset;

  /// Pagination limit
  final int? limit;

  const AdminTaxRegionListResponse({
    required this.taxRegions,
    this.count,
    this.offset,
    this.limit,
  });

  factory AdminTaxRegionListResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminTaxRegionListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminTaxRegionListResponseToJson(this);
}

/// Admin tax region delete response
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminTaxRegionDeleteResponse {
  /// The ID of the deleted tax region
  final String id;

  /// The object type
  final String object;

  /// Whether the deletion was successful
  final bool deleted;

  const AdminTaxRegionDeleteResponse({
    required this.id,
    required this.object,
    required this.deleted,
  });

  factory AdminTaxRegionDeleteResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminTaxRegionDeleteResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminTaxRegionDeleteResponseToJson(this);
}
