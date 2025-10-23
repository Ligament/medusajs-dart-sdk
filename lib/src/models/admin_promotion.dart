///  Admin Promotion models from @medusajs/types v2.10.1
///
/// Comprehensive promotion management models following Medusa v2.10 specifications.
/// Covers promotions, campaigns, application methods, rules, and promotional strategies.

import 'package:json_annotation/json_annotation.dart';

part 'admin_promotion.g.dart';

// ==========================================
// Core Admin Promotion Models
// ==========================================

/// Admin promotion from @medusajs/types AdminPromotion
///
/// Represents a promotional offer with rules, application methods,
/// and integration with marketing campaigns for discount management.
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminPromotion {
  /// The promotion's ID
  final String id;

  /// The promotion's code
  final String? code;

  /// The promotion's type
  final AdminPromotionType type;

  /// Whether the promotion is applied on a cart automatically if it matches the promotion's rules
  final bool isAutomatic;

  /// The ID of the campaign this promotion belongs to
  final String? campaignId;

  /// The campaign this promotion belongs to
  final AdminCampaign? campaign;

  /// The promotion's application method
  final AdminApplicationMethod? applicationMethod;

  /// The promotion's rules
  final List<AdminPromotionRule> rules;

  /// The promotion's status
  final AdminPromotionStatus status;

  /// The date the promotion was created
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  /// The date the promotion was updated
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  /// The date the promotion was deleted
  @JsonKey(name: 'deleted_at')
  final DateTime? deletedAt;

  const AdminPromotion({
    required this.id,
    required this.type,
    required this.isAutomatic,
    required this.rules,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.code,
    this.campaignId,
    this.campaign,
    this.applicationMethod,
    this.deletedAt,
  });

  factory AdminPromotion.fromJson(Map<String, dynamic> json) =>
      _$AdminPromotionFromJson(json);

  Map<String, dynamic> toJson() => _$AdminPromotionToJson(this);
}

/// Admin promotion type enumeration
enum AdminPromotionType {
  @JsonValue('standard')
  standard,
  @JsonValue('buyget')
  buyget,
}

/// Admin promotion status enumeration
enum AdminPromotionStatus {
  @JsonValue('draft')
  draft,
  @JsonValue('active')
  active,
  @JsonValue('inactive')
  inactive,
}

/// Admin promotion rule from @medusajs/types AdminPromotionRule
///
/// Defines conditions that must be met for a promotion to be applicable.
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminPromotionRule {
  /// The promotion rule's ID
  final String id;

  /// The promotion rule's description
  final String? description;

  /// The promotion rule's attribute
  final String attribute;

  /// The rule's operator
  final AdminPromotionRuleOperator operator;

  /// The rule's values
  final List<AdminPromotionRuleValue> values;

  const AdminPromotionRule({
    required this.id,
    required this.attribute,
    required this.operator,
    required this.values,
    this.description,
  });

  factory AdminPromotionRule.fromJson(Map<String, dynamic> json) =>
      _$AdminPromotionRuleFromJson(json);

  Map<String, dynamic> toJson() => _$AdminPromotionRuleToJson(this);
}

/// Admin promotion rule operator enumeration
enum AdminPromotionRuleOperator {
  @JsonValue('gt')
  gt,
  @JsonValue('lt')
  lt,
  @JsonValue('eq')
  eq,
  @JsonValue('ne')
  ne,
  @JsonValue('in')
  in_,
  @JsonValue('lte')
  lte,
  @JsonValue('gte')
  gte,
}

/// Admin promotion rule value from @medusajs/types BasePromotionRuleValue
///
/// Contains the specific values to match against for promotion rules.
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminPromotionRuleValue {
  /// The value's ID
  final String id;

  /// The value
  final String value;

  const AdminPromotionRuleValue({required this.id, required this.value});

  factory AdminPromotionRuleValue.fromJson(Map<String, dynamic> json) =>
      _$AdminPromotionRuleValueFromJson(json);

  Map<String, dynamic> toJson() => _$AdminPromotionRuleValueToJson(this);
}

/// Admin application method from @medusajs/types AdminApplicationMethod
///
/// Defines how a promotion discount is calculated and applied.
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminApplicationMethod {
  /// The application method's ID
  final String id;

  /// The application method's type
  final AdminApplicationMethodType type;

  /// Which item does the promotion apply to
  final AdminApplicationMethodTargetType targetType;

  /// How is the promotion amount discounted
  final AdminApplicationMethodAllocation allocation;

  /// The amount to be discounted
  final double value;

  /// The application method's currency code
  final String? currencyCode;

  /// The max quantity allowed in the cart for the associated promotion to be applied
  final double? maxQuantity;

  /// The minimum quantity required for a buyget promotion to be applied
  final double? buyRulesMinQuantity;

  /// The quantity that results from matching the buyget promotion's condition
  final double? applyToQuantity;

  /// The promotion associated with this application method
  final Map<String, dynamic>? promotion;

  /// The application method's target rules
  final List<AdminPromotionRule>? targetRules;

  /// The application method's buy rules
  final List<AdminPromotionRule>? buyRules;

  const AdminApplicationMethod({
    required this.id,
    required this.type,
    required this.targetType,
    required this.allocation,
    required this.value,
    this.currencyCode,
    this.maxQuantity,
    this.buyRulesMinQuantity,
    this.applyToQuantity,
    this.promotion,
    this.targetRules,
    this.buyRules,
  });

  factory AdminApplicationMethod.fromJson(Map<String, dynamic> json) =>
      _$AdminApplicationMethodFromJson(json);

  Map<String, dynamic> toJson() => _$AdminApplicationMethodToJson(this);
}

/// Admin application method type enumeration
enum AdminApplicationMethodType {
  @JsonValue('fixed')
  fixed,
  @JsonValue('percentage')
  percentage,
}

/// Admin application method target type enumeration
enum AdminApplicationMethodTargetType {
  @JsonValue('items')
  items,
  @JsonValue('shipping_methods')
  shippingMethods,
  @JsonValue('order')
  order,
}

/// Admin application method allocation enumeration
enum AdminApplicationMethodAllocation {
  @JsonValue('each')
  each,
  @JsonValue('across')
  across,
}

/// Admin campaign from @medusajs/types AdminCampaign
///
/// Represents a marketing campaign that can contain multiple promotions.
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCampaign {
  /// The campaign's ID
  final String id;

  /// The campaign's name
  final String name;

  /// The campaign's description
  final String description;

  /// The campaign's currency
  final String currency;

  /// The campaign's identifier
  final String campaignIdentifier;

  /// The date and time that the campaign starts
  final String startsAt;

  /// The date and time that the campaign ends
  final String endsAt;

  /// The campaign's budget
  final AdminCampaignBudget budget;

  /// The date the campaign was created
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  /// The date the campaign was updated
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  /// The date the campaign was deleted
  @JsonKey(name: 'deleted_at')
  final DateTime? deletedAt;

  const AdminCampaign({
    required this.id,
    required this.name,
    required this.description,
    required this.currency,
    required this.campaignIdentifier,
    required this.startsAt,
    required this.endsAt,
    required this.budget,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory AdminCampaign.fromJson(Map<String, dynamic> json) =>
      _$AdminCampaignFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCampaignToJson(this);
}

/// Admin campaign budget from @medusajs/types AdminCampaign.budget
///
/// Defines spending or usage limits for a marketing campaign.
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCampaignBudget {
  /// The budget's ID
  final String id;

  /// The budget's type
  final AdminCampaignBudgetType type;

  /// The budget's currency code
  final String currencyCode;

  /// The budget's limit
  final double limit;

  /// How much of the budget has been used
  final double used;

  const AdminCampaignBudget({
    required this.id,
    required this.type,
    required this.currencyCode,
    required this.limit,
    required this.used,
  });

  factory AdminCampaignBudget.fromJson(Map<String, dynamic> json) =>
      _$AdminCampaignBudgetFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCampaignBudgetToJson(this);
}

/// Admin campaign budget type enumeration
enum AdminCampaignBudgetType {
  @JsonValue('spend')
  spend,
  @JsonValue('usage')
  usage,
}

// ==========================================
// Admin Promotion Request/Response Models
// ==========================================

/// Admin promotion response wrapper from @medusajs/types AdminPromotionResponse
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminPromotionResponse {
  /// The promotion's details
  final AdminPromotion promotion;

  const AdminPromotionResponse({required this.promotion});

  factory AdminPromotionResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminPromotionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminPromotionResponseToJson(this);
}

/// Admin promotion list response wrapper
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminPromotionListResponse {
  /// The promotions list
  final List<AdminPromotion> promotions;

  /// The total count of promotions
  final int count;

  /// The number of promotions to skip when retrieving
  final int offset;

  /// The number of items per page
  final int limit;

  const AdminPromotionListResponse({
    required this.promotions,
    required this.count,
    required this.offset,
    required this.limit,
  });

  factory AdminPromotionListResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminPromotionListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminPromotionListResponseToJson(this);
}

/// Admin promotion delete response
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminPromotionDeleteResponse {
  /// The deleted promotion's ID
  final String id;

  /// The type of object deleted
  final String object;

  /// Whether the deletion was successful
  final bool deleted;

  const AdminPromotionDeleteResponse({
    required this.id,
    required this.object,
    required this.deleted,
  });

  factory AdminPromotionDeleteResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminPromotionDeleteResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminPromotionDeleteResponseToJson(this);
}

/// Admin create promotion request
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCreatePromotion {
  /// The promotion's code
  final String? code;

  /// The promotion's type
  final AdminPromotionType type;

  /// Whether the promotion is applied on a cart automatically
  final bool? isAutomatic;

  /// The ID of the campaign this promotion belongs to
  final String? campaignId;

  /// The promotion's application method
  final AdminCreateApplicationMethod? applicationMethod;

  /// The promotion's rules
  final List<AdminCreatePromotionRule>? rules;

  /// The promotion's status
  final AdminPromotionStatus? status;

  const AdminCreatePromotion({
    required this.type,
    this.code,
    this.isAutomatic,
    this.campaignId,
    this.applicationMethod,
    this.rules,
    this.status,
  });

  factory AdminCreatePromotion.fromJson(Map<String, dynamic> json) =>
      _$AdminCreatePromotionFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCreatePromotionToJson(this);
}

/// Admin update promotion request
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminUpdatePromotion {
  /// The promotion's code
  final String? code;

  /// The promotion's type
  final AdminPromotionType? type;

  /// Whether the promotion is applied on a cart automatically
  final bool? isAutomatic;

  /// The ID of the campaign this promotion belongs to
  final String? campaignId;

  /// The promotion's status
  final AdminPromotionStatus? status;

  const AdminUpdatePromotion({
    this.code,
    this.type,
    this.isAutomatic,
    this.campaignId,
    this.status,
  });

  factory AdminUpdatePromotion.fromJson(Map<String, dynamic> json) =>
      _$AdminUpdatePromotionFromJson(json);

  Map<String, dynamic> toJson() => _$AdminUpdatePromotionToJson(this);
}

/// Admin create application method for creating application methods
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCreateApplicationMethod {
  /// The application method's type
  final AdminApplicationMethodType type;

  /// Which item does the promotion apply to
  final AdminApplicationMethodTargetType targetType;

  /// How is the promotion amount discounted
  final AdminApplicationMethodAllocation allocation;

  /// The amount to be discounted
  final double value;

  /// The application method's currency code
  final String? currencyCode;

  /// The max quantity allowed in the cart
  final double? maxQuantity;

  /// The minimum quantity required for buyget promotions
  final double? buyRulesMinQuantity;

  /// The quantity that results from matching buyget conditions
  final double? applyToQuantity;

  /// The application method's target rules
  final List<AdminCreatePromotionRule>? targetRules;

  /// The application method's buy rules
  final List<AdminCreatePromotionRule>? buyRules;

  const AdminCreateApplicationMethod({
    required this.type,
    required this.targetType,
    required this.allocation,
    required this.value,
    this.currencyCode,
    this.maxQuantity,
    this.buyRulesMinQuantity,
    this.applyToQuantity,
    this.targetRules,
    this.buyRules,
  });

  factory AdminCreateApplicationMethod.fromJson(Map<String, dynamic> json) =>
      _$AdminCreateApplicationMethodFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCreateApplicationMethodToJson(this);
}

/// Admin create promotion rule for creating promotion rules
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCreatePromotionRule {
  /// The promotion rule's description
  final String? description;

  /// The promotion rule's attribute
  final String attribute;

  /// The rule's operator
  final AdminPromotionRuleOperator operator;

  /// The rule's values
  final List<String> values;

  const AdminCreatePromotionRule({
    required this.attribute,
    required this.operator,
    required this.values,
    this.description,
  });

  factory AdminCreatePromotionRule.fromJson(Map<String, dynamic> json) =>
      _$AdminCreatePromotionRuleFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCreatePromotionRuleToJson(this);
}

/// Admin update promotion rule for updating existing promotion rules
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminUpdatePromotionRule {
  /// The promotion rule's ID
  final String id;

  /// The promotion rule's description
  final String? description;

  /// The promotion rule's attribute
  final String? attribute;

  /// The rule's operator
  final AdminPromotionRuleOperator? operator;

  /// The rule's values
  final List<String>? values;

  const AdminUpdatePromotionRule({
    required this.id,
    this.description,
    this.attribute,
    this.operator,
    this.values,
  });

  factory AdminUpdatePromotionRule.fromJson(Map<String, dynamic> json) =>
      _$AdminUpdatePromotionRuleFromJson(json);

  Map<String, dynamic> toJson() => _$AdminUpdatePromotionRuleToJson(this);
}
