///  Admin Stock Location models from @medusajs/types v2.10.1
///
/// Comprehensive stock location management models following Medusa v2.10 specifications.
/// Covers stock locations, addresses, fulfillment sets, and inventory levels.

import 'package:json_annotation/json_annotation.dart';
import 'admin_inventory_item.dart' show AdminInventoryLevel;

part 'admin_stock_location.g.dart';

// ==========================================
// Core Admin Stock Location Models
// ==========================================

/// Admin stock location from @medusajs/types AdminStockLocation
///
/// Represents a physical location where inventory is stored,
/// including address details, fulfillment providers, and sales channels.
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminStockLocation {
  /// The location's ID
  final String id;

  /// The location's name
  final String name;

  /// The ID of the associated address
  final String addressId;

  /// The stock location's address details
  final AdminStockLocationAddress? address;

  /// The sales channels associated with the location
  final List<AdminSalesChannel>? salesChannels;

  /// The fulfillment providers associated with the location
  final List<AdminFulfillmentProvider>? fulfillmentProviders;

  /// The fulfillment sets associated with the location
  final List<Map<String, dynamic>>? fulfillmentSets;

  const AdminStockLocation({
    required this.id,
    required this.name,
    required this.addressId,
    this.address,
    this.salesChannels,
    this.fulfillmentProviders,
    this.fulfillmentSets,
  });

  factory AdminStockLocation.fromJson(Map<String, dynamic> json) =>
      _$AdminStockLocationFromJson(json);

  Map<String, dynamic> toJson() => _$AdminStockLocationToJson(this);
}

/// Admin stock location address from @medusajs/types AdminStockLocationAddress
///
/// Represents the detailed address information for a stock location.
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminStockLocationAddress {
  /// The address's ID
  final String id;

  /// The address's first line
  final String address1;

  /// The address's second line
  final String address2;

  /// The address's company
  final String company;

  /// The address's country code
  final String countryCode;

  /// The address's city
  final String city;

  /// The address's phone
  final String phone;

  /// The address's postal code
  final String postalCode;

  /// The address's lower-case ISO 3166-2 province code
  final String province;

  const AdminStockLocationAddress({
    required this.id,
    required this.address1,
    required this.address2,
    required this.company,
    required this.countryCode,
    required this.city,
    required this.phone,
    required this.postalCode,
    required this.province,
  });

  factory AdminStockLocationAddress.fromJson(Map<String, dynamic> json) =>
      _$AdminStockLocationAddressFromJson(json);

  Map<String, dynamic> toJson() => _$AdminStockLocationAddressToJson(this);
}

/// Admin sales channel (simplified reference)
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminSalesChannel {
  /// The sales channel's ID
  final String id;

  /// The sales channel's name
  final String? name;

  /// The sales channel's description
  final String? description;

  const AdminSalesChannel({required this.id, this.name, this.description});

  factory AdminSalesChannel.fromJson(Map<String, dynamic> json) =>
      _$AdminSalesChannelFromJson(json);

  Map<String, dynamic> toJson() => _$AdminSalesChannelToJson(this);
}

/// Admin fulfillment provider (simplified reference)
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminFulfillmentProvider {
  /// The fulfillment provider's ID
  final String id;

  /// The fulfillment provider's name
  final String? name;

  /// Whether the provider is enabled
  final bool? isEnabled;

  const AdminFulfillmentProvider({required this.id, this.name, this.isEnabled});

  factory AdminFulfillmentProvider.fromJson(Map<String, dynamic> json) =>
      _$AdminFulfillmentProviderFromJson(json);

  Map<String, dynamic> toJson() => _$AdminFulfillmentProviderToJson(this);
}

// ==========================================
// Admin Stock Location Request/Response Models
// ==========================================

/// Admin stock location response wrapper from @medusajs/types AdminStockLocationResponse
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminStockLocationResponse {
  /// The stock location's details
  final AdminStockLocation stockLocation;

  const AdminStockLocationResponse({required this.stockLocation});

  factory AdminStockLocationResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminStockLocationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminStockLocationResponseToJson(this);
}

/// Admin stock location list response wrapper from @medusajs/types AdminStockLocationListResponse
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminStockLocationListResponse {
  /// The stock locations list
  final List<AdminStockLocation> stockLocations;

  /// The total count of stock locations
  final int count;

  /// The number of stock locations to skip when retrieving
  final int offset;

  /// The number of items per page
  final int limit;

  const AdminStockLocationListResponse({
    required this.stockLocations,
    required this.count,
    required this.offset,
    required this.limit,
  });

  factory AdminStockLocationListResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminStockLocationListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminStockLocationListResponseToJson(this);
}

/// Admin stock location delete response from @medusajs/types AdminStockLocationDeleteResponse
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminStockLocationDeleteResponse {
  /// The deleted stock location's ID
  final String id;

  /// The type of object deleted
  final String object;

  /// Whether the deletion was successful
  final bool deleted;

  const AdminStockLocationDeleteResponse({
    required this.id,
    required this.object,
    required this.deleted,
  });

  factory AdminStockLocationDeleteResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$AdminStockLocationDeleteResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminStockLocationDeleteResponseToJson(this);
}

/// Admin create stock location request from @medusajs/types AdminCreateStockLocation
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCreateStockLocation {
  /// The stock location's name
  final String name;

  /// The ID of the stock location's address
  final String? addressId;

  /// The stock location's address details to create
  final AdminUpsertStockLocationAddress? address;

  /// The stock location's metadata for custom key-value pairs
  final Map<String, dynamic>? metadata;

  const AdminCreateStockLocation({
    required this.name,
    this.addressId,
    this.address,
    this.metadata,
  });

  factory AdminCreateStockLocation.fromJson(Map<String, dynamic> json) =>
      _$AdminCreateStockLocationFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCreateStockLocationToJson(this);
}

/// Admin update stock location request from @medusajs/types AdminUpdateStockLocation
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminUpdateStockLocation {
  /// The stock location's name
  final String? name;

  /// The stock location's address details to update
  final AdminUpdateStockLocationAddress? address;

  /// The stock location's metadata for custom key-value pairs
  final Map<String, dynamic>? metadata;

  const AdminUpdateStockLocation({this.name, this.address, this.metadata});

  factory AdminUpdateStockLocation.fromJson(Map<String, dynamic> json) =>
      _$AdminUpdateStockLocationFromJson(json);

  Map<String, dynamic> toJson() => _$AdminUpdateStockLocationToJson(this);
}

/// Admin upsert stock location address from @medusajs/types AdminUpsertStockLocationAddress
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminUpsertStockLocationAddress {
  /// The address's first line
  final String address1;

  /// The address's second line
  final String? address2;

  /// The address's company
  final String? company;

  /// The address's country code
  final String countryCode;

  /// The address's city
  final String? city;

  /// The address's phone
  final String? phone;

  /// The address's postal code
  final String? postalCode;

  /// The address's ISO 3166-2 province code (lower-case)
  final String? province;

  const AdminUpsertStockLocationAddress({
    required this.address1,
    required this.countryCode,
    this.address2,
    this.company,
    this.city,
    this.phone,
    this.postalCode,
    this.province,
  });

  factory AdminUpsertStockLocationAddress.fromJson(Map<String, dynamic> json) =>
      _$AdminUpsertStockLocationAddressFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminUpsertStockLocationAddressToJson(this);
}

/// Admin update stock location address (inline object from AdminUpdateStockLocation)
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminUpdateStockLocationAddress {
  /// The address's first line
  final String address1;

  /// The address's second line
  final String? address2;

  /// The address's company
  final String? company;

  /// The address's city
  final String? city;

  /// The address's country code
  final String countryCode;

  /// The address's phone
  final String? phone;

  /// The address's postal code
  final String? postalCode;

  /// The address's province code
  final String? province;

  const AdminUpdateStockLocationAddress({
    required this.address1,
    required this.countryCode,
    this.address2,
    this.company,
    this.city,
    this.phone,
    this.postalCode,
    this.province,
  });

  factory AdminUpdateStockLocationAddress.fromJson(Map<String, dynamic> json) =>
      _$AdminUpdateStockLocationAddressFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminUpdateStockLocationAddressToJson(this);
}

// ==========================================
// Admin Stock Location Inventory Models
// ==========================================

/// Admin stock location inventory level response
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminStockLocationInventoryLevelResponse {
  /// The inventory level details
  final AdminInventoryLevel inventoryLevel;

  const AdminStockLocationInventoryLevelResponse({
    required this.inventoryLevel,
  });

  factory AdminStockLocationInventoryLevelResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$AdminStockLocationInventoryLevelResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminStockLocationInventoryLevelResponseToJson(this);
}

/// Admin stock location inventory levels list response
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminStockLocationInventoryLevelsResponse {
  /// The inventory levels list
  final List<AdminInventoryLevel> inventoryLevels;

  /// The total count of inventory levels
  final int count;

  /// The number of inventory levels to skip when retrieving
  final int offset;

  /// The number of items per page
  final int limit;

  const AdminStockLocationInventoryLevelsResponse({
    required this.inventoryLevels,
    required this.count,
    required this.offset,
    required this.limit,
  });

  factory AdminStockLocationInventoryLevelsResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$AdminStockLocationInventoryLevelsResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminStockLocationInventoryLevelsResponseToJson(this);
}

// ==========================================
// Admin Stock Location Fulfillment Models
// ==========================================

/// Admin stock location fulfillment sets response
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminStockLocationFulfillmentSetsResponse {
  /// The fulfillment sets list
  final List<Map<String, dynamic>> fulfillmentSets;

  /// The total count of fulfillment sets
  final int count;

  /// The number of fulfillment sets to skip when retrieving
  final int offset;

  /// The number of items per page
  final int limit;

  const AdminStockLocationFulfillmentSetsResponse({
    required this.fulfillmentSets,
    required this.count,
    required this.offset,
    required this.limit,
  });

  factory AdminStockLocationFulfillmentSetsResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$AdminStockLocationFulfillmentSetsResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminStockLocationFulfillmentSetsResponseToJson(this);
}

/// Admin add fulfillment set request
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminAddFulfillmentSetRequest {
  /// The fulfillment set ID to add
  final String fulfillmentSetId;

  const AdminAddFulfillmentSetRequest({required this.fulfillmentSetId});

  factory AdminAddFulfillmentSetRequest.fromJson(Map<String, dynamic> json) =>
      _$AdminAddFulfillmentSetRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AdminAddFulfillmentSetRequestToJson(this);
}

// ==========================================
// Re-export AdminInventoryLevel from inventory_item_canonical
// ==========================================

// Note: AdminInventoryLevel is already defined in admin_inventory_item.dart
// We'll import and re-use it here when migrating the resource
