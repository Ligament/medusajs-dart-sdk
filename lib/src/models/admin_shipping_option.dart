// admin_shipping_option.dart
// AdminShippingOption canonical model - Complete implementation based on @medusajs/types v2.10.1

import 'package:json_annotation/json_annotation.dart';

part 'admin_shipping_option.g.dart';

/// Shipping option price type enumeration
enum ShippingOptionPriceType {
  @JsonValue('calculated')
  calculated,
  @JsonValue('flat')
  flat,
}

/// Rule operator type enumeration
enum RuleOperatorType {
  @JsonValue('eq')
  eq,
  @JsonValue('ne')
  ne,
  @JsonValue('in')
  in_,
  @JsonValue('nin')
  nin,
  @JsonValue('gt')
  gt,
  @JsonValue('gte')
  gte,
  @JsonValue('lt')
  lt,
  @JsonValue('lte')
  lte,
}

/// Admin shipping option type entity
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminShippingOptionType {
  /// The ID of the shipping option type
  final String id;

  /// The label of the shipping option type
  final String label;

  /// The description of the shipping option type
  final String description;

  /// The code of the shipping option type
  final String code;

  /// The ID of the shipping option that this type is created for
  final String shippingOptionId;

  /// When the shipping option type was created
  final DateTime createdAt;

  /// When the shipping option type was updated
  final DateTime updatedAt;

  /// When the shipping option type was deleted
  final DateTime? deletedAt;

  const AdminShippingOptionType({
    required this.id,
    required this.label,
    required this.description,
    required this.code,
    required this.shippingOptionId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory AdminShippingOptionType.fromJson(Map<String, dynamic> json) =>
      _$AdminShippingOptionTypeFromJson(json);

  Map<String, dynamic> toJson() => _$AdminShippingOptionTypeToJson(this);
}

/// Admin shipping option rule entity
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminShippingOptionRule {
  /// The ID of the shipping option rule
  final String id;

  /// The attribute of the shipping option rule
  final String attribute;

  /// The operator of the shipping option rule
  final RuleOperatorType operator;

  /// The value of the shipping option rule
  final dynamic value;

  /// The ID of the shipping option that this rule is created for
  final String shippingOptionId;

  /// When the shipping option rule was created
  final DateTime createdAt;

  /// When the shipping option rule was updated
  final DateTime updatedAt;

  /// When the shipping option rule was deleted
  final DateTime? deletedAt;

  const AdminShippingOptionRule({
    required this.id,
    required this.attribute,
    required this.operator,
    this.value,
    required this.shippingOptionId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory AdminShippingOptionRule.fromJson(Map<String, dynamic> json) =>
      _$AdminShippingOptionRuleFromJson(json);

  Map<String, dynamic> toJson() => _$AdminShippingOptionRuleToJson(this);
}

/// Admin shipping option price rule entity
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminShippingOptionPriceRule {
  /// The ID of the shipping option price rule
  final String id;

  /// The value of the shipping option price rule
  final dynamic value;

  /// The operator of the shipping option price rule
  final RuleOperatorType operator;

  /// The attribute of the shipping option price rule
  final String attribute;

  /// The ID of the shipping option price that this rule is created for
  final String priceId;

  /// The priority of the shipping option price rule
  final int priority;

  /// When the shipping option price rule was created
  final DateTime createdAt;

  /// When the shipping option price rule was updated
  final DateTime updatedAt;

  /// When the shipping option price rule was deleted
  final DateTime? deletedAt;

  const AdminShippingOptionPriceRule({
    required this.id,
    this.value,
    required this.operator,
    required this.attribute,
    required this.priceId,
    required this.priority,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory AdminShippingOptionPriceRule.fromJson(Map<String, dynamic> json) =>
      _$AdminShippingOptionPriceRuleFromJson(json);

  Map<String, dynamic> toJson() => _$AdminShippingOptionPriceRuleToJson(this);
}

/// Admin shipping option price entity extending AdminPrice
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminShippingOptionPrice {
  /// The ID of the price
  final String id;

  /// The price amount
  final num amount;

  /// Currency code
  final String? currencyCode;

  /// Region ID
  final String? regionId;

  /// Min quantity
  final int? minQuantity;

  /// Max quantity
  final int? maxQuantity;

  /// Price rules for the shipping option price
  final List<AdminShippingOptionPriceRule> priceRules;

  /// The number of rules of the shipping option price
  final int rulesCount;

  /// Custom metadata
  final Map<String, dynamic>? metadata;

  /// When the price was created
  final DateTime createdAt;

  /// When the price was updated
  final DateTime updatedAt;

  /// When the price was deleted
  final DateTime? deletedAt;

  const AdminShippingOptionPrice({
    required this.id,
    required this.amount,
    this.currencyCode,
    this.regionId,
    this.minQuantity,
    this.maxQuantity,
    required this.priceRules,
    required this.rulesCount,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory AdminShippingOptionPrice.fromJson(Map<String, dynamic> json) =>
      _$AdminShippingOptionPriceFromJson(json);

  Map<String, dynamic> toJson() => _$AdminShippingOptionPriceToJson(this);
}

/// Admin service zone entity (referenced)
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminServiceZone {
  /// The ID of the service zone
  final String id;

  /// The name of the service zone
  final String name;

  /// Custom metadata
  final Map<String, dynamic>? metadata;

  /// When the service zone was created
  final DateTime createdAt;

  /// When the service zone was updated
  final DateTime updatedAt;

  /// When the service zone was deleted
  final DateTime? deletedAt;

  const AdminServiceZone({
    required this.id,
    required this.name,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory AdminServiceZone.fromJson(Map<String, dynamic> json) =>
      _$AdminServiceZoneFromJson(json);

  Map<String, dynamic> toJson() => _$AdminServiceZoneToJson(this);
}

/// Admin fulfillment provider entity (referenced)
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminFulfillmentProvider {
  /// The ID of the fulfillment provider
  final String id;

  /// The name of the fulfillment provider
  final String name;

  /// Whether the provider is enabled
  final bool isEnabled;

  /// Custom metadata
  final Map<String, dynamic>? metadata;

  const AdminFulfillmentProvider({
    required this.id,
    required this.name,
    required this.isEnabled,
    this.metadata,
  });

  factory AdminFulfillmentProvider.fromJson(Map<String, dynamic> json) =>
      _$AdminFulfillmentProviderFromJson(json);

  Map<String, dynamic> toJson() => _$AdminFulfillmentProviderToJson(this);
}

/// Admin shipping profile entity (referenced)
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminShippingProfile {
  /// The ID of the shipping profile
  final String id;

  /// The name of the shipping profile
  final String name;

  /// The type of the shipping profile
  final String type;

  /// Custom metadata
  final Map<String, dynamic>? metadata;

  /// When the shipping profile was created
  final DateTime createdAt;

  /// When the shipping profile was updated
  final DateTime updatedAt;

  /// When the shipping profile was deleted
  final DateTime? deletedAt;

  const AdminShippingProfile({
    required this.id,
    required this.name,
    required this.type,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory AdminShippingProfile.fromJson(Map<String, dynamic> json) =>
      _$AdminShippingProfileFromJson(json);

  Map<String, dynamic> toJson() => _$AdminShippingProfileToJson(this);
}

/// Admin shipping option entity
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminShippingOption {
  /// The shipping option's ID
  final String id;

  /// The shipping option's name
  final String name;

  /// The type of shipping option's price
  final ShippingOptionPriceType priceType;

  /// The ID of the service zone that the shipping option belongs to
  final String serviceZoneId;

  /// The service zone that the shipping option belongs to
  final AdminServiceZone serviceZone;

  /// The ID of the fulfillment provider that the shipping option belongs to
  final String providerId;

  /// The fulfillment provider that the shipping option belongs to
  final AdminFulfillmentProvider provider;

  /// The ID of the shipping option's type
  final String? shippingOptionTypeId;

  /// The shipping option's type
  final AdminShippingOptionType? type;

  /// The ID of the shipping profile that the shipping option belongs to
  final String shippingProfileId;

  /// The shipping profile that the shipping option belongs to
  final AdminShippingProfile shippingProfile;

  /// The rules of the shipping option
  final List<AdminShippingOptionRule> rules;

  /// The prices of the shipping option
  final List<AdminShippingOptionPrice> prices;

  /// Additional data for third-party fulfillment providers
  final Map<String, dynamic>? data;

  /// Custom metadata
  final Map<String, dynamic>? metadata;

  /// When the shipping option was created
  final DateTime createdAt;

  /// When the shipping option was updated
  final DateTime updatedAt;

  /// When the shipping option was deleted
  final DateTime? deletedAt;

  const AdminShippingOption({
    required this.id,
    required this.name,
    required this.priceType,
    required this.serviceZoneId,
    required this.serviceZone,
    required this.providerId,
    required this.provider,
    this.shippingOptionTypeId,
    this.type,
    required this.shippingProfileId,
    required this.shippingProfile,
    required this.rules,
    required this.prices,
    this.data,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory AdminShippingOption.fromJson(Map<String, dynamic> json) =>
      _$AdminShippingOptionFromJson(json);

  Map<String, dynamic> toJson() => _$AdminShippingOptionToJson(this);
}

// Query Parameters

/// Admin shipping option list parameters
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminShippingOptionListParams {
  /// Filter by shipping option ID(s)
  final List<String>? id;

  /// Query or keywords to search the shipping option's searchable fields
  final String? q;

  /// Filter by the ID of the service zone(s)
  final List<String>? serviceZoneId;

  /// Filter by the ID of the stock location(s)
  final List<String>? stockLocationId;

  /// Filter by whether the shipping option is a return shipping option
  final bool? isReturn;

  /// Filter by whether the shipping option is only available to admins
  final bool? adminOnly;

  /// Filter by the ID of the shipping profile(s)
  final List<String>? shippingProfileId;

  /// Filter by the ID of the provider(s)
  final List<String>? providerId;

  /// Filter by the ID of the shipping option type(s)
  final List<String>? shippingOptionTypeId;

  /// Filter by the date the shipping option was created
  final String? createdAt;

  /// Filter by the date the shipping option was updated
  final String? updatedAt;

  /// Filter by the date the shipping option was deleted
  final String? deletedAt;

  /// Pagination limit
  final int? limit;

  /// Pagination offset
  final int? offset;

  /// Fields to expand in response
  final List<String>? expand;

  /// Fields to select in response
  final List<String>? fields;

  const AdminShippingOptionListParams({
    this.id,
    this.q,
    this.serviceZoneId,
    this.stockLocationId,
    this.isReturn,
    this.adminOnly,
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

  factory AdminShippingOptionListParams.fromJson(Map<String, dynamic> json) =>
      _$AdminShippingOptionListParamsFromJson(json);

  Map<String, dynamic> toJson() => _$AdminShippingOptionListParamsToJson(this);
}

/// Admin shipping option type list parameters
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminShippingOptionTypeListParams {
  /// Query or keywords to apply filters on the type's searchable fields
  final String? q;

  /// Filter by shipping option type ID(s)
  final List<String>? id;

  /// Filter by label(s)
  final List<String>? label;

  /// Filter by code(s)
  final List<String>? code;

  /// Apply filters on the creation date
  final String? createdAt;

  /// Apply filters on the update date
  final String? updatedAt;

  /// Apply filters on the deletion date
  final String? deletedAt;

  /// Pagination limit
  final int? limit;

  /// Pagination offset
  final int? offset;

  /// Fields to expand in response
  final List<String>? expand;

  /// Fields to select in response
  final List<String>? fields;

  const AdminShippingOptionTypeListParams({
    this.q,
    this.id,
    this.label,
    this.code,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.limit,
    this.offset,
    this.expand,
    this.fields,
  });

  factory AdminShippingOptionTypeListParams.fromJson(
    Map<String, dynamic> json,
  ) => _$AdminShippingOptionTypeListParamsFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminShippingOptionTypeListParamsToJson(this);
}

// Create/Update Payloads

/// Admin create shipping option rule payload
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCreateShippingOptionRule {
  /// The operator of the shipping option rule
  final RuleOperatorType operator;

  /// The attribute of the shipping option rule
  final String attribute;

  /// The value of the shipping option rule
  final dynamic value;

  const AdminCreateShippingOptionRule({
    required this.operator,
    required this.attribute,
    this.value,
  });

  factory AdminCreateShippingOptionRule.fromJson(Map<String, dynamic> json) =>
      _$AdminCreateShippingOptionRuleFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCreateShippingOptionRuleToJson(this);
}

/// Admin create shipping option type payload
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCreateShippingOptionType {
  /// The label of the shipping option type
  final String label;

  /// The description of the shipping option type
  final String? description;

  /// The code of the shipping option type
  final String code;

  const AdminCreateShippingOptionType({
    required this.label,
    this.description,
    required this.code,
  });

  factory AdminCreateShippingOptionType.fromJson(Map<String, dynamic> json) =>
      _$AdminCreateShippingOptionTypeFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCreateShippingOptionTypeToJson(this);
}

/// Admin update shipping option type payload
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminUpdateShippingOptionType {
  /// The label of the shipping option type
  final String? label;

  /// The description of the shipping option type
  final String? description;

  /// The code of the shipping option type
  final String? code;

  const AdminUpdateShippingOptionType({
    this.label,
    this.description,
    this.code,
  });

  factory AdminUpdateShippingOptionType.fromJson(Map<String, dynamic> json) =>
      _$AdminUpdateShippingOptionTypeFromJson(json);

  Map<String, dynamic> toJson() => _$AdminUpdateShippingOptionTypeToJson(this);
}

/// Shipping option price rule payload
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminShippingOptionPriceRulePayload {
  /// The operator of the shipping option price rule
  final String operator;

  /// The attribute of the shipping option price rule
  final String attribute;

  /// The value of the shipping option price rule
  final dynamic value;

  const AdminShippingOptionPriceRulePayload({
    required this.operator,
    required this.attribute,
    this.value,
  });

  factory AdminShippingOptionPriceRulePayload.fromJson(
    Map<String, dynamic> json,
  ) => _$AdminShippingOptionPriceRulePayloadFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminShippingOptionPriceRulePayloadToJson(this);
}

/// Base shipping option price with rules
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminShippingOptionPriceWithRules {
  /// The rules of the shipping option price
  final List<AdminShippingOptionPriceRulePayload>? rules;

  const AdminShippingOptionPriceWithRules({this.rules});

  factory AdminShippingOptionPriceWithRules.fromJson(
    Map<String, dynamic> json,
  ) => _$AdminShippingOptionPriceWithRulesFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminShippingOptionPriceWithRulesToJson(this);
}

/// Admin create shipping option price with currency
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCreateShippingOptionPriceWithCurrency
    extends AdminShippingOptionPriceWithRules {
  /// The currency code of the shipping option price
  final String currencyCode;

  /// The amount of the shipping option price
  final num amount;

  const AdminCreateShippingOptionPriceWithCurrency({
    required this.currencyCode,
    required this.amount,
    super.rules,
  });

  factory AdminCreateShippingOptionPriceWithCurrency.fromJson(
    Map<String, dynamic> json,
  ) => _$AdminCreateShippingOptionPriceWithCurrencyFromJson(json);

  @override
  Map<String, dynamic> toJson() =>
      _$AdminCreateShippingOptionPriceWithCurrencyToJson(this);
}

/// Admin create shipping option price with region
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCreateShippingOptionPriceWithRegion
    extends AdminShippingOptionPriceWithRules {
  /// The ID of the region that the shipping option price belongs to
  final String regionId;

  /// The amount of the shipping option price
  final num amount;

  const AdminCreateShippingOptionPriceWithRegion({
    required this.regionId,
    required this.amount,
    super.rules,
  });

  factory AdminCreateShippingOptionPriceWithRegion.fromJson(
    Map<String, dynamic> json,
  ) => _$AdminCreateShippingOptionPriceWithRegionFromJson(json);

  @override
  Map<String, dynamic> toJson() =>
      _$AdminCreateShippingOptionPriceWithRegionToJson(this);
}

/// Admin create shipping option payload
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCreateShippingOption {
  /// The name of the shipping option
  final String name;

  /// The ID of the service zone that the shipping option belongs to
  final String serviceZoneId;

  /// The ID of the shipping profile that the shipping option belongs to
  final String shippingProfileId;

  /// Additional data for third-party fulfillment providers
  final Map<String, dynamic>? data;

  /// The type of shipping option's price
  final ShippingOptionPriceType priceType;

  /// The ID of the fulfillment provider that the shipping option belongs to
  final String providerId;

  /// The type of shipping option
  final AdminCreateShippingOptionType? type;

  /// The ID of the type of shipping option
  final String? typeId;

  /// The prices of the shipping option
  final List<dynamic> prices;

  /// The rules of the shipping option
  final List<AdminCreateShippingOptionRule>? rules;

  const AdminCreateShippingOption({
    required this.name,
    required this.serviceZoneId,
    required this.shippingProfileId,
    this.data,
    required this.priceType,
    required this.providerId,
    this.type,
    this.typeId,
    required this.prices,
    this.rules,
  });

  factory AdminCreateShippingOption.fromJson(Map<String, dynamic> json) =>
      _$AdminCreateShippingOptionFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCreateShippingOptionToJson(this);
}

/// Admin update shipping option rule payload
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminUpdateShippingOptionRule extends AdminCreateShippingOptionRule {
  /// The ID of the shipping option rule that is being updated
  final String id;

  const AdminUpdateShippingOptionRule({
    required this.id,
    required super.operator,
    required super.attribute,
    super.value,
  });

  factory AdminUpdateShippingOptionRule.fromJson(Map<String, dynamic> json) =>
      _$AdminUpdateShippingOptionRuleFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AdminUpdateShippingOptionRuleToJson(this);
}

/// Admin update shipping option price with currency
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminUpdateShippingOptionPriceWithCurrency
    extends AdminShippingOptionPriceWithRules {
  /// The ID of the shipping option price that is being updated
  final String? id;

  /// The currency code of the shipping option price
  final String? currencyCode;

  /// The amount of the shipping option price
  final num? amount;

  const AdminUpdateShippingOptionPriceWithCurrency({
    this.id,
    this.currencyCode,
    this.amount,
    super.rules,
  });

  factory AdminUpdateShippingOptionPriceWithCurrency.fromJson(
    Map<String, dynamic> json,
  ) => _$AdminUpdateShippingOptionPriceWithCurrencyFromJson(json);

  @override
  Map<String, dynamic> toJson() =>
      _$AdminUpdateShippingOptionPriceWithCurrencyToJson(this);
}

/// Admin update shipping option price with region
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminUpdateShippingOptionPriceWithRegion
    extends AdminShippingOptionPriceWithRules {
  /// The ID of the shipping option price that is being updated
  final String? id;

  /// The ID of the region that the shipping option price belongs to
  final String? regionId;

  /// The amount of the shipping option price
  final num? amount;

  const AdminUpdateShippingOptionPriceWithRegion({
    this.id,
    this.regionId,
    this.amount,
    super.rules,
  });

  factory AdminUpdateShippingOptionPriceWithRegion.fromJson(
    Map<String, dynamic> json,
  ) => _$AdminUpdateShippingOptionPriceWithRegionFromJson(json);

  @override
  Map<String, dynamic> toJson() =>
      _$AdminUpdateShippingOptionPriceWithRegionToJson(this);
}

/// Admin update shipping option payload
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminUpdateShippingOption {
  /// The name of the shipping option
  final String? name;

  /// Additional data for third-party fulfillment providers
  final Map<String, dynamic>? data;

  /// The type of shipping option's price
  final ShippingOptionPriceType? priceType;

  /// The ID of the fulfillment provider that the shipping option belongs to
  final String? providerId;

  /// The ID of the shipping profile that the shipping option belongs to
  final String? shippingProfileId;

  /// The type of shipping option
  final AdminCreateShippingOptionType? type;

  /// The ID of the type of shipping option
  final String? typeId;

  /// The prices of the shipping option
  final List<dynamic>? prices;

  /// The rules of the shipping option
  final List<dynamic>? rules;

  const AdminUpdateShippingOption({
    this.name,
    this.data,
    this.priceType,
    this.providerId,
    this.shippingProfileId,
    this.type,
    this.typeId,
    this.prices,
    this.rules,
  });

  factory AdminUpdateShippingOption.fromJson(Map<String, dynamic> json) =>
      _$AdminUpdateShippingOptionFromJson(json);

  Map<String, dynamic> toJson() => _$AdminUpdateShippingOptionToJson(this);
}

/// Admin update shipping option rules payload
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminUpdateShippingOptionRules {
  /// The rules to create
  final List<dynamic>? create;

  /// The rules to update
  final List<dynamic>? update;

  /// The rules to delete
  final List<String>? delete;

  const AdminUpdateShippingOptionRules({this.create, this.update, this.delete});

  factory AdminUpdateShippingOptionRules.fromJson(Map<String, dynamic> json) =>
      _$AdminUpdateShippingOptionRulesFromJson(json);

  Map<String, dynamic> toJson() => _$AdminUpdateShippingOptionRulesToJson(this);
}

// Response Types

/// Admin shipping option response
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminShippingOptionResponse {
  /// The shipping option's details
  final AdminShippingOption shippingOption;

  const AdminShippingOptionResponse({required this.shippingOption});

  factory AdminShippingOptionResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminShippingOptionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminShippingOptionResponseToJson(this);
}

/// Admin shipping option list response
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminShippingOptionListResponse {
  /// The list of shipping options
  final List<AdminShippingOption> shippingOptions;

  /// Total count
  final int? count;

  /// Pagination offset
  final int? offset;

  /// Pagination limit
  final int? limit;

  const AdminShippingOptionListResponse({
    required this.shippingOptions,
    this.count,
    this.offset,
    this.limit,
  });

  factory AdminShippingOptionListResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminShippingOptionListResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminShippingOptionListResponseToJson(this);
}

/// Admin shipping option delete response
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminShippingOptionDeleteResponse {
  /// The ID of the deleted shipping option
  final String id;

  /// The object type
  final String object;

  /// Whether the deletion was successful
  final bool deleted;

  const AdminShippingOptionDeleteResponse({
    required this.id,
    required this.object,
    required this.deleted,
  });

  factory AdminShippingOptionDeleteResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$AdminShippingOptionDeleteResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminShippingOptionDeleteResponseToJson(this);
}

/// Admin update shipping option rules response
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminUpdateShippingOptionRulesResponse {
  /// Created rules
  final List<AdminShippingOptionRule>? created;

  /// Updated rules
  final List<AdminShippingOptionRule>? updated;

  /// Deleted rule IDs
  final List<String>? deleted;

  const AdminUpdateShippingOptionRulesResponse({
    this.created,
    this.updated,
    this.deleted,
  });

  factory AdminUpdateShippingOptionRulesResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$AdminUpdateShippingOptionRulesResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminUpdateShippingOptionRulesResponseToJson(this);
}

/// Admin shipping option type response
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminShippingOptionTypeResponse {
  /// The shipping option type's details
  final AdminShippingOptionType shippingOptionType;

  const AdminShippingOptionTypeResponse({required this.shippingOptionType});

  factory AdminShippingOptionTypeResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminShippingOptionTypeResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminShippingOptionTypeResponseToJson(this);
}

/// Admin shipping option type list response
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminShippingOptionTypeListResponse {
  /// The list of shipping option types
  final List<AdminShippingOptionType> shippingOptionTypes;

  /// Total count
  final int? count;

  /// Pagination offset
  final int? offset;

  /// Pagination limit
  final int? limit;

  const AdminShippingOptionTypeListResponse({
    required this.shippingOptionTypes,
    this.count,
    this.offset,
    this.limit,
  });

  factory AdminShippingOptionTypeListResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$AdminShippingOptionTypeListResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminShippingOptionTypeListResponseToJson(this);
}

/// Admin shipping option type delete response
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminShippingOptionTypeDeleteResponse {
  /// The ID of the deleted shipping option type
  final String id;

  /// The object type
  final String object;

  /// Whether the deletion was successful
  final bool deleted;

  const AdminShippingOptionTypeDeleteResponse({
    required this.id,
    required this.object,
    required this.deleted,
  });

  factory AdminShippingOptionTypeDeleteResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$AdminShippingOptionTypeDeleteResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminShippingOptionTypeDeleteResponseToJson(this);
}
