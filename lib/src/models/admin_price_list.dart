///  Admin Price List models from @medusajs/types v2.10.1
///
/// Comprehensive price list management models following Medusa v2.10 specifications.
/// Covers price lists, prices, rules, and promotional pricing strategies.

import 'package:json_annotation/json_annotation.dart';

part 'admin_price_list.g.dart';

// ==========================================
// Core Admin Price List Models
// ==========================================

/// Admin price list from @medusajs/types AdminPriceList
///
/// Represents a collection of prices for products with specific rules,
/// used for promotions, customer-specific pricing, and sales campaigns.
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminPriceList {
  /// The price list's ID
  final String id;

  /// The price list's title
  final String title;

  /// The price list's description
  final String description;

  /// The price list's rules
  final Map<String, dynamic> rules;

  /// The date the price list starts
  @JsonKey(name: 'starts_at')
  final String? startsAt;

  /// The date the price list ends
  @JsonKey(name: 'ends_at')
  final String? endsAt;

  /// The price list's status
  final AdminPriceListStatus status;

  /// The price list's type
  final AdminPriceListType type;

  /// The price list's prices
  final List<AdminPriceListPrice> prices;

  /// The date the price list was created
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  /// The date the price list was updated
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  /// The date the price list was deleted
  @JsonKey(name: 'deleted_at')
  final DateTime? deletedAt;

  const AdminPriceList({
    required this.id,
    required this.title,
    required this.description,
    required this.rules,
    required this.status,
    required this.type,
    required this.prices,
    required this.createdAt,
    required this.updatedAt,
    this.startsAt,
    this.endsAt,
    this.deletedAt,
  });

  factory AdminPriceList.fromJson(Map<String, dynamic> json) =>
      _$AdminPriceListFromJson(json);

  Map<String, dynamic> toJson() => _$AdminPriceListToJson(this);
}

/// Admin price list status enumeration
enum AdminPriceListStatus {
  @JsonValue('draft')
  draft,
  @JsonValue('active')
  active,
}

/// Admin price list type enumeration
enum AdminPriceListType {
  @JsonValue('sale')
  sale,
  @JsonValue('override')
  override,
}

/// Admin price list price from @medusajs/types AdminPriceListPrice
///
/// Represents individual prices within a price list for specific variants.
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminPriceListPrice {
  /// The ID of the product variant this price list is for
  final String variantId;

  /// The price's rules
  final Map<String, dynamic> rules;

  /// The price's ID
  final String id;

  /// The price's title
  final String title;

  /// The price's currency code
  final String currencyCode;

  /// The price's amount
  final double amount;

  /// The price's raw amount
  final Map<String, dynamic> rawAmount;

  /// The price's minimum quantity
  final int? minQuantity;

  /// The price's maximum quantity
  final int? maxQuantity;

  /// The price set ID
  final String priceSetId;

  /// The date the price was created
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  /// The date the price was updated
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  /// The date the price was deleted
  @JsonKey(name: 'deleted_at')
  final DateTime? deletedAt;

  const AdminPriceListPrice({
    required this.variantId,
    required this.rules,
    required this.id,
    required this.title,
    required this.currencyCode,
    required this.amount,
    required this.rawAmount,
    required this.priceSetId,
    required this.createdAt,
    required this.updatedAt,
    this.minQuantity,
    this.maxQuantity,
    this.deletedAt,
  });

  factory AdminPriceListPrice.fromJson(Map<String, dynamic> json) =>
      _$AdminPriceListPriceFromJson(json);

  Map<String, dynamic> toJson() => _$AdminPriceListPriceToJson(this);
}

/// Admin price from @medusajs/types AdminPrice
///
/// Represents a price entity for batch operations.
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminPrice {
  /// The price's ID
  final String id;

  /// The price's title
  final String? title;

  /// The price's currency code
  final String currencyCode;

  /// The price's amount
  final double amount;

  /// The price's raw amount
  final Map<String, dynamic>? rawAmount;

  /// The price's minimum quantity
  final int? minQuantity;

  /// The price's maximum quantity
  final int? maxQuantity;

  /// The price set ID
  final String? priceSetId;

  /// The price's rules
  final Map<String, dynamic>? rules;

  /// The date the price was created
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  /// The date the price was updated
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  /// The date the price was deleted
  @JsonKey(name: 'deleted_at')
  final DateTime? deletedAt;

  const AdminPrice({
    required this.id,
    required this.currencyCode,
    required this.amount,
    this.title,
    this.rawAmount,
    this.minQuantity,
    this.maxQuantity,
    this.priceSetId,
    this.rules,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory AdminPrice.fromJson(Map<String, dynamic> json) =>
      _$AdminPriceFromJson(json);

  Map<String, dynamic> toJson() => _$AdminPriceToJson(this);
}

// ==========================================
// Admin Price List Request/Response Models
// ==========================================

/// Admin price list response wrapper from @medusajs/types AdminPriceListResponse
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminPriceListResponse {
  /// The price list's details
  final AdminPriceList priceList;

  const AdminPriceListResponse({required this.priceList});

  factory AdminPriceListResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminPriceListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminPriceListResponseToJson(this);
}

/// Admin price list list response wrapper
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminPriceListListResponse {
  /// The price lists list
  final List<AdminPriceList> priceLists;

  /// The total count of price lists
  final int count;

  /// The number of price lists to skip when retrieving
  final int offset;

  /// The number of items per page
  final int limit;

  const AdminPriceListListResponse({
    required this.priceLists,
    required this.count,
    required this.offset,
    required this.limit,
  });

  factory AdminPriceListListResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminPriceListListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminPriceListListResponseToJson(this);
}

/// Admin price list delete response
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminPriceListDeleteResponse {
  /// The deleted price list's ID
  final String id;

  /// The type of object deleted
  final String object;

  /// Whether the deletion was successful
  final bool deleted;

  const AdminPriceListDeleteResponse({
    required this.id,
    required this.object,
    required this.deleted,
  });

  factory AdminPriceListDeleteResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminPriceListDeleteResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminPriceListDeleteResponseToJson(this);
}

/// Admin create price list request from @medusajs/types AdminCreatePriceList
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCreatePriceList {
  /// The price list's title
  final String title;

  /// The price list's description
  final String description;

  /// The date and time the price list starts at
  @JsonKey(name: 'starts_at')
  final DateTime? startsAt;

  /// The date and time the price list ends at
  @JsonKey(name: 'ends_at')
  final DateTime? endsAt;

  /// The price list's status
  final AdminPriceListStatus? status;

  /// The price list's type
  final AdminPriceListType? type;

  /// The price list's rules
  final Map<String, dynamic>? rules;

  /// The price list's prices
  final List<AdminCreatePriceListPrice>? prices;

  const AdminCreatePriceList({
    required this.title,
    required this.description,
    this.startsAt,
    this.endsAt,
    this.status,
    this.type,
    this.rules,
    this.prices,
  });

  factory AdminCreatePriceList.fromJson(Map<String, dynamic> json) =>
      _$AdminCreatePriceListFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCreatePriceListToJson(this);
}

/// Admin update price list request from @medusajs/types AdminUpdatePriceList
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminUpdatePriceList {
  /// The price list's title
  final String? title;

  /// The price list's description
  final String? description;

  /// The date the price list starts
  @JsonKey(name: 'starts_at')
  final String? startsAt;

  /// The date the price list ends
  @JsonKey(name: 'ends_at')
  final String? endsAt;

  /// The price list's status
  final AdminPriceListStatus? status;

  /// The price list's type
  final AdminPriceListType? type;

  /// The price list's rules
  final Map<String, dynamic>? rules;

  const AdminUpdatePriceList({
    this.title,
    this.description,
    this.startsAt,
    this.endsAt,
    this.status,
    this.type,
    this.rules,
  });

  factory AdminUpdatePriceList.fromJson(Map<String, dynamic> json) =>
      _$AdminUpdatePriceListFromJson(json);

  Map<String, dynamic> toJson() => _$AdminUpdatePriceListToJson(this);
}

/// Admin create price list price for creating prices in a price list
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCreatePriceListPrice {
  /// The ID of the product variant this price is for
  final String variantId;

  /// The price's currency code
  final String currencyCode;

  /// The price's amount
  final double amount;

  /// The price's minimum quantity
  final int? minQuantity;

  /// The price's maximum quantity
  final int? maxQuantity;

  /// The price's rules
  final Map<String, dynamic>? rules;

  const AdminCreatePriceListPrice({
    required this.variantId,
    required this.currencyCode,
    required this.amount,
    this.minQuantity,
    this.maxQuantity,
    this.rules,
  });

  factory AdminCreatePriceListPrice.fromJson(Map<String, dynamic> json) =>
      _$AdminCreatePriceListPriceFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCreatePriceListPriceToJson(this);
}

// ==========================================
// Admin Price List Batch Operations Models
// ==========================================

/// Admin price list batch response from @medusajs/types AdminPriceListBatchResponse
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminPriceListBatchResponse {
  /// The created prices
  final List<AdminPrice> created;

  /// The updated prices
  final List<AdminPrice> updated;

  /// The details of the deleted prices
  final Map<String, dynamic> deleted;

  const AdminPriceListBatchResponse({
    required this.created,
    required this.updated,
    required this.deleted,
  });

  factory AdminPriceListBatchResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminPriceListBatchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminPriceListBatchResponseToJson(this);
}

/// Admin batch create price list prices request
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminBatchCreatePriceListPrices {
  /// The prices to create
  final List<AdminCreatePriceListPrice> create;

  const AdminBatchCreatePriceListPrices({required this.create});

  factory AdminBatchCreatePriceListPrices.fromJson(Map<String, dynamic> json) =>
      _$AdminBatchCreatePriceListPricesFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminBatchCreatePriceListPricesToJson(this);
}

/// Admin batch update price list prices request
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminBatchUpdatePriceListPrices {
  /// The prices to update
  final List<AdminUpdatePriceListPrice> update;

  const AdminBatchUpdatePriceListPrices({required this.update});

  factory AdminBatchUpdatePriceListPrices.fromJson(Map<String, dynamic> json) =>
      _$AdminBatchUpdatePriceListPricesFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminBatchUpdatePriceListPricesToJson(this);
}

/// Admin update price list price for updating existing prices
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminUpdatePriceListPrice {
  /// The price's ID
  final String id;

  /// The price's currency code
  final String? currencyCode;

  /// The price's amount
  final double? amount;

  /// The price's minimum quantity
  final int? minQuantity;

  /// The price's maximum quantity
  final int? maxQuantity;

  /// The price's rules
  final Map<String, dynamic>? rules;

  const AdminUpdatePriceListPrice({
    required this.id,
    this.currencyCode,
    this.amount,
    this.minQuantity,
    this.maxQuantity,
    this.rules,
  });

  factory AdminUpdatePriceListPrice.fromJson(Map<String, dynamic> json) =>
      _$AdminUpdatePriceListPriceFromJson(json);

  Map<String, dynamic> toJson() => _$AdminUpdatePriceListPriceToJson(this);
}

/// Admin batch delete price list prices request
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminBatchDeletePriceListPrices {
  /// The price IDs to delete
  final List<String> delete;

  const AdminBatchDeletePriceListPrices({required this.delete});

  factory AdminBatchDeletePriceListPrices.fromJson(Map<String, dynamic> json) =>
      _$AdminBatchDeletePriceListPricesFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminBatchDeletePriceListPricesToJson(this);
}
