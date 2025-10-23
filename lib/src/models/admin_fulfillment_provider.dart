/// Canonical Admin Fulfillment Provider models based on @medusajs/types v2.10.1
///
/// Provides fulfillment provider management functionality with complete
/// API compatibility and type safety.

import 'package:json_annotation/json_annotation.dart';

part 'admin_fulfillment_provider.g.dart';

// =============================================================================
// FULFILLMENT PROVIDER MODELS (Canonical v2.10.1)
// =============================================================================

/// Base fulfillment provider as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class BaseFulfillmentProvider {
  /// The fulfillment provider's ID
  final String id;

  /// Whether the fulfillment provider is enabled
  final bool isEnabled;

  const BaseFulfillmentProvider({required this.id, required this.isEnabled});

  factory BaseFulfillmentProvider.fromJson(Map<String, dynamic> json) =>
      _$BaseFulfillmentProviderFromJson(json);

  Map<String, dynamic> toJson() => _$BaseFulfillmentProviderToJson(this);
}

/// Admin fulfillment provider as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminFulfillmentProvider extends BaseFulfillmentProvider {
  /// The name of the fulfillment provider
  final String? name;

  /// Holds custom data in key-value pairs
  final Map<String, dynamic>? metadata;

  /// The creation date of the fulfillment provider
  final DateTime? createdAt;

  /// The update date of the fulfillment provider
  final DateTime? updatedAt;

  /// The deletion date of the fulfillment provider
  final DateTime? deletedAt;

  const AdminFulfillmentProvider({
    required super.id,
    required super.isEnabled,
    this.name,
    this.metadata,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory AdminFulfillmentProvider.fromJson(Map<String, dynamic> json) =>
      _$AdminFulfillmentProviderFromJson(json);

  Map<String, dynamic> toJson() => _$AdminFulfillmentProviderToJson(this);
}

/// Base fulfillment provider option as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class BaseFulfillmentProviderOption {
  /// The fulfillment provider option's ID
  final String id;

  /// Whether the fulfillment provider option can be used for returns
  final bool isReturn;

  const BaseFulfillmentProviderOption({
    required this.id,
    required this.isReturn,
  });

  factory BaseFulfillmentProviderOption.fromJson(Map<String, dynamic> json) =>
      _$BaseFulfillmentProviderOptionFromJson(json);

  Map<String, dynamic> toJson() => _$BaseFulfillmentProviderOptionToJson(this);
}

/// Admin fulfillment provider option as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminFulfillmentProviderOption extends BaseFulfillmentProviderOption {
  /// The name of the fulfillment provider option
  final String? name;

  /// Additional metadata for the option
  final Map<String, dynamic>? metadata;

  const AdminFulfillmentProviderOption({
    required super.id,
    required super.isReturn,
    this.name,
    this.metadata,
  });

  factory AdminFulfillmentProviderOption.fromJson(Map<String, dynamic> json) =>
      _$AdminFulfillmentProviderOptionFromJson(json);

  Map<String, dynamic> toJson() => _$AdminFulfillmentProviderOptionToJson(this);
}

// =============================================================================
// FULFILLMENT PROVIDER QUERIES
// =============================================================================

/// Admin fulfillment provider list parameters as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminFulfillmentProviderListParams {
  /// Filter by provider ID(s)
  final List<String>? id;

  /// Query or keywords to filter the provider's searchable fields
  final String? q;

  /// Filter by whether the provider is enabled
  final bool? isEnabled;

  /// Filter by stock location ID(s) to retrieve their associated fulfillment providers
  final List<String>? stockLocationId;

  /// Number of providers to skip for pagination
  final int? offset;

  /// Maximum number of providers to return
  final int? limit;

  /// Sort order for the results
  final String? order;

  /// Fields to include in the response
  final List<String>? fields;

  /// Relations to expand in the response
  final List<String>? expand;

  const AdminFulfillmentProviderListParams({
    this.id,
    this.q,
    this.isEnabled,
    this.stockLocationId,
    this.offset,
    this.limit,
    this.order,
    this.fields,
    this.expand,
  });

  factory AdminFulfillmentProviderListParams.fromJson(
    Map<String, dynamic> json,
  ) => _$AdminFulfillmentProviderListParamsFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminFulfillmentProviderListParamsToJson(this);
}

// =============================================================================
// FULFILLMENT PROVIDER RESPONSES
// =============================================================================

/// Admin fulfillment provider list response as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminFulfillmentProviderListResponse {
  /// The list of fulfillment providers
  final List<AdminFulfillmentProvider> fulfillmentProviders;

  /// Total count of fulfillment providers
  final int? count;

  /// Number of providers skipped
  final int? offset;

  /// Number of providers returned
  final int? limit;

  const AdminFulfillmentProviderListResponse({
    required this.fulfillmentProviders,
    this.count,
    this.offset,
    this.limit,
  });

  factory AdminFulfillmentProviderListResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$AdminFulfillmentProviderListResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminFulfillmentProviderListResponseToJson(this);
}

/// Admin fulfillment provider options list response as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminFulfillmentProviderOptionsListResponse {
  /// The list of fulfillment options
  final List<AdminFulfillmentProviderOption> fulfillmentOptions;

  /// Total count of fulfillment options
  final int? count;

  /// Number of options skipped
  final int? offset;

  /// Number of options returned
  final int? limit;

  const AdminFulfillmentProviderOptionsListResponse({
    required this.fulfillmentOptions,
    this.count,
    this.offset,
    this.limit,
  });

  factory AdminFulfillmentProviderOptionsListResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$AdminFulfillmentProviderOptionsListResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminFulfillmentProviderOptionsListResponseToJson(this);
}

/// Admin fulfillment provider response as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminFulfillmentProviderResponse {
  /// The fulfillment provider details
  final AdminFulfillmentProvider fulfillmentProvider;

  const AdminFulfillmentProviderResponse({required this.fulfillmentProvider});

  factory AdminFulfillmentProviderResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$AdminFulfillmentProviderResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminFulfillmentProviderResponseToJson(this);
}
