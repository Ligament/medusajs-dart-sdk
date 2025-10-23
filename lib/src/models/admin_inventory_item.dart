///  Admin Inventory Item models from @medusajs/types v2.10.1
///
/// Comprehensive inventory management models following Medusa v2.10 specifications.
/// Covers inventory items, location levels, and related management structures.

import 'package:json_annotation/json_annotation.dart';

part 'admin_inventory_item.g.dart';

// ==========================================
// Core Admin Inventory Item Models
// ==========================================

/// Admin inventory item from @medusajs/types AdminInventoryItem
///
/// Represents a physical product or variant for inventory tracking,
/// including dimensions, shipping requirements, and location levels.
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminInventoryItem {
  /// The inventory item's ID
  final String id;

  /// Whether the inventory item requires shipping
  final bool requiresShipping;

  /// The inventory item's SKU
  final String? sku;

  /// The inventory item's origin country
  final String? originCountry;

  /// The inventory item's HS code
  final String? hsCode;

  /// The inventory item's MID code
  final String? midCode;

  /// The inventory item's material
  final String? material;

  /// The inventory item's weight
  final double? weight;

  /// The inventory item's length
  final double? length;

  /// The inventory item's height
  final double? height;

  /// The inventory item's width
  final double? width;

  /// The inventory item's title
  final String? title;

  /// The inventory item's description
  final String? description;

  /// The thumbnail URL of the inventory item
  final String? thumbnail;

  /// Custom key-value pairs for additional information
  final Map<String, dynamic>? metadata;

  /// The inventory item's location levels
  final List<AdminInventoryLevel>? locationLevels;

  const AdminInventoryItem({
    required this.id,
    required this.requiresShipping,
    this.sku,
    this.originCountry,
    this.hsCode,
    this.midCode,
    this.material,
    this.weight,
    this.length,
    this.height,
    this.width,
    this.title,
    this.description,
    this.thumbnail,
    this.metadata,
    this.locationLevels,
  });

  factory AdminInventoryItem.fromJson(Map<String, dynamic> json) =>
      _$AdminInventoryItemFromJson(json);

  Map<String, dynamic> toJson() => _$AdminInventoryItemToJson(this);
}

/// Admin inventory level from @medusajs/types AdminInventoryLevel
///
/// Represents inventory quantities at a specific location,
/// tracking stocked, reserved, incoming, and available quantities.
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminInventoryLevel {
  /// The location level's ID
  final String id;

  /// The location level's created at timestamp
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  /// The location level's updated at timestamp
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  /// The location level's deleted at timestamp
  @JsonKey(name: 'deleted_at')
  final DateTime? deletedAt;

  /// The location level's inventory item id
  final String inventoryItemId;

  /// The location level's location id
  final String locationId;

  /// The location level's stocked quantity
  final double stockedQuantity;

  /// The location level's reserved quantity
  final double reservedQuantity;

  /// The location level's incoming quantity
  final double incomingQuantity;

  /// The location level's available quantity
  final double availableQuantity;

  /// The location level's metadata
  final Map<String, dynamic>? metadata;

  /// The inventory item reference (object placeholder)
  final Map<String, dynamic>? inventoryItem;

  const AdminInventoryLevel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.inventoryItemId,
    required this.locationId,
    required this.stockedQuantity,
    required this.reservedQuantity,
    required this.incomingQuantity,
    required this.availableQuantity,
    this.metadata,
    this.inventoryItem,
  });

  factory AdminInventoryLevel.fromJson(Map<String, dynamic> json) =>
      _$AdminInventoryLevelFromJson(json);

  Map<String, dynamic> toJson() => _$AdminInventoryLevelToJson(this);
}

// ==========================================
// Admin Inventory Item Request/Response Models
// ==========================================

/// Admin inventory item response wrapper from @medusajs/types AdminInventoryItemResponse
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminInventoryItemResponse {
  /// The inventory item's details
  final AdminInventoryItem inventoryItem;

  const AdminInventoryItemResponse({required this.inventoryItem});

  factory AdminInventoryItemResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminInventoryItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminInventoryItemResponseToJson(this);
}

/// Admin inventory item list response wrapper
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminInventoryItemListResponse {
  /// The inventory items list
  final List<AdminInventoryItem> inventoryItems;

  /// The total count of inventory items
  final int count;

  /// The number of inventory items to skip when retrieving
  final int offset;

  /// The number of items per page
  final int limit;

  const AdminInventoryItemListResponse({
    required this.inventoryItems,
    required this.count,
    required this.offset,
    required this.limit,
  });

  factory AdminInventoryItemListResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminInventoryItemListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminInventoryItemListResponseToJson(this);
}

/// Admin create inventory item request from @medusajs/types AdminCreateInventoryItem
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCreateInventoryItem {
  /// The inventory item's SKU
  final String? sku;

  /// The inventory item's HS code
  final String? hsCode;

  /// The inventory item's weight
  final double? weight;

  /// The inventory item's length
  final double? length;

  /// The inventory item's height
  final double? height;

  /// The inventory item's width
  final double? width;

  /// The inventory item's origin country
  final String? originCountry;

  /// The inventory item's mid code
  final String? midCode;

  /// The inventory item's material
  final String? material;

  /// The inventory item's title
  final String? title;

  /// The description of the variant associated with the inventory item
  final String? description;

  /// Whether the item requires shipping
  final bool? requiresShipping;

  /// The thumbnail URL of the inventory item
  final String? thumbnail;

  /// Custom key-value pairs for additional information
  final Map<String, dynamic>? metadata;

  const AdminCreateInventoryItem({
    this.sku,
    this.hsCode,
    this.weight,
    this.length,
    this.height,
    this.width,
    this.originCountry,
    this.midCode,
    this.material,
    this.title,
    this.description,
    this.requiresShipping,
    this.thumbnail,
    this.metadata,
  });

  factory AdminCreateInventoryItem.fromJson(Map<String, dynamic> json) =>
      _$AdminCreateInventoryItemFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCreateInventoryItemToJson(this);
}

/// Admin update inventory item request from @medusajs/types AdminUpdateInventoryItem
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminUpdateInventoryItem {
  /// The inventory item's SKU
  final String? sku;

  /// The inventory item's HS code
  final String? hsCode;

  /// The inventory item's weight
  final double? weight;

  /// The inventory item's length
  final double? length;

  /// The inventory item's height
  final double? height;

  /// The inventory item's width
  final double? width;

  /// The inventory item's origin country
  final String? originCountry;

  /// The inventory item's mid code
  final String? midCode;

  /// The inventory item's material
  final String? material;

  /// The inventory item's title
  final String? title;

  /// The description of the variant associated with the inventory item
  final String? description;

  /// Whether the item requires shipping
  final bool? requiresShipping;

  /// The thumbnail URL of the inventory item
  final String? thumbnail;

  /// Custom key-value pairs for additional information
  final Map<String, dynamic>? metadata;

  const AdminUpdateInventoryItem({
    this.sku,
    this.hsCode,
    this.weight,
    this.length,
    this.height,
    this.width,
    this.originCountry,
    this.midCode,
    this.material,
    this.title,
    this.description,
    this.requiresShipping,
    this.thumbnail,
    this.metadata,
  });

  factory AdminUpdateInventoryItem.fromJson(Map<String, dynamic> json) =>
      _$AdminUpdateInventoryItemFromJson(json);

  Map<String, dynamic> toJson() => _$AdminUpdateInventoryItemToJson(this);
}

// ==========================================
// Admin Inventory Level Management Models
// ==========================================

/// Admin inventory level response wrapper
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminInventoryLevelResponse {
  /// The inventory level details
  final AdminInventoryLevel inventoryLevel;

  const AdminInventoryLevelResponse({required this.inventoryLevel});

  factory AdminInventoryLevelResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminInventoryLevelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminInventoryLevelResponseToJson(this);
}

/// Admin inventory levels list response wrapper
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminInventoryLevelListResponse {
  /// The inventory levels list
  final List<AdminInventoryLevel> inventoryLevels;

  /// The total count of inventory levels
  final int count;

  /// The number of inventory levels to skip when retrieving
  final int offset;

  /// The number of items per page
  final int limit;

  const AdminInventoryLevelListResponse({
    required this.inventoryLevels,
    required this.count,
    required this.offset,
    required this.limit,
  });

  factory AdminInventoryLevelListResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminInventoryLevelListResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminInventoryLevelListResponseToJson(this);
}

/// Admin create inventory level request
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCreateInventoryLevel {
  /// The location ID
  final String locationId;

  /// The stocked quantity at this location
  final double? stockedQuantity;

  /// Custom metadata
  final Map<String, dynamic>? metadata;

  const AdminCreateInventoryLevel({
    required this.locationId,
    this.stockedQuantity,
    this.metadata,
  });

  factory AdminCreateInventoryLevel.fromJson(Map<String, dynamic> json) =>
      _$AdminCreateInventoryLevelFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCreateInventoryLevelToJson(this);
}

/// Admin update inventory level request
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminUpdateInventoryLevel {
  /// The stocked quantity at this location
  final double? stockedQuantity;

  /// The incoming quantity at this location
  final double? incomingQuantity;

  /// Custom metadata
  final Map<String, dynamic>? metadata;

  const AdminUpdateInventoryLevel({
    this.stockedQuantity,
    this.incomingQuantity,
    this.metadata,
  });

  factory AdminUpdateInventoryLevel.fromJson(Map<String, dynamic> json) =>
      _$AdminUpdateInventoryLevelFromJson(json);

  Map<String, dynamic> toJson() => _$AdminUpdateInventoryLevelToJson(this);
}

// ==========================================
// Admin Batch Inventory Operations Models
// ==========================================

/// Admin batch create inventory items location levels
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminBatchCreateInventoryItemsLocationLevels {
  /// The inventory item ID
  final String inventoryItemId;

  /// The location ID
  final String locationId;

  /// The stocked quantity
  final double? stockedQuantity;

  /// Custom metadata
  final Map<String, dynamic>? metadata;

  const AdminBatchCreateInventoryItemsLocationLevels({
    required this.inventoryItemId,
    required this.locationId,
    this.stockedQuantity,
    this.metadata,
  });

  factory AdminBatchCreateInventoryItemsLocationLevels.fromJson(
    Map<String, dynamic> json,
  ) => _$AdminBatchCreateInventoryItemsLocationLevelsFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminBatchCreateInventoryItemsLocationLevelsToJson(this);
}

/// Admin batch update inventory items location levels
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminBatchUpdateInventoryItemsLocationLevels {
  /// The inventory item ID
  final String inventoryItemId;

  /// The location ID
  final String locationId;

  /// The stocked quantity to update
  final double? stockedQuantity;

  /// The incoming quantity to update
  final double? incomingQuantity;

  /// Custom metadata
  final Map<String, dynamic>? metadata;

  const AdminBatchUpdateInventoryItemsLocationLevels({
    required this.inventoryItemId,
    required this.locationId,
    this.stockedQuantity,
    this.incomingQuantity,
    this.metadata,
  });

  factory AdminBatchUpdateInventoryItemsLocationLevels.fromJson(
    Map<String, dynamic> json,
  ) => _$AdminBatchUpdateInventoryItemsLocationLevelsFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminBatchUpdateInventoryItemsLocationLevelsToJson(this);
}
